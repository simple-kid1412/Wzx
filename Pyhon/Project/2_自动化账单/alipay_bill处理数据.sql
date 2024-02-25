 select * from journal 
-- 调整分类
update journal 
set `交易分类` = `备注` 
where `备注` in ('宝宝','恋爱共享','子女养老')

update journal 
set `交易分类` = case
									when 交易分类='亲友代付' then '亲朋社交' 
									when 交易分类='文化休闲' then '休闲娱乐'
									when 交易分类='日用百货' then '家用家居'
									ELSE 交易分类
								END;

-- 调整交易数据: 1.删除自动转入 2.更新'投资理财'的收支类型为 '收入' 3.更新商家订单号的空值为 null(不是null会筛选出来)
DELETE from journal where `商品说明` like '%自动转入%'
update journal set `收支`='收入' where `交易分类`='投资理财'
update journal set `商家订单号`=null where `商家订单号`=''


-- 聚合同一个商家订单号的支出 为 净支出
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


update journal a 
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
set a.金额=b.净支出
where a.`收支`='支出'

-- 聚合同一个人来往帐 


SELECT 交易分类,sum(`金额`) from  journal 
where 收支='支出'
GROUP BY `交易分类` 


select * from journal where `交易分类`='宝宝'




-- 更新同一个交易对方的来往帐,为净收入
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

