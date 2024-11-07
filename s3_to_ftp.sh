#!/bin/bash

# Cấu hình các thông số FTP
FTP_HOST="ftp.example.com"
FTP_USER="ftp_username"
FTP_PASS="ftp_password"
FTP_REMOTE_DIR="/remote_folder"    # Thư mục trên FTP để tải lên từ S3
LOCAL_S3_DIR="/path/to/local/s3_folder"   # Thư mục trung gian trên server để lưu trữ dữ liệu từ S3 trước khi tải lên FTP

# Cấu hình các thông số S3
ACCESS_KEY_ID="your-access-key-id"
SECRET_ACCESS_KEY="your-secret-access-key"
DEFAULT_REGION="us-west-2"  # Khu vực mặc định
BUCKET="your-bucket-name"
ENDPOINT="https://s3.your-region.amazonaws.com"  # Endpoint mặc định cho S3

# Tạo tên file log theo ngày tháng
LOG_FILE="/path/to/log/$(date +'%Y-%m-%d')_s3_to_ftp.log"

# Thiết lập biến môi trường cho AWS CLI
export AWS_ACCESS_KEY_ID="$ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$SECRET_ACCESS_KEY"
export AWS_DEFAULT_REGION="$DEFAULT_REGION"

# Hàm ghi log
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Bước 1: Đồng bộ từ S3 về thư mục trung gian trên server
log "Starting S3 sync to local server (intermediate directory)..."
aws s3 sync "s3://$BUCKET" "$LOCAL_S3_DIR" --endpoint-url "$ENDPOINT" 2>&1 | tee -a "$LOG_FILE"
log "Completed S3 sync to local server."

# Bước 2: Đồng bộ từ thư mục trung gian trên server lên FTP
log "Starting local server sync to FTP..."
lftp -e "mirror --reverse --verbose $LOCAL_S3_DIR $FTP_REMOTE_DIR; bye" -u "$FTP_USER","$FTP_PASS" "ftp://$FTP_HOST" 2>&1 | tee -a "$LOG_FILE"
log "Completed sync to FTP."
