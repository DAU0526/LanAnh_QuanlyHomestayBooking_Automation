*** Settings ***
Library    SeleniumLibrary
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

Verify Error Message Displayed
    # Handle the Javascript alert that shows the error
    Alert Should Be Present    timeout=10s

Verify HTML5 Validation Message
    [Arguments]    ${locator}
    ${validation_msg}=    Execute Javascript    return document.getElementById('${locator.split(":")[1]}').validationMessage;
    Should Not Be Empty    ${validation_msg}

Verify Password Field Is Masked
    ${type}=    Get Element Attribute    ${PASSWORD_INPUT}    type
    Should Be Equal As Strings    ${type}    password
