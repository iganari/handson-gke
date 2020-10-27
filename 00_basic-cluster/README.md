# Basic Cluster

参考 URL

https://github.com/iganari/package-gcp/blob/master/kubernetes/basic-cluster/gcloud/README.ja.md

## GCP との認証をする

```
gcloud auth login -q
```

## 環境変数を入れる

```
export _gcp_pj_id='Your GCP Project ID'
export _common='handson-gke'
export _region='asia-northeast1'
```

## [WIP] Prepare API

+ Enable API on Project

```
gcloud config set project ${_gcp_pj_id}
gcloud beta services enable hogehoge.googleapis.com
```


## GKE クラスタの作成

```
bash operate-basic-cluster.sh create ${_gcp_pj_id} ${_common} ${_region}
```

## GKE との認証

```
gcloud beta container clusters get-credentials ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_gcp_pj_id}
```

## GKE クラスタの削除

```
bash operate-basic-cluster.sh delete ${_gcp_pj_id} ${_common} ${_region}
```
