*** Settings ***
Library         SeleniumLibrary
Variables       ../locators/AdminUsersLocators.py

*** Keywords ***
Go To Admin Users Page
    Go To    ${BASE_URL}/admin/users
    Wait Until Location Contains    /admin/users    timeout=10s
    Wait Until Page Contains Element    ${BTN_ADD_USER}    timeout=10s

Click Add User Button
    Click Element    ${BTN_ADD_USER}
    Wait Until Page Contains Element    ${INPUT_NAME}    timeout=5s

Fill User Form
    [Arguments]    ${name}    ${email}    ${phone}    ${role}=customer    ${password}=password123
    Input Text    ${INPUT_NAME}    ${name}
    Input Text    ${INPUT_EMAIL}    ${email}
    Input Text    ${INPUT_PHONE}    ${phone}
    Select From List By Value    ${SELECT_ROLE}    ${role}
    Input Text    ${INPUT_PASSWORD}    ${password}

Submit User Form
    Click Element    ${BTN_SAVE_USER}
    # Wait for alert
    Alert Should Be Present    action=ACCEPT    timeout=5s
    Wait Until Page Does Not Contain Element    ${BTN_SAVE_USER}    timeout=5s

Search User
    [Arguments]    ${email}
    Input Text    ${INPUT_SEARCH}    ${email}
    Click Element    ${BTN_SEARCH}
    Sleep    1s    # Wait for API reload

Click Edit User
    [Arguments]    ${email}
    ${edit_btn}=    Set Variable    xpath=//td[contains(., '${email}')]/..//button[text()='Sửa']
    Wait Until Page Contains Element    ${edit_btn}    timeout=5s
    Click Element    ${edit_btn}
    Wait Until Page Contains Element    ${INPUT_NAME}    timeout=5s

Click Toggle User Status
    [Arguments]    ${email}
    ${toggle_btn}=    Set Variable    xpath=//td[contains(., '${email}')]/..//button[text()='Khóa' or text()='Mở Khóa']
    Wait Until Page Contains Element    ${toggle_btn}    timeout=5s
    Click Element    ${toggle_btn}
    Alert Should Be Present    action=ACCEPT    timeout=5s
    Sleep    1s    # Wait for API reload

Click Delete User
    [Arguments]    ${email}
    ${delete_btn}=    Set Variable    xpath=//td[contains(., '${email}')]/..//button[text()='Xóa']
    Wait Until Page Contains Element    ${delete_btn}    timeout=5s
    Click Element    ${delete_btn}
    Alert Should Be Present    action=ACCEPT    timeout=5s
    Sleep    1s    # Wait for API reload
