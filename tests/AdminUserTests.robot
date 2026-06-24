*** Settings ***
Documentation    Test luồng quản lý người dùng (Admin)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/AdminUsersPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Variables ***
${ADMIN_USER}        admin@gmail.com
${ADMIN_PASSWORD}    password
${TEST_NEW_USER_EMAIL}    test_auto_user@gmail.com

*** Test Cases ***
TC_01 Admin Can Create New User
    [Documentation]    Tạo một user mới và xác nhận thành công
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Users Page
    Click Add User Button
    Fill User Form    Test Auto User    ${TEST_NEW_USER_EMAIL}    0999888777
    Submit User Form
    
    # Verify user is in the list
    Search User    ${TEST_NEW_USER_EMAIL}
    Wait Until Page Contains    ${TEST_NEW_USER_EMAIL}    timeout=5s

TC_02 Admin Can Block And Unblock User
    [Documentation]    Khóa và Mở khóa user vừa tạo
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Users Page
    Search User    ${TEST_NEW_USER_EMAIL}
    Wait Until Page Contains    ${TEST_NEW_USER_EMAIL}    timeout=5s
    
    # Block
    Click Toggle User Status    ${TEST_NEW_USER_EMAIL}
    Wait Until Page Contains    Bị Khóa    timeout=5s
    
    # Unblock
    Click Toggle User Status    ${TEST_NEW_USER_EMAIL}
    Wait Until Page Contains    Hoạt động    timeout=5s

TC_03 Admin Can Delete User
    [Documentation]    Xóa user vừa tạo để dọn dẹp dữ liệu rác
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Users Page
    Search User    ${TEST_NEW_USER_EMAIL}
    Wait Until Page Contains    ${TEST_NEW_USER_EMAIL}    timeout=5s
    
    Click Delete User    ${TEST_NEW_USER_EMAIL}
    Wait Until Page Contains    Không tìm thấy người dùng nào    timeout=5s
