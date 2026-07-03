<div align="center">
  <h1>📱 Thế Giới Máy Xây Dựng - Mobile App</h1>
  <p>Ứng dụng di động thương mại điện tử chuyên nghiệp dành cho thiết bị và máy móc xây dựng, được phát triển bằng Flutter.</p>
</div>

---

## 🌟 Giới Thiệu
Đây là ứng dụng di động chính thức của nền tảng **Thế Giới Máy Xây Dựng**, mang lại trải nghiệm mua sắm và quản lý thiết bị cơ giới tiện lợi ngay trên thiết bị di động. Ứng dụng tích hợp hoàn hảo với hệ thống Backend thông qua RESTful APIs.

## 🚀 Tính Năng Nổi Bật

- **Trải Nghiệm Mua Sắm Mượt Mà (Premium E-commerce UI):** Thiết kế giao diện hiện đại, bố cục dạng thẻ (card layouts), đổ bóng tinh tế và các thành phần tối ưu hoá cho thao tác chạm.
- **Xác Thực Bảo Mật (Authentication):** Tích hợp đăng nhập, đăng ký và quản lý tài khoản qua API bảo mật Laravel Sanctum.
- **Quản Lý Giỏ Hàng & Thanh Toán (Cart & Checkout):** Thao tác thêm vào giỏ hàng, điều chỉnh số lượng thủ công và quy trình thanh toán thân thiện.
- **Danh Mục & Lọc Khám Phá (Dynamic Filtering):** Hệ thống lọc danh mục thông minh giúp người dùng dễ dàng tìm kiếm các dòng máy xúc, máy ủi phù hợp.
- **Lịch Sử Đơn Hàng (Order History):** Theo dõi trạng thái đơn hàng chi tiết dành cho người dùng đã đăng nhập.

## 💻 Yêu Cầu Hệ Thống

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Khuyến nghị bản Stable mới nhất)
- Android Studio / Xcode
- Thiết bị thật hoặc Emulator (Android/iOS)

## 🛠 Hướng Dẫn Cài Đặt & Khởi Chạy

1. **Cài đặt thư viện:**
   ```bash
   flutter pub get
   ```

2. **Cấu hình API Endpoint:**
   Hãy chắc chắn rằng bạn đã cập nhật đường dẫn API Backend (`BASE_URL`) trỏ về máy chủ Laravel hoặc local IP của bạn (vd: `http://192.168.1.x:8000/api`) trong source code.

3. **Chạy Ứng dụng:**
   ```bash
   flutter run
   ```

## 🏗 Cấu Trúc Thư Mục

- `lib/screens/`: Chứa toàn bộ giao diện UI của ứng dụng (Home, Product, Cart, Profile,...).
- `lib/providers/` hoặc `lib/controllers/`: Xử lý trạng thái (State Management) và logic kết nối API.
- `lib/models/`: Định nghĩa các cấu trúc dữ liệu mapping từ JSON của API.
- `lib/services/`: Nơi chứa các service giao tiếp HTTP (Dio/http).

## 📞 Liên Hệ & Hỗ Trợ

Nếu có bất kỳ thắc mắc hay vấn đề nào trong quá trình cài đặt, vui lòng liên hệ đội ngũ phát triển.

---
*Phát triển trên nền tảng Flutter.*
