## 自己紹介

私の名前は [星野洸葉] です。[2003年生まれ25卒です]。

**連絡先:**

* メールアドレス: [hk.careerseeker@gmail.com]

**経験:**

* [スタートアップ企業で1年半インターンを経験]
* [個人開発のゲームを制作]

## 成果物

* [商品閲覧アプリ（マイページ、カート、ポイント）]

**技術:**

* プログラミング言語: [dart]
* フレームワーク: [flutter]
* バックエンドサービス: [Firebase]


**スクリーンショット/デモ:**

* [デモへのリンク](https://portfolio-38486.web.app/)


## Firestore 設計

### コレクション: users

#### ドキュメントID: ユーザーID

ユーザーコレクション:
  - ユーザーID (STRING, PK)
  - ユーザー名 (STRING)
  - cart (サブコレクション)
  - points (NUMBER)
  - pointHistory (ARRAY<STRING>)

### コレクション: points

#### ドキュメントID: 自動生成

ドキュメント:
  - ユーザーID (String)
  - 獲得元 (String)
  - ポイントの種類 (String)
  - 獲得日時 (Timestamp)
  - ポイント数 (Number)
  - 有効期限 (Timestamp)
  - 利用履歴 (Array of Objects)
    - 利用日時 (Timestamp)
    - 利用内容 (String)
    - 利用場所 (String)
  - 付与/利用時のメモ (String)
  - 備考 (String)

### コレクション: products

#### ドキュメント: 商品ID

- 商品名: "商品A"
- 価格: $$

#### ドキュメント: 商品ID

- 商品名: "商品B"
- 価格: $$

#### ドキュメント: 商品ID

- 商品名: "商品C"
- 価格: $$

### 関係

- ユーザーは複数のポイントドキュメントを持つことができる。
- ポイントドキュメントは、1人のユーザーに属する。

## Firestore 連携

Firebase Authentication:

Firebase Authenticationを使用して、ユーザーの認証を行っています。ログインや認証情報の管理に利用しています。

Firebase Cloud Functions:

Firebase Cloud Functionsを使用して、バックエンドのロジックや処理を実行しています。例えば、特定のイベントが発生した際にデータを更新するなどの機能を実装しています。

## Google Spreadsheets 連携

商品情報の管理には Google Spreadsheets と連携しています。スプレッドシートから商品情報を取得し、アプリに表示しています。
