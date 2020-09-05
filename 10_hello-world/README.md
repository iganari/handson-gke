# Hands On GKE Hello World

## 概要

```
hogehoge
```

+ 以下のクラスタを作成したとする
  + Cluster name = `handson-gke`
  + Zonal Cluster
  + Zone = `asia-northeast1-a`

```
export _project='Your GCP Project ID'
export _common='handson-gke'
export _region='asia-northeast1'
```


## GCP との認証をする

```
gcloud auth login -q
```

## Deploy Image for Container Registry

```
gcloud auth configure-docker
```
```
cd go

docker build . --tag gcr.io/${_project}/handson-gke_hello-world-go:v1
docker push gcr.io/${_project}/handson-gke_hello-world-go:v1

cd -
```
```
cd python
```
```
gcloud hogehoge
```
```
cd -
```

+ Check Images

```
gcloud beta container images list --project ${_project}
```

## Create GKE Cluster

スクリプトで GKE クラスタを作成する


```
bash ../00_basic-cluster/operate-basic-cluster.sh create ${_project} ${_common} ${_region}
```

## Auth GKE

```
gcloud beta container clusters get-credentials ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_project}
```

## Create Go 

+ Create YAML 

```
sed "s/YOUR_PROJECT/${_project}/g" hello-world-go.yaml.template > hello-world-go.yaml
```

```
kubectl create -f hello-world-go.yaml
```

## WIP Create Namespace

WIP

## Create Deployment

WIP

## Create Service

WIP

## Check Brawser

WIP

## Delete K8s Resource

+ Delete Namespace

```
kubectl delete -f hello-world-go.yaml
```

## Delete Container Registry

```
gcloud beta container images list --project ${_project}

gcloud beta container images delete gcr.io/${_project}/handson-gke_hello-world-go:v1 --project ${_project}
```

## Delete GKE Cluster

```
bash ../00_basic-cluster/operate-basic-cluster.sh delete ${_project} ${_common} ${_region}
```

## Advansed

+ K8s
  + 一つのドメインで go, python をだし分ける( `/go` -> go, `/py` -> python)
+ GKE
  + node を drain 後に外す > node 削除 > Pod の再配置