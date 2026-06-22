*** Settings ***
Library         SeleniumLibrary
Variables       ../locators/AdminVouchersLocators.py

*** Keywords ***
Go To Admin Vouchers Page
    Go To    ${BASE_URL}/admin/vouchers
    Wait Until Location Contains    /admin/vouchers    timeout=10s
    Wait Until Page Contains Element    ${BTN_ADD_VOUCHER}    timeout=10s

Click Add Voucher Button
    Click Element    ${BTN_ADD_VOUCHER}
    Wait Until Page Contains Element    ${INPUT_CODE}    timeout=5s

Fill Voucher Form
    [Arguments]    ${code}    ${type}    ${value}    ${max_uses}=${EMPTY}
    Input Text    ${INPUT_CODE}    ${code}
    Select From List By Value    ${SELECT_DISCOUNT_TYPE}    ${type}
    Input Text    ${INPUT_DISCOUNT_VALUE}    ${value}
    Run Keyword If    '${max_uses}' != '${EMPTY}'    Input Text    ${INPUT_MAX_USES}    ${max_uses}

Submit Voucher Form
    Click Element    ${BTN_SAVE_VOUCHER}
    Wait Until Page Does Not Contain Element    ${BTN_SAVE_VOUCHER}    timeout=5s
    Sleep    1s    # Wait for API reload

Click Edit Voucher
    [Arguments]    ${code}
    ${edit_btn}=    Set Variable    xpath=//td[contains(., '${code}')]/..//button[contains(@class, 'text-blue-600')]
    Wait Until Page Contains Element    ${edit_btn}    timeout=5s
    Click Element    ${edit_btn}
    Wait Until Page Contains Element    ${INPUT_CODE}    timeout=5s

Click Delete Voucher
    [Arguments]    ${code}
    ${delete_btn}=    Set Variable    xpath=//td[contains(., '${code}')]/..//button[contains(@class, 'text-red-600')]
    Wait Until Page Contains Element    ${delete_btn}    timeout=5s
    Click Element    ${delete_btn}
