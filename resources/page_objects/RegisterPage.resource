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

Verify Name Error Displayed
    Wait Until Element Is Visible    ${NAME_ERROR}    5s

Verify Email Error Displayed
    Wait Until Element Is Visible    ${EMAIL_ERROR}    5s

Verify Phone Error Displayed
    Wait Until Element Is Visible    ${PHONE_ERROR}    5s

Verify Password Error Displayed
    Wait Until Element Is Visible    ${PASSWORD_ERROR}    5s
