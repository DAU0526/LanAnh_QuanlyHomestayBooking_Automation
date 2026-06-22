*** Settings ***
Library         SeleniumLibrary
Variables       ../locators/AdminRoomsLocators.py

*** Keywords ***
Go To Admin Rooms Page
    Go To    ${BASE_URL}/admin/rooms
    Wait Until Location Contains    /admin/rooms    timeout=10s
    Wait Until Page Contains Element    ${BTN_ADD_ROOM}    timeout=10s

Click Add Room Button
    Click Element    ${BTN_ADD_ROOM}
    Wait Until Location Contains    /admin/rooms/create    timeout=10s

Select Whole House Mode
    Click Element    ${BTN_RENT_WHOLE}
    Sleep    0.5s

Fill Room Form
    [Arguments]    ${title}    ${location}    ${price}    ${adults}=2    ${children}=0
    Input Text    ${INPUT_TITLE}    ${title}
    Input Text    ${INPUT_LOCATION}    ${location}
    Input Text    ${INPUT_PRICE}    ${price}
    Input Text    ${INPUT_CAPACITY_ADULTS}    ${adults}
    Input Text    ${INPUT_CAPACITY_CHILDREN}    ${children}

Submit Room Form
    Click Element    ${BTN_SUBMIT}

Search Room
    [Arguments]    ${search_text}
    Input Text    ${INPUT_SEARCH}    ${search_text}
    Sleep    1s    # Đợi Vue debounce 500ms + API call

Click Edit Room
    [Arguments]    ${room_title}
    # Tìm dòng chứa tên phòng và bấm nút sửa tương ứng
    ${edit_btn}=    Set Variable    xpath=//td[contains(text(), '${room_title}')]/..//button[@title='Chỉnh sửa']
    Wait Until Page Contains Element    ${edit_btn}    timeout=5s
    Click Element    ${edit_btn}
    Wait Until Location Contains    /admin/rooms/edit    timeout=10s

Click Delete Room
    [Arguments]    ${room_title}
    ${delete_btn}=    Set Variable    xpath=//td[contains(text(), '${room_title}')]/..//button[@title='Xóa']
    Wait Until Page Contains Element    ${delete_btn}    timeout=5s
    Click Element    ${delete_btn}
