## 自己紹介

私の名前は [星野洸葉] です。[2003 年生まれ 25 卒です]。

**連絡先:**

- メールアドレス: [hk.careerseeker@gmail.com]

**経験:**

- [スタートアップ企業で 1 年半インターンを経験]
- [個人開発のゲームを制作]

## 成果物

- [ショッピングアプリ（マイページ、カート、ポイント..）]

**技術:**

- プログラミング言語: [dart]
- フレームワーク: [flutter]
- バックエンドサービス: [Firebase]

**スクリーンショット/デモ:**

- [デモリンク](https://portfolio-38486.web.app/)
- [googlepreadsheets リンク](https://docs.google.com/spreadsheets/d/1YcS2I3v2w8CouXJFQhgX5XaeYCU2koNycxSR4sV58-s/edit?pli=1#gid=0)

## DB設計

### コレクション: users

#### ドキュメント ID: ユーザー ID

- ユーザー ID (STRING, PK)
- ユーザー名 (STRING)
- favoriteProducts (サブコレクション/ARRAY<STRING>)
- cart (サブコレクション/ARRAY<STRING>)
- points (NUMBER)
- pointHistory (ARRAY<STRING>)

### コレクション: products

#### ドキュメント: 商品 ID

- 商品名: "商品 A"(String)
- 価格: "$$"(String)
- 商品画像: "https.."(String)

### コレクション: cart

#### ドキュメント:  カートID 自動生成

- items(Array)
  - 商品ID(String)
  - quantity(int)
  - size(String)
  - color(String)
- ユーザID(String)
- totalPrice(String)

### コレクション: points

#### ドキュメント ID: ポイントID 自動生成

- ユーザー ID (String)
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

### 関係

- ユーザーは複数のポイントドキュメントを持つことができる。
- ポイントドキュメントは、1 人のユーザーに属する。

## Firestore 連携

Firebase Authentication:
Firebase Authentication を使用して、ユーザーの認証を行っています。ログインや認証情報の管理に利用しています。

Firebase Firestore:
Firebase Firestore を使用して、データベースへのデータの読み書きを行っています。

## Google Spreadsheets 連携

商品情報の管理には Google Spreadsheets と連携しています。管理者はスプレッドシートで商品を管理し、アプリ内の管理者ページから Firestore に同期させてアプリに反映させることができます。

## 最後に

登録等自己責任でお願いします。
