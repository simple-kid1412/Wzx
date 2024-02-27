-- 1 调整分类
-- 1.1 调整备注分类
update journal 
set `交易分类` = `备注` 
where `备注` in ('宝宝','恋爱共享','子女养老');
-- 1.2 调整固定分类名称
update journal 
set `交易分类` = case
									when 交易分类='亲友代付' then '亲朋社交' 
									when 交易分类='文化休闲' then '休闲娱乐'
									when 交易分类='日用百货' then '家用家居'
									ELSE 交易分类
								END;
								
-- 1.3 更新退款交易分类为 支出的商家订单号分类
UPDATE journal a
JOIN (
  SELECT DISTINCT `商家订单号`, 交易分类
  FROM journal
  WHERE 收支 = '支出'
) b ON a.`商家订单号` = b.`商家订单号`
SET a.交易分类 = b.交易分类
WHERE a.收支='不计收支';

-- 2 调整数据
-- 2.1 删除自动转入  
DELETE from journal where `商品说明` like '%自动转入%';
-- 2.2 更新'投资理财'的收支类型为 '收入'
update journal set `收支`='收入' where `交易分类`='投资理财';
-- 2.3.更新商家订单号的空值为 null(不是null会筛选出来)
update journal set `商家订单号`=null where `商家订单号`='';


-- 3 数据计算
-- 3.1 将有退回记录的 `商家订单号` 的支出 更新为 支出净值
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
where a.`收支`='支出';










