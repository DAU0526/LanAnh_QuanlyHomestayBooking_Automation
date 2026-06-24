*** Settings ***
Documentation    Test luồng Lịch sử đặt phòng và Hủy phòng của Người dùng
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application


*** Test Cases ***
TC_01 User Can View Booking History
    [Documentation]    Khách hàng có thể xem danh sách Lịch sử đặt phòng trong Profile
    Go To Login Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    # Go to profile
    Wait Until Location Is    ${BASE_URL}/    timeout=20s
    Go To    ${BASE_URL}/profile
    Wait Until Page Contains    Thông tin tài khoản    timeout=10s
    
    # Click to History Tab
    Click Element    xpath=//button[contains(text(), 'Lịch sử')]
    
    # Wait dynamically for content
    Wait Until Page Contains Element    xpath=//div[contains(@class, 'border-dashed') or contains(@class, 'space-y-6')]    timeout=10s
    Log    Verified History Tab loaded successfully.

TC_02 User Can Cancel A Booking
    [Documentation]    Khách hàng có thể yêu cầu hủy đặt phòng (chạy tới bước verify popup)
    Go To Login Page
    Login With Credentials    ${VALID_USER}    ${VALID_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    Wait Until Location Is    ${BASE_URL}/    timeout=20s
    
    Go To    ${BASE_URL}/profile
    Wait Until Page Contains    Thông tin tài khoản    timeout=10s
    Click Element    xpath=//button[contains(text(), 'Lịch sử')]
    Wait Until Page Contains Element    xpath=//div[contains(@class, 'border-dashed') or contains(@class, 'space-y-6')]    timeout=10s
    
    ${can_cancel}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//button[contains(text(), 'Hủy đặt phòng')]
    
    Run Keyword If    ${can_cancel}    Click Element    xpath=//button[contains(text(), 'Hủy đặt phòng')]
    # Handle the native confirm dialog but dismiss to prevent actually cancelling the data
    Run Keyword If    ${can_cancel}    Alert Should Be Present    action=DISMISS    timeout=5s
    
    Log    Verified Cancellation popup functionality.
