*** Settings ***
Documentation    Test luồng quản lý phòng (Admin)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/LoginPage.resource
Resource         ../resources/page_objects/AdminRoomsPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Variables ***
${ADMIN_USER}        admin@gmail.com
${ADMIN_PASSWORD}    password
${TEST_ROOM_TITLE}   Test Room Auto Robot 999
${TEST_ROOM_EDITED}  Test Room Auto Robot 999 Edited

*** Test Cases ***
TC_01 Admin Can Create New Room
    [Documentation]    Tạo một phòng mới và xác nhận thành công
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    Wait Until Location Contains    /admin    timeout=10s
    
    Go To Admin Rooms Page
    Click Add Room Button
    Select Whole House Mode
    Fill Room Form    ${TEST_ROOM_TITLE}    Đà Nẵng City    1500000    2    1
    Submit Room Form
    
    # Handle success alert
    Alert Should Be Present    action=ACCEPT    timeout=5s
    Wait Until Location Contains    /admin/rooms    timeout=10s
    
    # Verify room is in the list
    Search Room    ${TEST_ROOM_TITLE}
    Wait Until Page Contains    ${TEST_ROOM_TITLE}    timeout=5s

TC_02 Admin Can Edit Existing Room
    [Documentation]    Sửa tên phòng vừa tạo
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Rooms Page
    Search Room    ${TEST_ROOM_TITLE}
    Click Edit Room    ${TEST_ROOM_TITLE}
    
    # Change name, location and status
    Input Text    ${INPUT_TITLE}    ${TEST_ROOM_EDITED}
    Input Text    ${INPUT_LOCATION}    Đà Nẵng City Edited
    Submit Room Form
    
    Alert Should Be Present    action=ACCEPT    timeout=5s
    Wait Until Location Contains    /admin/rooms    timeout=10s
    
    Search Room    ${TEST_ROOM_EDITED}
    Wait Until Page Contains    ${TEST_ROOM_EDITED}    timeout=5s

TC_03 Admin Can Delete Room
    [Documentation]    Xóa phòng vừa tạo để dọn dẹp dữ liệu rác
    Go To Login Page
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=5s
    
    Go To Admin Rooms Page
    Search Room    ${TEST_ROOM_EDITED}
    Click Delete Room    ${TEST_ROOM_EDITED}
    
    # Handle confirm delete dialog
    Alert Should Be Present    action=ACCEPT    timeout=5s
    # Handle success alert
    Run Keyword And Ignore Error    Alert Should Be Present    action=ACCEPT    timeout=5s
    
    Search Room    ${TEST_ROOM_EDITED}
    Wait Until Page Contains    Không có phòng nào khớp    timeout=5s
