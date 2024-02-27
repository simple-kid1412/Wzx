select * from journal order by `交易分类` desc ,`交易时间` desc
select * from journal order by `交易时间` desc ,`交易分类` desc

-- 查看有退款的账户 
select * from journal a 
inner JOIN(
	select `商家订单号`,
		sum(case when `收支`='支出' then `金额` else 0.00 end) as 总支出,
		sum(case when `收支`='不计收支' then `金额` else 0.00 end ) as 总退款,
		(sum(case when `收支`='支出' then `金额` else 0.00 end)-sum(case when `收支`='不计收支' then `金额` else 0.00 end)) as 净支出
	from journal 
	GROUP BY `商家订单号`
	having count(`商家订单号`)>1
	) b 
on a.`商家订单号`=b.`商家订单号`

-- 总计
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



-- 查看分类明细
select * from journal where `交易分类`='充值缴费' order by `收支`
select * from journal where `交易分类`='休闲娱乐' order by `收支`
select * from journal where `交易分类`='恋爱共享' order by `收支`
select * from journal where `交易分类`='餐饮美食' order by `收支`
select * from journal where `交易分类`='充值缴费' order by `收支`
select * from journal where `交易分类`='宝宝' 		order by `收支`
select * from journal where `交易分类`='家居家用' order by `收支`
select * from journal where `交易分类`='子女养老' order by `收支`
select * from journal where `交易分类`='交通出行' order by `收支`
select * from journal where `交易分类`='亲朋社交' order by `收支`
select * from journal where `交易分类`='生活服务' order by `收支`
select * from journal where `交易分类`='医疗保健' order by `收支`
select * from journal where `交易分类`='转账红包' order by `收支`














