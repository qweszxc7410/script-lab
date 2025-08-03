from minio import Minio

# 初始化 MinIO 客戶端
client = Minio(
    "192.168.1.104:18300",  # MinIO API 端口
    access_key="minioadmin",
    secret_key="minioadmin",
    secure=False  # 如果是 HTTP 而非 HTTPS，要設為 False
)

# 欲下載的 bucket 和檔案 key
bucket_name = "marketdata"
object_name = "1101.feather"
local_file = "1101_downloaded.feather"

# 檢查 bucket 是否存在
if not client.bucket_exists(bucket_name):
    print(f"❌ Bucket '{bucket_name}' 不存在")
else:
    # 這是「完整 key」，不是實際的資料夾
    object_key = "2330/2330.feather"
    client.fget_object("marketdata", object_key, "2330.feather")
    print("✅ 已下載：2330.feather")

from io import BytesIO
import polars as pl

response = client.get_object("marketdata", "2330/2330.feather")
data = BytesIO(response.read())
df = pl.read_ipc(data)
print(df)

# 9iHYwn3301iRjS84yaSU
# fDeRcipKm49IWBKFf3bG6QMwKh0CzExVpUynGb3w