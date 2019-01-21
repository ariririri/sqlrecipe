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

-- 3.3.1.3 ウィンドウ関数を用いて集約関数の結果と元の値を同時に扱う
select
    user_id
  , product_id
  -- 全体の平均レビュースコア
  , avg(score) over() as  avg_score
  -- ユーザーの平均レビュースコア
  , avg(score) over(partition by user_id) as user_avg_score_diff
from 
    review
;

-- 3.3.2.1
DROP TABLE IF EXISTS popular_products;
CREATE TABLE popular_products (
    product_id varchar(255)
  , category   varchar(255)
  , score      numeric
);

INSERT INTO popular_products
VALUES
    ('A001', 'action', 94)
  , ('A002', 'action', 81)
  , ('A003', 'action', 78)
  , ('A004', 'action', 64)
  , ('D001', 'drama' , 90)
  , ('D002', 'drama' , 82)
  , ('D003', 'drama' , 78)
  , ('D004', 'drama' , 58)
;


-- 3.3.2.1
select
    product_id
  , score
  -- 一意の値を取るスコアを定める
  , row_number() over(order by score desc) as row
  , rank() over(order by score desc) as rank
  , dense_rank() over(order by score desc) as dense_rank
from popular_products
order by row
;

-- 3.3.2.2 order by と集約関数
select 
    product_id
  , row_number() over(order by score desc) as row
  , sum(score) over(order by score desc rows  between unbounded preceding and current row) as cum_score
from popular_products;

