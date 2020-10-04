# batch system

:warning: WIP

## メモ

+ 使用しているクラスターを定期的に0ノードにする停止するいい感じのスクリプトを作っておく
+ 応用が聞く感じにしておきたい

## GCP との認証をする

```
gcloud auth login -q
```

## 環境変数を入れる

```
export _project='Your GCP Project ID'
export _common='handson-gke'
export _region='asia-northeast1'
```

## Create GKE Cluster

+ スクリプトで GKE クラスタを作成する

```
bash ../00_basic-cluster/operate-basic-cluster.sh create ${_project} ${_common} ${_region}
```

## Prepare API

+ Enable API on Project

```
gcloud config set project ${_project}
gcloud beta services enable sourcerepo.googleapis.com
gcloud beta services enable cloudbuild.googleapis.com
gcloud beta services enable cloudscheduler.googleapis.com
gcloud beta services enable appengine.googleapis.com
```

## Add Permission to Service Account of Cloud build


```
gcloud beta iam service-accounts list --project ${_project}
```

+ Check Service account email of Cloud Build

```
export _cloud_build_sa_email=$(gcloud beta projects get-iam-policy ${_project} --format=json | jq -r '.bindings[] | select(.role == "roles/cloudbuild.builds.builder") | .members[]')

echo ${_cloud_build_email}
```

+ Add Permission

```
gcloud beta projects add-iam-policy-binding ${_project} --member=${_cloud_build_sa_email} --role=roles/container.admin
```

+ ReCheck Service account email of Cloud Build

```
WIP
```

## Source Repository の作成と登録

+ Create Source Repository

```
export _repo_name='handson-gke-gsr'

gcloud beta source repos create ${_repo_name} --project ${_project}
```

+ Check Source Repository

```
gcloud beta source repos list --project ${_project} | grep ${_repo_name}
```
```
### Ex.

# gcloud beta source repos list --project ${_project} | grep ${_repo_name}
handson-gke-gsr  'your-gcp-project-id'  https://source.developers.google.com/p/your-gcp-project-id/r/handson-gke-gsr
```

+ Add git remote repository

```
git remote add gsr $(gcloud beta source repos list --project ${_project} | grep ${_repo_name} | awk '{print $3}')
```

+ Check git remote repository

```
# git remote -v
origin      https://github.com/iganari/handson-gke.git (fetch)
origin      https://github.com/iganari/handson-gke.git (push)
gsr         https://source.developers.google.com/p/your-gcp-project-id/r/handson-gke-gsr (fetch)
gsr         https://source.developers.google.com/p/your-gcp-project-id/r/handson-gke-gsr (push)
```

+ Push to GSR

```
git push gsr master
```

## Trigger の作成と実行

+ create Trigger of scale-in 

```
gcloud beta builds triggers create cloud-source-repositories \
  --repo ${_repo_name} \
  --name "gke-scale-in" \
  --branch-pattern "^master$" \
  --build-config 01_batch-system/builds/cloudbuild_gke-scale.yaml \
  --substitutions _NUM_NODE=0,_PROJCT_ID=${_project},_CLUSTER="${_common}-zonal",_ZONE="${_region}-a",_NODE_POOL="${_common}-zonal-nodepool" \
  --project ${_project}
```

+ create Trigger of scale-out 

```
gcloud beta builds triggers create cloud-source-repositories \
  --repo ${_repo_name} \
  --name "gke-scale-out" \
  --branch-pattern "^master$" \
  --build-config 01_batch-system/builds/cloudbuild_gke-scale.yaml \
  --substitutions _NUM_NODE=1,_PROJCT_ID=${_project},_CLUSTER="${_common}-zonal",_ZONE="${_region}-a",_NODE_POOL="${_common}-zonal-nodepool" \
  --project ${_project}
```

+ 実行してみる

```
gcloud beta builds triggers run gke-scale-in  --branch master
gcloud beta builds triggers run gke-scale-out --branch master
```

## Pub/Sub の Topic を作成

+ topic の作成

```
export _topic_name='gke-scale'

gcloud pubsub topics create ${_topic_name} --project ${_project}
```

## Cloud Scheduler の作成と実行

WIP

```
gcloud beta scheduler jobs create pubsub gke_node_scalse_in \
  --description 'GKE node Scale In' \
  --schedule '0 22 * * *' \
  --time-zone 'Asia/Tokyo' \
  --topic "projects/${_project}/topics/${_topic_name}" \
  --message-body 'GKE node Scale In' \
  --attributes 'foo=bar' \
  --project ${_project}
```





## Cloud Fucntions の作成

WIP



