*** Settings ***
Library         SeleniumLibrary
Variables       ../locators/AdminReviewsLocators.py

*** Keywords ***
Go To Admin Reviews Page
    Go To    ${BASE_URL}/admin/reviews
    Wait Until Location Contains    /admin/reviews    timeout=10s
    Wait Until Page Contains Element    xpath=//h1[contains(text(), 'Quản lý Đánh giá')]    timeout=10s

Toggle First Review Visibility
    ${has_reviews}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_TOGGLE_FIRST}
    Run Keyword If    ${has_reviews}    Click Element    ${BTN_TOGGLE_FIRST}
    Sleep    1s    # Wait for API reload

Delete First Review
    ${has_reviews}=    Run Keyword And Return Status    Page Should Contain Element    ${BTN_DELETE_FIRST}
    Run Keyword If    ${has_reviews}    Click Element    ${BTN_DELETE_FIRST}
    Run Keyword If    ${has_reviews}    Alert Should Be Present    action=ACCEPT    timeout=5s
    Sleep    1s    # Wait for API reload
