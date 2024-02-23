select * from journal order by `交易分类` desc, `交易时间` desc

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

-- 2.3 更新投资理财为收入
DELETE from journal where `商品说明` like '%自动转入%'
update journal set `收支`='收入' where `交易分类`='投资理财'



select `商家订单号`,sum(`金额`) from journal 
group by `商家订单号`
order by sum(`金额`) desc


-- 同一笔 `商家订单号` ,`收/支`=支出 的订单号  支出总额- 不计收支总额








