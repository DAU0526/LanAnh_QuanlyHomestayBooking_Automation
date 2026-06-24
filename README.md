# Homestay Booking - QA Automation Framework
---

# Project Overview

Automation Testing Framework cho hệ thống:
**Homestay Booking Management System**

📍 **LIVE DEMO (Trang web thực tế):** [https://homestaybooking.id.vn/](https://homestaybooking.id.vn/)

Framework này được sử dụng để tự động kiểm thử toàn bộ giao diện và chức năng của Web Application với độ bao phủ (Test Coverage) lên tới 100% các luồng nghiệp vụ quan trọng.

Mục tiêu:
- Automation UI Testing (Kiểm thử tự động giao diện)
- Regression Testing (Kiểm thử hồi quy)
- Tự động hóa quá trình Check-in/Check-out, Đặt phòng, Quản lý Admin
- Sinh báo cáo HTML tự động kèm ảnh chụp màn hình khi có lỗi

---

# Technology Stack

| Technology | Usage |
|---|---|
| Python | Programming Language |
| Robot Framework | Automation Framework |
| SeleniumLibrary | Web Automation |
| ChromeDriver | Browser Driver |
| YAML | Environment Configuration |
| Page Object Model | Test Architecture |

---

# Requirements

| Tool | Version |
|---|---|
| Python | 3.8+ |
| Google Chrome | Latest |
| ChromeDriver | Match Chrome |
| Robot Framework | 7.x |

Kiểm tra version:
```bash
python --version
robot --version
```

---

# Installation & Setup

## Clone Repository

```bash
git clone https://github.com/DAU0526/LanAnh_QuanlyHomestayBooking_Automation.git
cd LanAnh_QuanlyHomestayBooking_Automation
```

## Install Libraries

```bash
pip install -r requirements.txt
```

---

# Project Structure (Cây Thư Mục)

Dự án được tổ chức theo chuẩn **Page Object Model (POM)** chuyên nghiệp:

```text
LanAnh_QuanlyHomestayBooking_Automation/
│
├── resources/
│   ├── locators/                    # Chứa toàn bộ XPath/CSS Selectors
│   │   ├── AdminReviewsLocators.py
│   │   ├── AdminRoomsLocators.py
│   │   ├── AdminUsersLocators.py
│   │   ├── AdminVouchersLocators.py
│   │   ├── CheckoutPageLocators.py
│   │   ├── ForgotPasswordLocators.py
│   │   ├── HomePageLocators.py
│   │   ├── ListingPageLocators.py
│   │   ├── LoginPageLocators.py
│   │   ├── RegisterPageLocators.py
│   │   └── RoomDetailPageLocators.py
│   │
│   ├── page_objects/                # Chứa các hàm xử lý hành vi (Click, Input...)
│   │   ├── AdminReviewsPage.resource
│   │   ├── AdminRoomsPage.resource
│   │   ├── AdminUsersPage.resource
│   │   ├── AdminVouchersPage.resource
│   │   ├── CheckoutPage.resource
│   │   ├── ForgotPasswordPage.resource
│   │   ├── HomePage.resource
│   │   ├── ListingPage.resource
│   │   ├── LoginPage.resource
│   │   ├── RegisterPage.resource
│   │   └── RoomDetailPage.resource
│   │
│   ├── common_keywords.resource     # Các hàm dùng chung (Mở trình duyệt, chụp ảnh...)
│   └── environment.variables.yml    # Cấu hình biến môi trường (URL, Trình duyệt)
│
├── results/                         # Nơi lưu trữ Báo cáo tự động
│   ├── log.html                     # Báo cáo chi tiết từng bước
│   ├── output.xml                   
│   └── report.html                  # Báo cáo tổng quan (Dashboard)
│
├── tests/                           # Chứa 52 Test Cases (Kịch bản kiểm thử)
│   ├── AdminAdvancedTests.robot     # Lễ tân: Check-in, Check-out
│   ├── AdminReviewTests.robot       # Quản lý Đánh giá
│   ├── AdminRoomTests.robot         # Quản lý Phòng
│   ├── AdminUserTests.robot         # Quản lý User
│   ├── AdminVoucherTests.robot      # Quản lý Voucher
│   ├── AdvancedCheckoutTests.robot  # Đặt phòng & Thanh toán
│   ├── AuthAdvancedTests.robot      # Quên mật khẩu
│   ├── LoginTests.robot             # Đăng nhập
│   ├── RegisterTests.robot          # Đăng ký
│   ├── SearchTests.robot            # Tìm kiếm & Lọc
│   └── UserBookingTests.robot       # Lịch sử đặt phòng & Hủy phòng
│
├── run_test.bat                     # Bảng Menu tự động chạy Test (Click đúp để dùng)
├── run.py                           # Custom CLI Runner lõi Python
├── requirements.txt                 
└── README.md
```

---

# Automation Architecture (Kiến Trúc)

```text
Test Cases (tests/)
      |
      v
Common Keywords (resources/common_keywords.resource)
      |
      v
Page Objects (resources/page_objects/)
      |
      v
Locators (resources/locators/)
      |
      v
Homestay Web Application (https://homestaybooking.id.vn)
```

---

# Hướng Dẫn Chạy Test (How to run)

Chúng tôi đã cung cấp sẵn công cụ **Custom CLI Runner** để giúp bạn chạy test một cách trực quan và dễ dàng nhất mà không cần nhớ lệnh phức tạp.

## Cách 1: Sử dụng Menu Trực Quan (Dành cho Windows)
Chỉ cần mở thư mục dự án và **Click đúp vào file `run_test.bat`**. Một bảng Menu sẽ hiện ra cho phép bạn chọn luồng muốn test:
```text
[1] Chạy toàn bộ 52 chức năng (Full Suite)
[2] Chạy luồng Đăng Nhập (Login)
...
```
Sau khi chạy xong, nó sẽ tự động bật trình duyệt web mở file Báo cáo (`report.html`).

## Cách 2: Sử dụng dòng lệnh Python (CLI)
Mở Terminal và gõ:
- Chạy toàn bộ Test: `python run.py`
- Chỉ chạy 1 luồng cụ thể: `python run.py --suite login`
- Chạy ngầm (Không hiện trình duyệt): `python run.py --headless`

## Cách 3: Chạy bằng lệnh Gốc của Robot Framework
```bash
robot -d results tests/
```

---

# Test Coverage (Phạm Vi Kiểm Thử)

Hệ thống sở hữu tổng cộng **52 Kịch bản kiểm thử (Test Cases)** bao phủ 100% các tính năng, được chia thành:

| Nhóm Tính Năng | Số lượng Kịch bản |
|---|---|
| **Người Dùng (User)** |
| Đăng ký (Register) | 13 |
| Đăng nhập (Login) | 11 |
| Tìm kiếm (Search) | 2 |
| Đặt phòng & Thanh toán (Checkout) | 3 |
| Quản lý lịch sử đặt phòng (User Bookings) | 2 |
| Quên mật khẩu (Auth) | 1 |
| **Quản Trị (Admin & Receptionist)** |
| Quản lý Phòng (Admin Rooms) | 3 |
| Quản lý Voucher (Admin Vouchers) | 3 |
| Quản lý Tài khoản (Admin Users) | 3 |
| Quản lý Đánh giá (Admin Reviews) | 2 |
| Check-in / Check-out (Admin Advanced) | 2 |
| **Tổng Cộng** | **45 Tests (Core) + 7 Mở rộng = 52 Tests** |

---

# Test Report (Báo Cáo)

Sau mỗi lần chạy, hệ thống sẽ xuất ra các file báo cáo tại thư mục `results/`:
- **`report.html`**: Biểu đồ hiển thị tỷ lệ Pass/Fail cực kỳ chuyên nghiệp.
- **`log.html`**: Ghi log chi tiết từng thao tác click, điền text... Kèm theo **ảnh chụp màn hình** (Screenshot) ngay tại thời điểm xảy ra lỗi.
