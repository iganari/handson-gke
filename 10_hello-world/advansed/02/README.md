# 複数のドメインを登録し、出し分ける


+ 用意しておくドメイン

```
例

py.hw_adv02.iganari.xyz
go.hw_adv02.iganari.xyz
```

```
export _your_domain='Your Domin'
export _your_domain='igarashi-test.tech.cloud-ace.jp'
```


+ Reserving an External IP Address.

```
gcloud beta compute addresses create ${_common}-hw-adv02-ip \
    --ip-version=IPV4 \
    --global \
    --project ${_gcp_pj_id}
```

```
cp -a main.yaml.template main.yaml
sed -i '' "s/YOUR_PROJECT/${_gcp_pj_id}/g" main.yaml
sed -i '' "s/COMMON/${_common}/g"          main.yaml
sed -i '' "s/YOUR_DOMAIN/${_your_domain}/g"          main.yaml
```

+ 実行

```
kubectl apply -f main.yaml
```

## リソースの削除

```
kubectl delete -f main.yaml
```
```
gcloud beta compute addresses delete ${_common}-hw-adv02-ip \
    --global \
    --project ${_gcp_pj_id} -q
```