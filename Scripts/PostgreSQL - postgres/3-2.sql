-- 3-2 複数の値に対する操作

-- 3.2.1 データ
DROP TABLE IF EXISTS mst_user_location;
CREATE TABLE mst_user_location ( user_id   varchar(255) , pref_name varchar(255) , city_name varchar(255)
);

INSERT INTO mst_user_location
VALUES
    ('U001', '東京都', '千代田区')
  , ('U002', '東京都', '渋谷区'  )
  , ('U003', '千葉県', '八千代区')
;

-- 3.2.1.1 文字列を連結する
select 
    user_id
  , concat(pref_name, city_name) as pref_city
from mst_user_location;

-- 3.2.2.1 
DROP TABLE IF EXISTS quarterly_sales;
CREATE TABLE quarterly_sales (
    year integer
  , q1   integer
  , q2   integer
  , q3   integer
  , q4   integer
);

INSERT INTO quarterly_sales
VALUES
    (2015, 82000, 83000, 78000, 83000)
  , (2016, 85000, 85000, 80000, 81000)
  , (2017, 92000, 81000, NULL , NULL )
;

-- 3.2.2.1. Q1とQ2を比較する
select
    year
  , q1
  , q2
  , case 
      when q1 < q2 then '+'
      when q1 = q2 then ' '
      else '-'
    end as judge_q1_q2
  , q2 - q1 as diff_q2_q1
  , sign(q2 - q1) as sign_q2_q1
from quarterly_sales;

-- 3.2.2.2 年間の最大と最小を見つける
select 
   year
 , greatest(q1, q2, q3, q4) as gratest_sales
 , least(q1, q2, q3, q4) as latest_sales
from quarterly_sales;

-- 3.2.2.3  平均を求める
select
    year
  , (q1 + q2 + q3 + q4) / 4 as average
from quarterly_sales;
