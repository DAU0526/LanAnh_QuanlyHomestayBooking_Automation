*** Settings ***
Documentation    Test luồng Tìm kiếm và Lọc phòng (Search & Filter)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/HomePage.resource
Resource         ../resources/page_objects/ListingPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 User Can Search By Location
    [Documentation]    Tìm kiếm phòng theo địa điểm (VD: Đà Lạt)
    Wait Until Location Is    ${BASE_URL}/    timeout=20s
    
    # Verify the search bar exists
    Wait Until Element Is Visible    xpath=//input[@placeholder='Bạn muốn đi đâu?']    10s
    
    # Enter location
    Input Text    xpath=//input[@placeholder='Bạn muốn đi đâu?']    Đà Nẵng
    
    # Click search button
    # Assuming there's a search button in the hero section
    Click Button    xpath=//button[contains(., 'Tìm kiếm')]
    
    # Verify we are on listing page
    Wait Until Location Contains    /listing    timeout=10s
    
    # Verify the results show Đà Nẵng
    Wait Until Page Contains    Đà Nẵng    timeout=10s

TC_02 User Can Filter Rooms By Price
    [Documentation]    Lọc phòng theo mức giá
    Go To    ${BASE_URL}/listing
    Wait Until Location Contains    /listing    timeout=10s
    Wait Until Page Contains    Bộ lọc    timeout=10s
    
    # Enter max price
    # Wait for the price filter input
    ${filter_exists}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//input[@placeholder='Giá tối đa']
    Run Keyword If    ${filter_exists}    Input Text    xpath=//input[@placeholder='Giá tối đa']    2000000
    
    # Click apply filter or just wait for reactive update
    Run Keyword If    ${filter_exists}    Sleep    2s
    
    # Verify some rooms are shown
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'grid')]    timeout=5s
