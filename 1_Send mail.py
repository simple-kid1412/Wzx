import time
import smtplib
import email
from email.mime.text import MIMEText    #构造文本
from email.mime.image import MIMEImage  #构造图片
from email.mime.multipart import MIMEMultipart #负责将多个对象集合起来
from email.header  import Header
#1.邮件配置设置：服务器、邮箱授权码、发件人 收件人邮箱
mail_host="smtp.126.com" 
mail_license="RTBSHRALEPLXXNTC"
mail_sender="suannaixigua@126.com"
mail_receivers=["948836100@qq.com"]

#构建MIMEMultiparti对象代表邮件本身，可以往里面添加文本图片附件等
mm=MIMEMultipart('related')

#设置邮箱头部
subject_content="""python邮件发送测试"""
mm["from"]="sender_name<suannaixigua@126.com>"
mm["To"]="receiver_1_name<948836100@qq.com>"#可以设置多个
mm["Subject"]=Header(subject_content,'UTF-8')

#添加正文文本
body_content="""你好，这是一个测试邮件!"""#邮件正文内容
message_text=MIMEText(body_content,"plain","utf-8")#构造文本，参数1：正文内容，参数2：文本格式，参数3：编码方式
mm.attach(message_text)#想MIMEMultipart对象中添加文本对象


""" 
#添加图片
image_data = open('a.jpg','rb')
message_image = MIMEImage(image_data.read())
image_data.close()
mm.attach(message_image) 

#添加附件
atta=MIMEText(open('linux.z01','rb').read(),'base64','utf-8')#设置附件内容，编码方式，打开方式
atta["Content-Disposition"] = 'attachment; filename="linux.z01"'#设置附件信息
mm.attach(atta)
""" 

# 创建SMTP对象
stp = smtplib.SMTP()
stp.connect(mail_host, 25)                                          # 设置发件人邮箱的域名和端口，端口地址为25
#stp.set_debuglevel(1)                                              # set_debuglevel(1)可以打印出和SMTP服务器交互的所有信息
stp.login(mail_sender,mail_license)                                 # 登录邮箱，传递参数1：邮箱地址，参数2：邮箱授权码

#添加附件
for num in range(1,4):
    filesend='linux.z'+str(num).rjust(2,'0')
    print(filesend)
    atta=MIMEText(open(filesend,'rb').read(),'base64','utf-8')      # 二进制方式打开文件 read bin ，编码方式，打开方式
    atta["Content-Disposition"] = 'attachment; filename=filesend'   # 设置附件信息，如果不写，附件名称会变成类似时间戳一样的串
    mm.attach(atta)
    stp.sendmail(mail_sender, mail_receivers, mm.as_string())       # 发送邮件，传递参数1：发件人邮箱地址，参数2：收件人邮箱地址，参数3：把邮件内容格式改为str
    print("邮件发送成功")
    mm.set_payload([])                                              # 每次清空mm对象的内容
    time.sleep(5)
# 关闭SMTP对象
stp.quit()