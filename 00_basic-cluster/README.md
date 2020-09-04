# Basic Cluster

参考 URL

https://github.com/iganari/package-gcp/blob/master/kubernetes/basic-cluster/gcloud/README.ja.md

## GCP との認証をする

```
gcloud auth login -q
```

## 環境変数を入れる

```
export _common='hogehoge'
export _project='fugafuga'
```

## GKE クラスタ作成スクリプト

```
bash operate-basic-cluster.sh create ${_project} ${_common}
```
