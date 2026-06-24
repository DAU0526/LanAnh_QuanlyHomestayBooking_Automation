*** Settings ***
Documentation    Test luồng Đặt phòng nâng cao và bắt lỗi nghiệp vụ
Library          DateTime
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/HomePage.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/CheckoutPage.resource
Resource         ../resources/page_objects/ListingPage.resource
Resource         ../resources/page_objects/RoomDetailPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 User Can Book A Room Successfully After Login
    [Documentation]    Đăng nhập, chọn phòng, điền ngày hợp lệ và đặt phòng thành công
    Go To Login Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Login Success
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${checkin_date}=    Add Time To Date    ${current_date}    5 days    result_format=%Y-%m-%d
    ${checkout_date}=    Add Time To Date    ${current_date}    7 days    result_format=%Y-%m-%d
    Go To    ${BASE_URL}/room/1
    Verify Room Detail Page Is Loaded
    Select Dates    ${checkin_date}    ${checkout_date}
    Go To    ${BASE_URL}/payment?roomId=1&checkIn=${checkin_date}&checkOut=${checkout_date}&adults=1
    Enter Customer Details    Nguyen Van A    nguyenvan.a@example.com    0901234567
    Click Confirm Booking
    Verify Booking Success

TC_02 Booking Fails When CheckOut Date Is Before CheckIn Date
    [Documentation]    Bắt lỗi khi ngày trả phòng nhỏ hơn ngày nhận phòng
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${past_date}=       Subtract Time From Date    ${current_date}    5 days    result_format=%Y-%m-%d
    Go To    ${BASE_URL}/room/1
    Verify Room Detail Page Is Loaded
    Select Dates    ${current_date}    ${past_date}
    Click Book Now
    Verify Date Validation Error

TC_03 Guest Cannot Complete Payment Without Login
    [Documentation]    Người dùng chưa đăng nhập không thể hoàn tất thanh toán
    ${current_date}=    Get Current Date    result_format=%Y-%m-%d
    ${checkin_date}=    Add Time To Date    ${current_date}    5 days    result_format=%Y-%m-%d
    ${checkout_date}=    Add Time To Date    ${current_date}    7 days    result_format=%Y-%m-%d
    Go To    ${BASE_URL}/payment?roomId=1&checkIn=${checkin_date}&checkOut=${checkout_date}&adults=1
    Enter Customer Details    Guest User    guest@example.com    0900000000
    Click Confirm Booking
    Verify Guest Cannot Book Without Login
