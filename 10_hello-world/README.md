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
### New Env

export _project='Your GCP Project ID'
export _common='handson-gke'
export _region='asia-northeast1'
```

## Auth GCP

```
gcloud auth login -q
```

## Deploy Image for Container Registry

+ Google Container Registry の認証

```
gcloud auth configure-docker
```

+ go 用の Container Image を Push する

```
cd go

docker build . --tag gcr.io/${_project}/handson-gke_hello-world-go:v1
docker push gcr.io/${_project}/handson-gke_hello-world-go:v1

cd -
```

+ Python 用の Container Image を Push する

```
cd python

docker build . --tag gcr.io/${_project}/handson-gke_hello-world-python:v1
docker push gcr.io/${_project}/handson-gke_hello-world-python:v1

cd -
```

+ Check Images

```
gcloud beta container images list --project ${_project}
```

## Create GKE Cluster

+ スクリプトで GKE クラスタを作成する

```
bash ../00_basic-cluster/operate-basic-cluster.sh create ${_project} ${_common} ${_region}
```

## Auth GKE Cluster

+ 作成したクラスターに認証を通す

```
gcloud beta container clusters get-credentials ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_project}
```

## Create Go Resource

+ Create YAML 

```
sed "s/YOUR_PROJECT/${_project}/g" hello-world-go.yaml.template > hello-world-go.yaml
```

+ Create Go Resource on Cluster

```
kubectl create -f hello-world-go.yaml
```

## Create Python Resource

+ Create YAML 

```
sed "s/YOUR_PROJECT/${_project}/g" hello-world-python.yaml.template > hello-world-python.yaml
```

+ Create Python Resource on Cluster

```
kubectl create -f hello-world-python.yaml
```

## Create Mix Resource

+ Create YAML 

```
sed "s/YOUR_PROJECT/${_project}/g" hello-world-mix.yaml.template > hello-world-mix.yaml
```

+ Create Go & Python Resource on Cluster

```
kubectl create -f hello-world-mix.yaml
```

## Check Browser

WIP


## Delete K8s Resource

+ Delete 

```
kubectl delete -f hello-world-go.yaml
kubectl delete -f hello-world-python.yaml
kubectl delete -f hello-world-mix.yaml
```

## Delete Container Registry

+ コンテナレジストリの確認

```
gcloud beta container images list --project ${_project}
```

+ WIP

```
gcloud beta container images delete gcr.io/${_project}/handson-gke_hello-world-go:v1 --project ${_project}

gcloud beta container images delete gcr.io/ca-igarashi-gke-sample/handson-gke_hello-world-python:v1 --project ${_project}
```

## Delete GKE Cluster

```
bash ../00_basic-cluster/operate-basic-cluster.sh delete ${_project} ${_common} ${_region}
```

## Advansed

+ GKE
  + node を drain 後に外す > node 削除 > Pod の再配置
