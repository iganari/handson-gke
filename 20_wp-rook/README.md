# WP on Rook


公式ドキュメント
https://github.com/rook/rook/tree/master/cluster/examples/kubernetes


## memo

公式だと DB は depoyment で作ってるけど、 Statefulset で作ってしまえば良いかと思ってる
https://github.com/rook/rook/blob/master/cluster/examples/kubernetes/mysql.yaml



## 作っていく

+ 作成したクラスターに認証を通す

```
gcloud beta container clusters get-credentials ${_common}-zonal \
  --zone ${_region}-a \
  --project ${_gcp_pj_id}
```

+ 環境変数を定義する

```
### 共通で使用する文言
export _common='handson-gke'

### Secret に使用する文字列を Base64 化
export _mysql_root_password=$(echo -n 'MySQL の ROOT ユーザのパスワード'            | base64)
export      _mysql_database=$(echo -n "WordPress で使用するデータベース名"           | base64)
export          _mysql_user=$(echo -n "WordPress で使用する MySQL ユーザ"           | base64)
export        _mysql_passwd=$(echo -n "WordPress で使用する MySQL ユーザのパスワード" | base64)
```

```
### 例(後で消す)

export _mysql_root_password=$(echo -n 'd3dj7AA29cBE4dESmWtvtaFj' | base64)
export      _mysql_database=$(echo -n "wordpress"                | base64)
export          _mysql_user=$(echo -n "wp-admin"                 | base64)
export        _mysql_passwd=$(echo -n "wjA8wVrsDD3V"             | base64)
```

+ Secret のマニフェストの置換

```
cp -a template-secret.yaml        ${_common}-wp-secret.yaml
sed -i '' "s/_COMMON/${_common}/" ${_common}-wp-secret.yaml

sed -i '' "s/_MYSQL_ROOT_PASSWORD/${_mysql_root_password}/" ${_common}-wp-secret.yaml
sed -i '' "s/_MYSQL_DATABASE/${_mysql_database}/"           ${_common}-wp-secret.yaml
sed -i '' "s/_MYSQL_USER/${_mysql_user}/"                   ${_common}-wp-secret.yaml
sed -i '' "s/_MYSQL_PASSWORD/${_mysql_passwd}/"             ${_common}-wp-secret.yaml
```

+ Secret のデプロイ

```
kubectl apply -f ${_common}-wp-secret.yaml
```


+ MySQL の StatefulSet のマニフェストの置換

```
cp -a template-mysql.yaml            ${_common}-wp-mysql.yaml
sed -i '' "s/_COMMON/${_common}-wp/" ${_common}-wp-mysql.yaml
```

+ MySQL のデプロイ

```
kubectl apply -f ${_common}-wp-mysql.yaml
```
