# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# DB設計

# 1.ER図
<a href="https://gyazo.com/b11b15ffcb0f2bdbc2f30408a40c3236"><img src="https://i.gyazo.com/b11b15ffcb0f2bdbc2f30408a40c3236.png" alt="Image from Gyazo" width="847"/></a>

# 2.設計
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