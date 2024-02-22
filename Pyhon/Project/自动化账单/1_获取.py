import csv

file='alipay_record_20240222_203230.csv'
with open(file) as csvFile:          
    csv_reader = csv.reader(csvFile)    #读文件 生成一个 csv文件的READER对象
    listReport = list(csv_reader)      

detail_data=listReport[25:]             #删除不需要的行 结果传入detail_data
for row in detail_data:
    del row[3]                          #删除不需要的列 
    del row[6]
    del row[6]
    del row[6]
    del row[8]


for i in range(0,len(detail_data)):
    detail_data[i]=[item.replace('\t', '')  for item in detail_data[i]]  #处理商家订单号末尾的制表符字符串
    print(detail_data[i])

#将列表插入到本地数据库



