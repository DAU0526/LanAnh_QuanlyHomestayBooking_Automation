*** Settings ***
Documentation    Test luồng quản lý voucher (Admin)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/AdminVouchersPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Variables ***
${ADMIN_USER}        admin@gmail.com
${ADMIN_PASSWORD}    password
${TEST_VOUCHER_CODE}    TESTROBOT999

*** Test Cases ***
TC_01 Admin Can Create New Voucher
    [Documentation]    Tạo một voucher mới và xác nhận thành công
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Vouchers Page
    Click Add Voucher Button
    Fill Voucher Form    ${TEST_VOUCHER_CODE}    fixed    50000    10
    Submit Voucher Form
    
    # Verify voucher is in the list
    Wait Until Page Contains    ${TEST_VOUCHER_CODE}    timeout=5s

TC_02 Admin Can Edit Existing Voucher
    [Documentation]    Sửa voucher vừa tạo
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Vouchers Page
    Wait Until Page Contains    ${TEST_VOUCHER_CODE}    timeout=5s
    Click Edit Voucher    ${TEST_VOUCHER_CODE}
    
    # Change discount value
    Wait Until Page Contains Element    ${INPUT_DISCOUNT_VALUE}    timeout=5s
    Input Text    ${INPUT_DISCOUNT_VALUE}    60000
    Submit Voucher Form
    
    # Verify change
    Wait Until Page Contains    60.000    timeout=5s

TC_03 Admin Can Delete Voucher
    [Documentation]    Xóa voucher vừa tạo để dọn dẹp dữ liệu rác
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Vouchers Page
    Wait Until Page Contains    ${TEST_VOUCHER_CODE}    timeout=5s
    Click Delete Voucher    ${TEST_VOUCHER_CODE}
    
    # Xử lý confirm dialog xóa
    Alert Should Be Present    action=ACCEPT    timeout=5s
    
    Sleep    1s    # Wait for Vue to remove row
    Wait Until Page Does Not Contain    ${TEST_VOUCHER_CODE}    timeout=5s
