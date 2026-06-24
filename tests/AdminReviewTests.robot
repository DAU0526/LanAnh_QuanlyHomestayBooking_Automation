*** Settings ***
Documentation    Test luồng quản lý đánh giá (Admin)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/AdminReviewsPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Variables ***
${ADMIN_USER}        admin@gmail.com
${ADMIN_PASSWORD}    password

*** Test Cases ***
TC_01 Admin Can Toggle Review Visibility
    [Documentation]    Đổi trạng thái hiển thị của đánh giá đầu tiên
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Reviews Page
    Toggle First Review Visibility

TC_02 Admin Can Delete Review
    [Documentation]    Xóa đánh giá đầu tiên
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Reviews Page
    Delete First Review
