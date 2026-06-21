*** Settings ***
Documentation    Test các luồng Đăng nhập hệ thống
Library          SeleniumLibrary
Library          String
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/HomePage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 Valid Login Should Succeed
    [Documentation]    Đăng nhập thành công với tài khoản hợp lệ
    Go To Login Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Success

TC_02 Login With Empty Fields
    [Documentation]    Bỏ trống cả Email và Password - hệ thống hiển thị lỗi HTML5
    Go To Login Page
    Login With Credentials    ${EMPTY}    ${EMPTY}
    Verify HTML5 Validation Message    id:email

TC_03 Login With Empty Email
    [Documentation]    Bỏ trống trường Email - hệ thống hiển thị lỗi HTML5
    Go To Login Page
    Login With Credentials    ${EMPTY}    ${VALID_PASSWORD}
    Verify HTML5 Validation Message    id:email

TC_04 Login With Empty Password
    [Documentation]    Bỏ trống trường Password - hệ thống hiển thị lỗi HTML5
    Go To Login Page
    Login With Credentials    ${VALID_USER}    ${EMPTY}
    Verify HTML5 Validation Message    id:password

TC_05 Login With Unregistered Email
    [Documentation]    Email chưa đăng ký trong hệ thống - hệ thống báo lỗi
    Go To Login Page
    Login With Credentials    unregistered_email123@gmail.com    password123
    Verify Error Message Displayed

TC_06 Login With Wrong Password
    [Documentation]    Sai mật khẩu - hệ thống báo lỗi đăng nhập
    Go To Login Page
    Login With Credentials    ${VALID_USER}    wrongpassword
    Verify Error Message Displayed

TC_07 Login With Invalid Email Format
    [Documentation]    Email sai định dạng (thiếu @) - hệ thống hiển thị lỗi HTML5
    Go To Login Page
    Login With Credentials    invalid_email_format    ${VALID_PASSWORD}
    Verify HTML5 Validation Message    id:email

TC_08 Login With Short Password
    [Documentation]    Mật khẩu dưới 6 ký tự - hệ thống hiển thị cảnh báo
    Go To Login Page
    Login With Credentials    ${VALID_USER}    123
    Verify Short Password Behavior

TC_09 Login With Uppercase Email
    [Documentation]    Email viết hoa vẫn đăng nhập thành công (không phân biệt hoa/thường)
    Go To Login Page
    ${uppercase_email}=    Convert To Uppercase    ${VALID_USER}
    Login With Credentials    ${uppercase_email}    ${VALID_PASSWORD}
    Verify Login Success

TC_10 Login With Email Containing Spaces
    [Documentation]    Email có khoảng trắng đầu/cuối - hệ thống tự trim hoặc chấp nhận
    Go To Login Page
    Login With Credentials    ${SPACE}${VALID_USER}${SPACE}    ${VALID_PASSWORD}
    Verify Email With Spaces Behavior

TC_14 Login With Wrong Password Case Sensitivity
    [Documentation]    Mật khẩu phân biệt hoa/thường - đăng nhập sai nếu sai case
    Go To Login Page
    ${uppercase_pass}=    Convert To Uppercase    ${VALID_PASSWORD}
    Login With Credentials    ${VALID_USER}    ${uppercase_pass}
    Verify Error Message Displayed

TC_15 Password Field Is Masked
    [Documentation]    Trường mật khẩu được ẩn bằng dấu chấm vì lý do bảo mật
    Go To Login Page
    Verify Password Field Is Masked
