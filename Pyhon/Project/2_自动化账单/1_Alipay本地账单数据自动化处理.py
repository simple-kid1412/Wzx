import csv
import pymysql
file='alipay_record_02.csv'
with open(file) as csvFile:          
    csv_reader = csv.reader(csvFile)    #读文件 生成一个 csv文件的READER对象
    listReport = list(csv_reader)      

detail_data=listReport[25:]             #删除不需要的行 结果传入detail_data

for i in range(0,len(detail_data)):
    print(detail_data[i])


for row in detail_data:
    del row[3]                          #删除不需要的列 
    del row[6]
    del row[6]
    del row[6]
  
for i in range(0,len(detail_data)):
    detail_data[i]=[item.replace('\t', '')  for item in detail_data[i]]  #处理商家订单号末尾的制表符字符串
    
print(detail_data)
#将列表插入到本地数据库
db = pymysql.connect(host='localhost', user='root',password='0322',database='alipay',charset='utf8mb4')
cursor = db.cursor()
#执行代码 插入所有数据
sql = "INSERT INTO journal (交易时间, 交易分类,交易对方,商品说明,收支,金额,商家订单号,备注) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
cursor.executemany(sql, detail_data)

#提交事务
db.commit()
cursor.close()
db.close()
""" 
#执行sql文件,对插入数据进行数据清洗
conn = pymysql.connect(host='localhost',
                       user='root', 
                       password='password',
                       database='dbname',
                       charset='utf8mb4')

cursor = conn.cursor()

with open('script.sql') as f:
  sql = f.read()
  commands = sql.split(';')
  for command in commands:
    if command.strip():
      cursor.execute(command)

conn.commit()
 """

