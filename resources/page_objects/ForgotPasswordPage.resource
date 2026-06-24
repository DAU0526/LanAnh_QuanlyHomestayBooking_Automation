*** Settings ***
Library         SeleniumLibrary
Variables       ../locators/ForgotPasswordLocators.py

*** Keywords ***
Go To Forgot Password Page
    Go To    ${BASE_URL}/forgot-password
    Wait Until Location Contains    /forgot-password    timeout=10s
    Wait Until Page Contains Element    ${INPUT_LOGIN_ID}    timeout=10s

Submit Forgot Password Form
    [Arguments]    ${login_id}
    Input Text    ${INPUT_LOGIN_ID}    ${login_id}
    Click Element    ${BTN_SUBMIT}

Verify Forgot Password Success
    Wait Until Page Contains Element    ${MSG_SUCCESS}    timeout=5s
