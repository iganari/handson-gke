# Python

## Docker コンテナを用いて開発する時

+ コンテナの作成

```
docker build . --tag handson-gke-10-py-local
```

+ 起動

```
docker run \
    --rm \
    -it \
    -p 8080:5000 \
    -v $(pwd):/app \
    --name local-py \
    handson-gke-10-py-local \
    /bin/bash
```

+ コンテナにログイン ---> :whale:

```
docker exec -it local-py /bin/bash
```

+ :whale: Python の起動

```
python3 /app/main.py
```

+ Web ブラウザから確認

http://0.0.0.0:8080


+ コンテナの作り直し

```
docker stop local-py && \
docker rm -f local-py
```




