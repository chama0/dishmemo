# ●アプリケーション概要
作った料理を記録して共有できる、料理投稿SNSサービスです。<br>
<br>
↓↓アプリケーションはこちらから↓↓<br>
『http://35.75.115.96/』
<br>
<a href="https://gyazo.com/6b51f87d84e525a443e17d28d42914c0"><img src="https://i.gyazo.com/6b51f87d84e525a443e17d28d42914c0.jpg" alt="Image from Gyazo" width="1184"/></a>

# ●技術的ポイント
- **RSpec**でModel, Request, Systemテスト記述（計210examples）  
- **Rubocop**を使用したコード規約に沿った開発  
- **Ajax**を用いた非同期処理（フォロー/未フォロー、お気に入り登録/未登録などの切り替え表示）  
- **Bootstrap**によるレスポンシブ対応  
- **9つのモデル**をそれぞれ関連付けて使用  
<a href="https://gyazo.com/948d70d4bc0e4b7ff83f95a3cb31b2a7"><img src="https://i.gyazo.com/948d70d4bc0e4b7ff83f95a3cb31b2a7.png" alt="Image from Gyazo" width="172"/></a>
<a href="https://gyazo.com/c510048e13d3c9cfc6c2826d734e129c"><img src="https://i.gyazo.com/c510048e13d3c9cfc6c2826d734e129c.png" alt="Image from Gyazo" width="625"/></a>

# ●アプリケーションの機能
- 作った料理を投稿  
- 画像を正方形に整形して投稿（CarrierWaveを使用）  
- 料理ログ登録（料理を作る度にログを追加し、これまでにいつ作ったか、何回作ったかが一目でわかる）  
- 別ユーザーの料理に対して「食べたい！」リクエストを送信  
- フォロー  
- お気に入り登録  
- コメント  
- 通知（お気に入り登録 or コメントがあった場合）  
- 検索（Ransackを使用）  
- CSV出力  
- ログイン  
- ログイン状態の保持  
- モデルに対するバリデーション  

<a href="https://gyazo.com/236cbc4a12a5dc5e0f67f27c20c36cd3"><img src="https://i.gyazo.com/236cbc4a12a5dc5e0f67f27c20c36cd3.png" alt="Image from Gyazo" width="978"/></a>
<a href="https://gyazo.com/f0b08d56f59475c18726e28f3858a2d6"><img src="https://i.gyazo.com/f0b08d56f59475c18726e28f3858a2d6.png" alt="Image from Gyazo" width="988"/></a>
<a href="https://gyazo.com/dd2da0db39cacfc53aa50bf951ee82b7"><img src="https://i.gyazo.com/dd2da0db39cacfc53aa50bf951ee82b7.jpg" alt="Image from Gyazo" width="969"/></a>
<a href="https://gyazo.com/f83021c88d7f619702dbc4c24d4962b1"><img src="https://i.gyazo.com/f83021c88d7f619702dbc4c24d4962b1.jpg" alt="Image from Gyazo" width="980"/></a>
<a href="https://gyazo.com/d7dbd48b511e8885d79b6e2a6fbbf76f"><img src="https://i.gyazo.com/d7dbd48b511e8885d79b6e2a6fbbf76f.png" alt="Image from Gyazo" width="975"/></a>
<a href="https://gyazo.com/86402df055980340c1e979cc6fe00add"><img src="https://i.gyazo.com/86402df055980340c1e979cc6fe00add.png" alt="Image from Gyazo" width="978"/></a>
<a href="https://gyazo.com/11b3bf954c37a6731fb2d8814c111058"><img src="https://i.gyazo.com/11b3bf954c37a6731fb2d8814c111058.jpg" alt="Image from Gyazo" width="971"/></a>
※アプリケーション内の『ディッシュメモとは？』に同じ記載がございます<br>
<br>
↓↓アプリケーションはこちらから↓↓<br>
『http://35.75.115.96/』

# ●環境
- Ruby 2.5.7
- Ruby on Rails 5.2.3
- jQuery
- MySQL 0.5.3 (DB)
- Github
- AWS (EC2,S3)
- Visual Studio Code

# ●開発方式
- 個人開発
- アジャイル開発(スクラム)を模した擬似チーム開発(Issue・Pull requestを利用)
- ペアプログラミング・モブプログラミングを模した開発

# ●画面遷移図
<a href="https://gyazo.com/26e1d7b195c56ab8a8a7c434bab78f6b"><img src="https://i.gyazo.com/26e1d7b195c56ab8a8a7c434bab78f6b.png" alt="Image from Gyazo" width="1009"/></a>

# ●DB設計

## 1.ER図
<a href="https://gyazo.com/b11b15ffcb0f2bdbc2f30408a40c3236"><img src="https://i.gyazo.com/b11b15ffcb0f2bdbc2f30408a40c3236.png" alt="Image from Gyazo" width="847"/></a>

## 2.設計
### Usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|introduction|text||
|sex|string||
|password_digest|string|null: false|
|remember_digest|string||
|admin|boolean|default: false|
|notification|boolean|default: false|
### Association
- has_many :dishes, dependent: :destroy
- has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
- has_many :following, through: :active_relationships,  source: :followed
- has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
- has_many :followers, through: :passive_relationships, source: :follower
- has_many :favorites, dependent: :destroy
- has_many :notifications, dependent: :destroy
- has_many :lists, dependent: :destroy

### Dishesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|text||
|portion|float||
|tips|text||
|reference|text||
|required_time|integer||
|popularity|integer|null: false|
|cook_memo|text||
|picture|string||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to: user
- has_many: favorites, dependent: :destroy
- has_many: comments, dependent: :destroy
- has_many: lists, dependent: :destroy
- has_many: logs, dependent: :destroy
- has_many: ingredients, dependent: :destroy
- accepts_nested_attributes_for: ingredients

### Relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|follower_id|integer|null: false|
|follower_id|integer|null: false|
### Association
- belongs_to: follower, class_name: "User"
- belongs_to: followed, class_name: "User"

### Favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|dish|references|null: false, foreign_key: true|
### Association
- belongs_to: user
- belongs_to: dish

### Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|dish|references|null: false, foreign_key: true|
|content|text|null: false|
### Association
- belongs_to: dish

### Notificationsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|dish|references|null: false, foreign_key: true|
|from_user_id|integer|null: false|
|content|text||
|variety|integer|null: false|
### Association
- belongs_to: user

### Listsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|dish|references|null: false, foreign_key: true|
|from_user_id|integer|null: false|
### Association
- belongs_to: user
- belongs_to: dish

### Logsテーブル
|Column|Type|Options|
|------|----|-------|
|dish|references|null: false, foreign_key: true|
|content|text||
### Association
- belongs_to: dish

### Ingredientsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
|dish|references|null: false, foreign_key: true|
|quantity|string||
### Association
- belongs_to: dish