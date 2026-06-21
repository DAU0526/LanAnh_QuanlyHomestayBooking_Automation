*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/ListingPageLocators.py

*** Keywords ***
Go To Listing Page
    Go To    ${BASE_URL}/listing
    Wait Until Location Contains    /listing    timeout=10s

Verify Listing Page Is Loaded
    Wait Until Element Is Visible    ${ROOM_CARD}    10s

Filter By Price Range
    [Arguments]    ${min_price}    ${max_price}
    Input Text    ${MIN_PRICE_INPUT}    ${min_price}
    Input Text    ${MAX_PRICE_INPUT}    ${max_price}
    Click Element    ${FILTER_BUTTON}

Verify Rooms Are Displayed
    [Documentation]    Kiểm tra danh sách phòng hiển thị sau khi lọc
    Wait Until Element Is Visible    ${ROOM_CARD}    10s

Click On First Room
    Wait Until Element Is Visible    ${FIRST_ROOM}    10s
    Click Element    ${FIRST_ROOM}
