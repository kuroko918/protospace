== README

作成するテーブル
users
prototypes
images
prototypes_tags
comments
likes

**Usersテーブル**
id (integer)
name (string)
mail (string)
password (string)
member (string)
profile (text)
works (text)
avatar (image)

関連
has_many prototypes
         comments
         likes

=> 6のユーザー管理機能のときに導入

​
**Prototypesテーブル**
id (integer)
title (string)
catch copy (string)
concept (text)
user_id (integer)

アソシエーション
belongs_to user
has_many comments
         likes
         image
has_many tags, through: :prototypes_tags

=> 7のプロトタイプ投稿機能のときに導入
​

**imagesテーブル**
id (integer)
image (string)
prototype_id (integer)
status (integer)

アソシエーション
belongs_to prototype



=> 7のプロトタイプ投稿機能のときに導入

**commentsテーブル**
id (integer)
text (text)
user_id (integer)
prototype_id (integer)

アソシエーション
belongs_to user
           prototype


=> 9のCcomments機能のときに導入


**likesテーブル**
id (integer)
user_id (integer)
prototype_id (integer)

アソシエーション
belongs_to user
           prototype

=> 9のlike機能のときに導入