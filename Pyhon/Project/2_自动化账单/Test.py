import csv

file='alipay.csv'
with open(file) as csvFile:          
    csv_reader = csv.reader(csvFile)    #读文件 生成一个 csv文件的READER对象
    listReport = list(csv_reader)      

detail_data=listReport[25:]             #删除不需要的行 结果传入detail_data
for row in detail_data:
    del row[3]                          #删除不需要的列 
    del row[8]


for i in range(0,len(detail_data)):
    detail_data[i]=[item.replace('\t', '')  for item in detail_data[i]]  #处理商家订单号
    print(detail_data[i])


