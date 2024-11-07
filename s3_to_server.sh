#!/bin/bash

# Cấu hình các thông số S3
ACCESS_KEY_ID="your-access-key-id"
SECRET_ACCESS_KEY="your-secret-access-key"
DEFAULT_REGION="us-west-2"  # Khu vực mặc định
BUCKET="your-bucket-name"
ENDPOINT="https://s3.your-region.amazonaws.com"  # Endpoint mặc định cho S3, thay đổi nếu cần
LOCAL_S3_DIR="/path/to/local/s3_folder"   # Thư mục lưu trữ S3 trên server

# Tạo tên file log theo ngày tháng
LOG_FILE="/path/to/log/$(date +'%Y-%m-%d')_s3_to_server.log"

# Thiết lập biến môi trường cho AWS CLI
export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$DEFAULT_REGION"

# Hàm ghi log
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Đồng bộ từ S3 về server
log "Starting S3 sync to local server..."
aws s3 sync "s3://$BUCKET" "$LOCAL_S3_DIR" --endpoint-url "$ENDPOINT" 2>&1 | tee -a "$LOG_FILE"
log "Completed S3 sync to local server."
