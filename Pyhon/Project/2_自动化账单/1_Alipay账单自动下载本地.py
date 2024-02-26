# 导入所需库
from alipay import AliPay

# 创建AliPay实例
app_id = 'your_app_id'
private_key = 'your_private_key'
alipay = AliPay(appid=app_id, app_notify_url=None, app_private_key_string=private_key, sign_type='RSA2')

# 获取登录凭证
auth_url = alipay.system.oauth2_token(code='your_authorization_code')
auth_token = auth_url['access_token']



# 发送请求
bill_url = '
bill_data = {
    'method': 'alipay.data.bill.downloadurl.query',
    'app_id': app_id,
    'biz_content': {
        'bill_type': 'trade',
        'bill_date': '2022-01-01'
    }
}
bill_response = alipay.api_alipay_data_bill_downloadurl_query(bill_data)


# 解析返回结果
bill_url = bill_response['bill_download_url']

# 数据处理与存储
import requests

# 下载账单数据
bill_content = requests.get(bill_url).content

# 保存到本地文件
with open('bill.txt', 'wb') as f:
    f.write(bill_content)