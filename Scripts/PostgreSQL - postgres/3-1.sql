-- 1つの値に対する操作
create database  recipe
create schema recipe;
set search_path = recipe;

-- 3-1-1-data
DROP TABLE IF EXISTS mst_users;
CREATE TABLE mst_users(
    user_id         varchar(255) , register_date   varchar(255)
  , register_device integer
);

INSERT INTO mst_users
VALUES
    ('U001', '2016-08-26', 1)
  , ('U002', '2016-08-26', 2) , ('U003', '2016-08-27', 3)
;

-- 3.1.1.1 コードをラベルで置き換える
select
    user_id
  , case
      when register_device = 1 then 'PC'
      when register_device = 2 then 'SP'
      when register_device = 3 then 'app'
    end as device_name
from mst_users;

-- 3.1.2 data
DROP TABLE IF EXISTS access_log ;
CREATE TABLE access_log (
    stamp    varchar(255)
  , referrer text
  , url      text
);

INSERT INTO access_log 
VALUES
    ('2016-08-26 12:02:00', 'http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video/detail?id=001')
  , ('2016-08-26 12:02:01', 'http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video#ref'          )
  , ('2016-08-26 12:02:01', 'https://www.other.com/'                               , 'http://www.example.com/book/detail?id=002' )
;

-- 3.1.2.1  リファラーからURLを取得する
select
    stamp
    -- ()で結ばれる箇所が得られる.
    -- 正直なんでこれで得られるかわからん
  , substring(referrer from 'https?://([^m]*)') as referrer_host
from access_log;

-- 3.1.3 データ
DROP TABLE IF EXISTS access_log ;
CREATE TABLE access_log (
    stamp    varchar(255)
  , referrer text
  , url      text
);

INSERT INTO access_log 
VALUES
    ('2016-08-26 12:02:00', 'http://www.other.com/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video/detail?id=001')
  , ('2016-08-26 12:02:01', 'http://www.other.net/path1/index.php?k1=v1&k2=v2#Ref1', 'http://www.example.com/video#ref'          )
  , ('2016-08-26 12:02:01', 'https://www.other.com/'                               , 'http://www.example.com/book/detail?id=002' )
;

-- 3.1.3.1 URLのパスをスラッシュで分割し、階層を抽出
select
    stamp
    -- split_parで配列の操作
  , split_part(substring(url from 'https?://[^/]+([^?#]+)'), '/', 2) as path1
  , split_part(substring(url from 'https?://[^/]+([^?#]+)'), '/', 3) as path2
from access_log;


-- 3.1.4dataなし

-- 3.1.4.1 現在の日付とタイムスタンプ
-- fromがいらない奇跡の形だ
select
    current_date
  , current_timestamp
;  

-- 3.1.4.2 文字列型を日付型、タイムスタンプ型に変更する
select
    cast('2016-01-30' as date) as dt
  , cast('2016-01-30 12:00:00' as timestamp) as stamp
;

-- 3.1.4.3 タイムスタンプ型のデータから年、月、日等を取得する
select
    extract(year from stamp) as year
from
-- as t: table として？と思われる
    (select cast('2016-01-30 12:00:00' as timestamp)  as stamp) as t
;

-- 3.1.5 data
DROP TABLE IF EXISTS purchase_log_with_coupon;
CREATE TABLE purchase_log_with_coupon (
    purchase_id varchar(255)
  , amount      integer
  , coupon      integer
);

INSERT INTO purchase_log_with_coupon
VALUES
    ('10001', 3280, NULL)
  , ('10002', 4650,  500)
  , ('10003', 3870, NULL)
;
 
-- 3.1.5.1 購入学から割引クーポン値引きごとの売上金額を求める
select
    *
   , amount - coupon as discount_amount1
   , amount - coalesce(coupon, 0) as discount_amount2
from purchase_log_with_coupon;