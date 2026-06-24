*** Settings ***
Documentation    Test luồng người dùng (Quên mật khẩu)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/ForgotPasswordPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 User Can Request Password Reset
    [Documentation]    Test yêu cầu đặt lại mật khẩu với email
    Go To Forgot Password Page
    Submit Forgot Password Form    test_auto_user@gmail.com
    Verify Forgot Password Success
