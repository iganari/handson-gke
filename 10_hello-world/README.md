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

docker build . --tag gcr.io/${_project}/hello-gke-go:v1
docker push gcr.io/${_project}/hello-gke-go:v1

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

## Create GKE Cluster

下記を参考に GKE クラスタを作成する


```
bash ../00_basic-cluster/operate-basic-cluster.sh create ${_project} ${_common} ${_region}
```

## Auth GKE

```
gcloud beta container clusters get-credentials ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_project}
```

## Create Namespace

+ Create Resource

```
kubectl create -f 01_namespace.yaml
```

+ Check Resource

```
kubectl get namespace
```
```
### Ex.

# kubectl get namespace
NAME                 STATUS   AGE
default              Active   10m
hello-world-common   Active   52s
hello-world-golang   Active   52s
hello-world-python   Active   52s
kube-node-lease      Active   10m
kube-public          Active   10m
kube-system          Active   10m
```

## Create Deployment

WIP

## Create Service

WIP

## Check Brawser

WIP

## Delete K8s Resource

+ Delete Namespace

```
kubectl delete -f 01_namespace.yaml
```

## Delete GKE Cluster

```
bash ../00_basic-cluster/operate-basic-cluster.sh delete ${_project} ${_common} ${_region}
```
