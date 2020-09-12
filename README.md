# Hands On GKE

## 必要なもの

+ GCP Project

## 先にインストールしておきたいコマンド

+ 公式ドキュメント
  + https://cloud.google.com/sdk/install?hl=en

### [gcloud] install

+ Debian and Ubuntu only
  + https://cloud.google.com/sdk/docs/downloads-apt-get?hl=en
+ Red Hat and CentOS
  + https://cloud.google.com/sdk/docs/downloads-yum?hl=en

### [gcloud] Update

```
gcloud components install beta -q &&\
gcloud components update -q && \
gcloud components install kubectl -q
```

## 使用するコマンドについて

詳しくは以下を参照

+ gcloud
  + 独自にまとめているもの
    + https://github.com/iganari/package-gcp/tree/master/gcloud
+ kubectl
  + 公式リファレンス
    + https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands
  + 独自にまとめているもの
    + https://github.com/iganari/package-kubernetes/tree/master/k8s_cmd
