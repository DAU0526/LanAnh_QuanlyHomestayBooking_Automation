*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/HomePageLocators.py

*** Keywords ***
Verify Home Page Is Loaded
    Wait Until Element Is Visible    ${SEARCH_BUTTON}    10s

Search For Homestay
    [Arguments]    ${homestay_name}
    Input Text    ${NAME_SEARCH_INPUT}    ${homestay_name}
    Click Element    ${SEARCH_BUTTON}

Verify Search Results Are Shown
    [Documentation]    Kiểm tra trang kết quả tìm kiếm hiển thị sau khi search
    Wait Until Location Contains    /listing    timeout=10s
    Wait Until Element Is Visible    ${ROOM_CARDS}    10s

Verify User Is Logged In
    Element Should Be Visible    ${ACCOUNT_DROPDOWN}
