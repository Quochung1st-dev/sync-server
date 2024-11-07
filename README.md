# 1. Cài đặt AWS CLI
- Để cài đặt AWS CLI trên Ubuntu, bạn cần thực hiện các bước sau:
- Cập nhật danh sách package
``` sudo apt update ```
- Cài đặt AWS CLI thông qua gói cài đặt `awscli`
```sudo apt install awscli -y```
- Kiểm tra phiên bản để xác nhận đã cài đặt thành công
```aws --version```
# 2. Cài đặt LFTP
- LFTP là công cụ phổ biến để đồng bộ FTP và có sẵn trong kho lưu trữ của Ubuntu.
- Cài đặt lftp
```sudo apt install lftp -y```
- Kiểm tra phiên bản để xác nhận đã cài đặt thành công
```lftp --version```
# 3. Cài đặt Rclone
- Rclone có thể được tải trực tiếp từ trang chủ và cài đặt bằng lệnh sau:
- Tải script cài đặt Rclone
```curl https://rclone.org/install.sh | sudo bash```
- Kiểm tra phiên bản để xác nhận đã cài đặt thành công
```rclone --version```
- Lưu ý: Bạn có thể cần cấp quyền chạy cho install.sh nếu gặp lỗi quyền truy cập. Đảm bảo bạn có quyền sudo để thực thi script cài đặt.
- Cấu hình Rclone với S3
- Sau khi cài đặt Rclone, bạn có thể cấu hình kết nối với S3 như sau:
- Chạy lệnh cấu hình
```rclone config```
- Làm theo các bước được hỏi trong quá trình cấu hình để thiết lập S3 như một remote cho Rclone.
- Kiểm tra các gói cài đặt
- Sau khi cài đặt, bạn có thể kiểm tra lại từng công cụ để đảm bảo tất cả đã sẵn sàng sử dụng:
~~~
aws --version
lftp --version
rclone --version
~~~
- Như vậy, bạn đã cài đặt thành công AWS CLI, LFTP, và Rclone trên Ubuntu!
