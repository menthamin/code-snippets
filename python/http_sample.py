import json
import requests
import dotenv
import os

dotenv.load_dotenv()

url = os.environ.get("lambda_url")
client_id = os.environ.get("client_id")
client_secret = os.environ.get("client_secret")
developer_token = os.environ.get("developer_token")
refresh_token = os.environ.get("refresh_token")
login_customer_id = os.environ.get("login_customer_id")

URL = f"{url}/get_conversion_tag_info"
customer_id = "1234567890"
params = {"customerId": customer_id}
headers = {
    "client-id": client_id,
    "client-secret": client_secret,
    "developer-token": developer_token,
    "refresh-token": refresh_token,
    "login-customer-id": login_customer_id,
}

response = requests.post(URL, params=params, headers=headers)
print(response.text)
