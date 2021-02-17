# django を GKE 上に展開するサンプル

## 注意

DB 諸々すべて GKE 上に置きたい


## メモ


+ Django のインストール

```
requirements.txt
```
```
pip3 install -r requirements.txt
```

+ Django のプロジェクト作成

```
export _pj_name='my_site'


django-admin startproject ${_pj_name}
cd ${_pj_name}
```

+ run サーバの起動

```
python3 manage.py runserver 0.0.0.0:8000
```


+ postgre

```
psql -h localhost -d mydatabase -U myuser
```