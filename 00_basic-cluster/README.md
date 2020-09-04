# Basic Cluster

参考 URL

https://github.com/iganari/package-gcp/blob/master/kubernetes/basic-cluster/gcloud/README.ja.md

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

## GKE クラスタの作成

```
bash operate-basic-cluster.sh create ${_project} ${_common} ${_region}
```

## GKE との認証

```
gcloud beta container clusters get-credentials ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_project}
```

## GKE クラスタの削除

```
bash operate-basic-cluster.sh delete ${_project} ${_common} ${_region}
```
