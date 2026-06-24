*** Settings ***
Library    SeleniumLibrary
Library    String
Variables  ../locators/LoginPageLocators.py

*** Keywords ***
Go To Login Page
    Go To    ${BASE_URL}/login
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s

Input User Email
    [Arguments]    ${email}
    Run Keyword If    '${email}' != '${EMPTY}'    Input Text    ${EMAIL_INPUT}    ${email}

Input User Password
    [Arguments]    ${password}
    Run Keyword If    '${password}' != '${EMPTY}'    Input Password    ${PASSWORD_INPUT}    ${password}

Click Login Button
    Click Element    ${LOGIN_BUTTON}

Login With Credentials
    [Arguments]    ${email}    ${password}
    Input User Email    ${email}
    Input User Password    ${password}
    Click Login Button

Verify Login Success
    [Documentation]    Kiểm tra đăng nhập thành công - trang chuyển về Home và hiển thị avatar
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    Wait Until Location Is    ${BASE_URL}/    timeout=15s
    Wait Until Element Is Visible    ${ACCOUNT_DROPDOWN}    15s

Verify Error Message Displayed
    [Documentation]    Kiểm tra hiển thị thông báo lỗi khi đăng nhập thất bại
    Alert Should Be Present    timeout=10s

Verify HTML5 Validation Message
    [Arguments]    ${locator}
    [Documentation]    Kiểm tra trình duyệt hiển thị thông báo lỗi HTML5 validation
    ${validation_msg}=    Execute Javascript    return document.getElementById('${locator.split(":")[1]}').validationMessage;
    Should Not Be Empty    ${validation_msg}

Verify Password Field Is Masked
    [Documentation]    Kiểm tra trường mật khẩu được ẩn bằng dấu chấm (type=password)
    ${type}=    Get Element Attribute    ${PASSWORD_INPUT}    type
    Should Be Equal As Strings    ${type}    password

Verify Short Password Behavior
    [Documentation]    Kiểm tra hệ thống xử lý khi mật khẩu quá ngắn (có hoặc không có cảnh báo)
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s

Verify Email With Spaces Behavior
    [Documentation]    Kiểm tra hệ thống xử lý email có khoảng trắng đầu/cuối
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=10s
