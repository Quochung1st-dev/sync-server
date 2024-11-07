#!/bin/bash

# Cấu hình các thông số FTP
FTP_HOST="ftp.example.com"
FTP_USER="ftp_username"
FTP_PASS="ftp_password"
FTP_REMOTE_DIR="/remote_folder"    # Thư mục trên FTP cần đồng bộ
LOCAL_FTP_DIR="/path/to/local/ftp_folder"   # Thư mục lưu trữ FTP trên server

# Tạo tên file log theo ngày tháng
LOG_FILE="/path/to/log/$(date +'%Y-%m-%d')_ftp_to_server.log"

# Hàm ghi log
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Đồng bộ từ FTP về server
log "Starting FTP sync to local server..."
lftp -e "mirror --verbose $FTP_REMOTE_DIR $LOCAL_FTP_DIR; bye" -u "$FTP_USER","$FTP_PASS" "ftp://$FTP_HOST" 2>&1 | tee -a "$LOG_FILE"
log "Completed FTP sync to local server."
