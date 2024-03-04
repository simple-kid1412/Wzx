-- name :总计
SELECT `交易分类`, 总支出, 总收入, 净值 FROM (
    SELECT `交易分类`,
           SUM(CASE WHEN `收支` = '支出' THEN `金额` ELSE 0.00 END) AS 总支出,
           SUM(CASE WHEN `收支` IN ('不计收支', '收入') THEN `金额` ELSE 0.00 END) AS 总收入,
           SUM(CASE WHEN `收支` IN ('不计收支', '收入') THEN `金额` ELSE 0.00 END) - SUM(CASE WHEN `收支` = '支出' THEN `金额` ELSE 0.00 END) AS 净值
    FROM journal
    GROUP BY `交易分类`
    UNION ALL
    SELECT '总计',
           SUM(CASE WHEN `收支` = '支出' THEN `金额` ELSE 0.00 END),
           SUM(CASE WHEN `收支` IN ('不计收支', '收入') THEN `金额` ELSE 0.00 END),
           SUM(CASE WHEN `收支` IN ('不计收支', '收入') THEN `金额` ELSE 0.00 END) - SUM(CASE WHEN `收支` = '支出' THEN `金额` ELSE 0.00 END)
    FROM journal
) AS combined
ORDER BY CASE WHEN `交易分类` = '总计' THEN 1 ELSE 0 END, 净值 DESC;




-- NAME:餐饮美食 
select * from journal where `交易分类`='餐饮美食' order by `交易时间` desc;
-- NAME:交通出行 
select * from journal where `交易分类`='交通出行' order by `交易时间` desc;
-- NAME:休闲娱乐 
select * from journal where `交易分类`='休闲娱乐' order by `交易时间` desc;
-- NAME:充值缴费 
select * from journal where `交易分类`='充值缴费' order by `交易时间` desc;
-- NAME:生活服务 
select * from journal where `交易分类`='生活服务' order by `交易时间` desc;
-- NAME:公共服务 
select * from journal where `交易分类`='公共服务' order by `交易时间` desc;
-- NAME:家用家居 
select * from journal where `交易分类`='家用家居' order by `交易时间` desc;
-- NAME:医疗保健 
select * from journal where `交易分类`='医疗保健' order by `交易时间` desc;
-- NAME:子女养老 
select * from journal where `交易分类`='子女养老' order by `交易时间` desc;
-- NAME:恋爱共享 
select * from journal where `交易分类`='恋爱共享' order by `交易时间` desc;
-- NAME:宝宝 
select * from journal where `交易分类`='宝宝' 		order by `交易时间` desc;
-- NAME:亲朋社交 
select * from journal where `交易分类`='亲朋社交' order by `交易时间` desc;

-- NAME:转账红包 
select * from journal where `交易分类`='转账红包' order by `交易时间` desc;
-- NAME:投资理财 
select * from journal where `交易分类`='投资理财' order by `交易时间` desc;
-- NAME:收入 
select * from journal where `交易分类`='收入' order by `交易时间` desc;

select * from journal where `商品说明`like '%余额宝%'

