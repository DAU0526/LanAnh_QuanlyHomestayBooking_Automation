*** Settings ***
Documentation    Test luồng Đăng ký tài khoản
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/RegisterPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 Valid Registration Should Succeed
    [Documentation]    Đăng ký thành công với thông tin hợp lệ và dữ liệu ngẫu nhiên
    Go To Register Page
    Register With Random User
    Verify Registration Success

TC_02 Register With Empty Fields
    [Documentation]    Bỏ trống tất cả các trường - nút Đăng ký bị vô hiệu hóa
    Go To Register Page
    Verify Register Button Is Disabled

TC_03 Register With Empty Name
    [Documentation]    Bỏ trống Họ và Tên - hệ thống hiển thị lỗi HTML5
    Go To Register Page
    Register With Details    ${EMPTY}    testuser@gmail.com    0901234567    password123    password123
    Verify HTML5 Validation Message    id:name

TC_04 Register With Invalid Email Format
    [Documentation]    Email sai định dạng - hệ thống hiển thị lỗi HTML5
    Go To Register Page
    Register With Details    Test User    invalid_email    0901234567    password123    password123
    Verify HTML5 Validation Message    id:email

TC_05 Register With Short Password
    [Documentation]    Mật khẩu dưới 6 ký tự - hệ thống hiển thị lỗi HTML5
    Go To Register Page
    Register With Details    Test User    shortpass@gmail.com    0901234567    12345    12345
    Verify HTML5 Validation Message    id:password

TC_06 Register With Password Mismatch
    [Documentation]    Mật khẩu xác nhận không khớp - hệ thống báo lỗi
    Go To Register Page
    Register With Details    Test User    mismatch@example.com    0901234567    password123    wrongpassword
    Verify Error Message Displayed With Text    Mật khẩu xác nhận không khớp!

TC_07 Register With Existing Phone
    [Documentation]    Số điện thoại đã tồn tại - hệ thống báo lỗi trùng lặp
    Go To Register Page
    Register With Details    Test User    newuser123@gmail.com    0901234567    password123    password123
    Verify Registration Error

TC_08 Register With Existing Email
    [Documentation]    Email đã tồn tại - hệ thống báo lỗi trùng lặp
    Go To Register Page
    Register With Details    Test User    admin@gmail.com    0901234599    password123    password123
    Verify Registration Error

TC_09 Register Without Terms Checked
    [Documentation]    Không tick chấp nhận Điều khoản - nút Đăng ký bị vô hiệu hóa
    Go To Register Page
    Input User Name    Test User
    Input User Email    test@gmail.com
    Input User Phone    0901234567
    Input User Password    password123
    Input Confirm Password    password123
    Verify Register Button Is Disabled

TC_10 Register With Non-Gmail Email
    [Documentation]    Email không phải đuôi @gmail.com - hệ thống từ chối
    Go To Register Page
    Register With Details    Test User    testuser@yahoo.com    0901234567    password123    password123
    Verify Registration Error

TC_11 Register With Empty Password
    [Documentation]    Để trống trường Mật khẩu - hệ thống hiển thị lỗi HTML5
    Go To Register Page
    Register With Details    Test User    testuser@gmail.com    0901234567    ${EMPTY}    password123
    Verify HTML5 Validation Message    id:password

TC_12 Register With Invalid Phone Format
    [Documentation]    Số điện thoại sai định dạng (quá ngắn) - hệ thống báo lỗi
    Go To Register Page
    Register With Details    Test User    testuser@gmail.com    12345    password123    password123
    Verify Registration Error

TC_13 Register With Empty Confirm Password
    [Documentation]    Để trống trường Xác nhận mật khẩu - hệ thống hiển thị lỗi HTML5
    Go To Register Page
    Register With Details    Test User    testuser@gmail.com    0901234567    password123    ${EMPTY}
    Verify HTML5 Validation Message    id:password_confirmation
