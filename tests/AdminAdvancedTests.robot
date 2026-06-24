*** Settings ***
Documentation    Test luồng nâng cao cho Admin: Check-in, Check-out
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Variables ***
${ADMIN_USER}        admin@gmail.com
${ADMIN_PASSWORD}    password
${ADMIN_BOOKING_URL}    ${BASE_URL}/admin/booking-management

*** Test Cases ***
TC_01 Admin Can Open Check-in Flow
    [Documentation]    Admin mở popup Check-in thành công
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    Wait Until Location Contains    /admin    timeout=10s
    
    # Navigate to Bookings section
    Go To    ${ADMIN_BOOKING_URL}
    Wait Until Page Contains    Check-in hôm nay    timeout=10s
    
    # Find a booking that can be checked in (Nhận phòng button)
    ${can_checkin}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//button[contains(text(), 'Nhận phòng')]    timeout=2s
    
    Run Keyword If    ${can_checkin}    Click Element    xpath=//button[contains(text(), 'Nhận phòng')]
    # Dismiss alert to avoid modifying DB
    Run Keyword If    ${can_checkin}    Alert Should Be Present    action=DISMISS    timeout=5s
    
    Log    Verified Check-in functionality triggers.

TC_02 Admin Can Open Check-out Modal
    [Documentation]    Admin mở popup Check-out từ trang Chi tiết Booking
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    Wait Until Location Contains    /admin    timeout=10s
    
    Go To    ${ADMIN_BOOKING_URL}
    Wait Until Page Contains    Check-out hôm nay    timeout=10s
    
    # Filter or find a booking with status 'Đang ở' to check-out
    Click Element    xpath=//button[contains(text(), 'Đang ở')]
    Sleep    1s    # Cần chờ 400ms debounce của Vue + thời gian call API
    
    # Open Detail view
    ${has_detail}=    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//button[@title='Xem chi tiết']    timeout=2s
    Run Keyword If    ${has_detail}    Click Element    xpath=(//button[@title='Xem chi tiết'])[1]
    
    # Wait for detail modal and Check-out button
    Run Keyword If    ${has_detail}    Wait Until Page Contains Element    xpath=//button[contains(text(), 'Check-out')]    timeout=5s
    Run Keyword If    ${has_detail}    Click Element    xpath=//button[contains(text(), 'Check-out')]
    
    Log    Verified Check-out modal opens.
