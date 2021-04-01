# Advansed

## Q1. HTTPS を設定する

Managed Certificate を使用して、 HTTPS で表示出来るようにしましょう

※ ドメインは別途自分で用意する必要があります。

回答例 -> [01](./01/README.md)

## Q2. 複数のドメインを登録し、出し分ける

Managed Certificate を使用して、 HTTPS で表示出来るようにしましょう

※ Q1 をクリアしている必要があります。


回答例 -> [02](./02/README.md)

## Q3. HTTP -> HTTPS のリダイレクト設定を追加する

HTTP で来たトラフィックを HTTPS にリダイレクトする設定をマニフェストで実装しましょう

※ Q1 をクリアしている必要があります。

回答例 -> [03](./03/README.md)









## [WIP] Q2. 負荷試験でどこまで耐えられるか見る

たとえば、 Apache Bench を用いて、 Pod が正常にレスポンスを返す CPU, memory を算出する

回答例 -> WIP

## [WIP] Q3. CPU, Memmory の Limit を設定

Q1 の情報を元に、deployment の CPU, Memmory の Limit を設定する 

回答例 -> WIP

## [WIP] Q4. pod のオートスケールを設定

pod のオートスケールを設定し、負荷を掛け、意図したとおりにスケールアップするか確認する

場合に応じて、node のオートスケールも設定する

回答例 -> WIP
