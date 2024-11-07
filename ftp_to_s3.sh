#!/bin/bash

# Cấu hình các thông số FTP
FTP_HOST="ftp.example.com"
FTP_USER="ftp_username"
FTP_PASS="ftp_password"
FTP_REMOTE_DIR="/remote_folder"    # Thư mục trên FTP cần đồng bộ

# Cấu hình các thông số S3
ACCESS_KEY_ID="your-access-key-id"
SECRET_ACCESS_KEY="your-secret-access-key"
DEFAULT_REGION="us-west-2"  # Khu vực mặc định
BUCKET="your-bucket-name"
ENDPOINT="https://s3.your-region.amazonaws.com"  # Endpoint mặc định cho S3

# Tạo tên file log theo ngày tháng
LOG_FILE="/path/to/log/$(date +'%Y-%m-%d')_fto_to_s3.log"

# Thiết lập biến môi trường cho AWS CLI
export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$DEFAULT_REGION"

# Hàm ghi log
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Đồng bộ từ FTP lên S3 (sử dụng rclone)
log "Starting FTP sync to S3..."
if command -v rclone &> /dev/null
then
    rclone sync "ftp://$FTP_USER:$FTP_PASS@$FTP_HOST$FTP_REMOTE_DIR" "s3:$BUCKET" --s3-endpoint "$ENDPOINT" 2>&1 | tee -a "$LOG_FILE"
else
    log "Rclone not found. Please install rclone to sync FTP to S3."
fi
log "Completed FTP sync to S3."
