select * from journal order by `交易分类` desc ,`交易时间` desc
select * from journal order by `交易时间` desc ,`交易分类` desc



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

select `交易分类`,
		sum(case when `收支`='支出' then `金额` else 0.00 end) as 总支出,
		sum(case when `收支` in('不计收支','收入') then `金额` else 0.00 end ) as 总退款,
		(sum(case when `收支`='支出' then `金额` else 0.00 end)-sum(case when `收支` in('不计收支','收入') then `金额` else 0.00 end)) as 净支出
		from journal
		GROUP BY `交易分类`
		order by 净支出 desc