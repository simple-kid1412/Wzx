-- 0.查看表
select * from journal order by  `交易分类` desc,`交易时间` desc
-- 1.修改列'交易时间'属性为datetime类型,并格式化列中数据

ALTER TABLE  journal
MODIFY COLUMN `交易时间` DATETIME;

ALTER TABLE  journal
MODIFY COLUMN `金额` decimal(18,2);

-- 2.1 更新备注灵活分类
update journal 
set `交易分类` = `备注` 
where `备注` in ('宝宝','恋爱共享','子女养老')

-- 2.2 更新固定替换分类
update journal 
set `交易分类` = case
									when 交易分类='亲友代付' then '亲朋社交' 
									when 交易分类='文化休闲' then '休闲娱乐'
									when 交易分类='日用百货' then '家用家居'
									ELSE 交易分类
								END;
								

-- 3.1 根据同一笔商家订单号进行聚合, 计算净支出,更新journal表
UPDATE journal a
INNER JOIN(
	select 商家订单号,
	SUM(CASE WHEN `收/支`='支出' THEN `金额` else 0.00 end) AS 总支出, 
	SUM(CASE WHEN `收/支` ='不计收支' THEN `金额` else 0.00  end) AS 总退款,
	sum(CASE WHEN `收/支`='支出' THEN `金额` else 0.00 end)-sum(CASE WHEN `收/支` ='不计收支' THEN `金额` else 0.00 end) as `金额`
	from journal
	group by `商家订单号`
) b ON a.`商家订单号`=b.`商家订单号`
set a.`金额`=b.`金额`
where a.`收/支`='支出'


-- 3.2 删除 不计收支的商家单号
delete from journal where `交易分类`='交通出行' and `收/支`='不计收支' 




select * from journal order by  `交易分类` desc,`交易时间` desc

-- 算一下转账付款的总收入 总支出 
select `交易分类`,	
	SUM(CASE WHEN `收/支`='支出' THEN `金额` else 0.00 end) AS 总支出, 
	SUM(CASE WHEN `收/支` ='收入' THEN `金额` else 0.00  end) AS 总收入,
	sum(CASE WHEN `收/支`='支出' THEN `金额` else 0.00 end)-sum(CASE WHEN `收/支` ='收入' THEN `金额` else 0.00 end) as `金额`
	from journal
where `收/支`='支出'
GROUP BY `交易分类` 
order by `金额` desc



UNION ALL
SELECT
  '总支出',
  SUM(`金额`)
FROM journal;






