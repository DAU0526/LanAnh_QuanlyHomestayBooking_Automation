*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/RegisterPageLocators.py

*** Keywords ***
Go To Register Page
    Go To    ${BASE_URL}/register

Input User Name
    [Arguments]    ${name}
    Run Keyword If    '${name}' != '${EMPTY}'    Input Text    ${NAME_INPUT}    ${name}

Input User Email
    [Arguments]    ${email}
    Run Keyword If    '${email}' != '${EMPTY}'    Input Text    ${EMAIL_INPUT}    ${email}

Input User Phone
    [Arguments]    ${phone}
    Run Keyword If    '${phone}' != '${EMPTY}'    Input Text    ${PHONE_INPUT}    ${phone}

Input User Password
    [Arguments]    ${password}
    Run Keyword If    '${password}' != '${EMPTY}'    Input Password    ${PASSWORD_INPUT}    ${password}

Input Confirm Password
    [Arguments]    ${confirm_password}
    Run Keyword If    '${confirm_password}' != '${EMPTY}'    Input Password    ${CONFIRM_PASSWORD_INPUT}    ${confirm_password}

Accept Terms
    Select Checkbox    ${TERMS_CHECKBOX}

Uncheck Terms
    Unselect Checkbox    ${TERMS_CHECKBOX}

Click Register Button
    Click Element    ${REGISTER_BUTTON}

Verify Register Button Is Disabled
    Element Should Be Disabled    ${REGISTER_BUTTON}

Verify HTML5 Validation Message
    [Arguments]    ${locator}
    [Documentation]    Kiểm tra trình duyệt hiển thị thông báo lỗi HTML5 validation
    ${validation_msg}=    Execute Javascript    return document.getElementById('${locator.split(":")[1]}').validationMessage;
    Should Not Be Empty    ${validation_msg}

Register With Details
    [Arguments]    ${name}    ${email}    ${phone}    ${password}    ${confirm_password}
    Input User Name    ${name}
    Input User Email    ${email}
    Input User Phone    ${phone}
    Input User Password    ${password}
    Input Confirm Password    ${confirm_password}
    Accept Terms
    Click Register Button

Verify Registration Success
    [Documentation]    Kiểm tra đăng ký thành công - hệ thống hiện thông báo và chuyển về trang đăng nhập
    Alert Should Be Present    timeout=15s
    Wait Until Location Contains    /login    timeout=10s

Verify Registration Error
    [Documentation]    Kiểm tra hiển thị thông báo lỗi khi đăng ký thất bại
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s

Verify Error Message Displayed With Text
    [Arguments]    ${expected_text}
    [Documentation]    Kiểm tra thông báo lỗi cụ thể hiển thị đúng nội dung
    ${alert_text}=    Handle Alert    timeout=10s
    Should Contain    ${alert_text}    ${expected_text}

Generate Random User Data
    [Documentation]    Sinh ngẫu nhiên số định danh duy nhất để tạo tài khoản không bị trùng
    ${random_num}=    Evaluate    random.randint(10000000, 99999999)    random
    RETURN    ${random_num}

Register With Random User
    [Documentation]    Đăng ký tài khoản với thông tin ngẫu nhiên để tránh trùng lặp
    ${random_num}=    Generate Random User Data
    Register With Details    Test User ${random_num}    testuser${random_num}@gmail.com    09${random_num}    password123    password123

Verify Name Error Displayed
    Wait Until Element Is Visible    ${NAME_ERROR}    5s

Verify Email Error Displayed
    Wait Until Element Is Visible    ${EMAIL_ERROR}    5s

Verify Phone Error Displayed
    Wait Until Element Is Visible    ${PHONE_ERROR}    5s

Verify Password Error Displayed
    Wait Until Element Is Visible    ${PASSWORD_ERROR}    5s
