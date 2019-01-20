-- 1つのテーブルに対する操作

-- 3-3-1data
DROP TABLE IF EXISTS review;
CREATE TABLE review (
    user_id    varchar(255)
  , product_id varchar(255)
  , score      numeric
);

INSERT INTO review
VALUES
    ('U001', 'A001', 4.0)
  , ('U001', 'A002', 5.0)
  , ('U001', 'A003', 5.0)
  , ('U002', 'A001', 3.0)
  , ('U002', 'A002', 3.0)
  , ('U002', 'A003', 4.0)
  , ('U003', 'A001', 5.0)
  , ('U003', 'A002', 4.0)
  , ('U003', 'A003', 4.0)
;

-- 3.3.1.1 集約関数を用いてテーブル全体の特徴量を計算
select
    count(*) as total_count
  , count(distinct user_id) as user_count
  , count(distinct product_id) as product_count
  , sum(score) as sum
  , avg(score) as avg
  , max(score) as max
  , min(score) as min
from review
;

-- 3-3-1-2 ユーザーごとにテーブルを分割して,集約関数を適用するクエリ
select 
    user_id
  , count(distinct product_id) as product_count
  , sum(score) as sum
  , avg(score) as avg
  , max(score) as max
  , min(score) as min
from 
    review
group by
    user_id
;