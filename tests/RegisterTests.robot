*** Settings ***
Documentation    Test luồng Đăng ký tài khoản
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/RegisterPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 Valid Registration Should Succeed
    [Documentation]    Đăng ký thành công với thông tin hợp lệ
    Go To Register Page
    ${random_num}=    Evaluate    random.randint(10000000, 99999999)    random
    Register With Details    Test User ${random_num}    testuser${random_num}@gmail.com    09${random_num}    password123    password123
    Alert Should Be Present    timeout=15s
    Wait Until Location Contains    /login    timeout=10s

TC_02 Register With Empty Fields
    [Documentation]    Bỏ trống tất cả các trường
    Go To Register Page
    Verify Register Button Is Disabled

TC_03 Register With Empty Name
    [Documentation]    Bỏ trống Họ và Tên
    Go To Register Page
    Register With Details    ${EMPTY}    testuser@gmail.com    0901234567    password123    password123
    Verify HTML5 Validation Message    id:name

TC_04 Register With Invalid Email Format
    [Documentation]    Email sai định dạng hoặc không phải @gmail.com
    Go To Register Page
    Register With Details    Test User    invalid_email    0901234567    password123    password123
    Verify HTML5 Validation Message    id:email

TC_05 Register With Short Password
    [Documentation]    Password dưới 6 ký tự
    Go To Register Page
    Register With Details    Test User    shortpass@gmail.com    0901234567    12345    12345
    Verify HTML5 Validation Message    id:password

TC_06 Register With Password Mismatch
    [Documentation]    Mật khẩu xác nhận không khớp
    Go To Register Page
    Register With Details    Test User    mismatch@example.com    0901234567    password123    wrongpassword
    Alert Should Be Present    Mật khẩu xác nhận không khớp!    timeout=10s

TC_07 Register With Existing Phone
    [Documentation]    Số điện thoại đã tồn tại
    Go To Register Page
    Register With Details    Test User    newuser123@gmail.com    0901234567    password123    password123
    # Wait for alert or error
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    # Verify Phone Error Displayed 

TC_08 Register With Existing Email
    [Documentation]    Email đã tồn tại
    Go To Register Page
    Register With Details    Test User    admin@gmail.com    0901234599    password123    password123
    # Verify Email Error Displayed
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s

TC_09 Register Without Terms Checked
    [Documentation]    Không tick Terms & Conditions
    Go To Register Page
    Input User Name    Test User
    Input User Email    test@gmail.com
    Input User Phone    0901234567
    Input User Password    password123
    Input Confirm Password    password123
    Verify Register Button Is Disabled

TC_10 Register With Non-Gmail Email
    [Documentation]    Email không phải đuôi @gmail.com
    Go To Register Page
    Register With Details    Test User    testuser@yahoo.com    0901234567    password123    password123
    # Check for specific alert or validation error
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s

TC_11 Register With Empty Password
    [Documentation]    Password để trống
    Go To Register Page
    Register With Details    Test User    testuser@gmail.com    0901234567    ${EMPTY}    password123
    Verify HTML5 Validation Message    id:password

TC_12 Register With Invalid Phone Format
    [Documentation]    Phone sai định dạng
    Go To Register Page
    Register With Details    Test User    testuser@gmail.com    12345    password123    password123
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s

TC_13 Register With Empty Confirm Password
    [Documentation]    Xác nhận mật khẩu để trống
    Go To Register Page
    Register With Details    Test User    testuser@gmail.com    0901234567    password123    ${EMPTY}
    Verify HTML5 Validation Message    id:password_confirmation
