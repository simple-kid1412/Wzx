import csv
import pymysql
file='alipay_record_20240224_225350.csv'
with open(file) as csvFile:          
    csv_reader = csv.reader(csvFile)    #读文件 生成一个 csv文件的READER对象
    listReport = list(csv_reader)      

detail_data=listReport[25:]             #删除不需要的行 结果传入detail_data

for i in range(0,len(detail_data)):
    print(detail_data[i])