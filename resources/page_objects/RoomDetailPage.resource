*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/RoomDetailPageLocators.py

*** Keywords ***
Verify Room Detail Page Is Loaded
    Wait Until Element Is Visible    ${BOOK_NOW_BUTTON}    10s
    Wait Until Element Is Visible    ${ROOM_TITLE}    10s

Select Dates
    [Arguments]    ${checkin_date}    ${checkout_date}
    Wait Until Element Is Visible    xpath:(//input[@type='date'])[1]    10s
    Execute Javascript    let setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set; let inDate = document.querySelectorAll("input[type='date']")[0]; setter.call(inDate, "${checkin_date}"); inDate.dispatchEvent(new Event('input', { bubbles: true })); inDate.dispatchEvent(new Event('change', { bubbles: true }));
    Execute Javascript    let setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set; let outDate = document.querySelectorAll("input[type='date']")[1]; setter.call(outDate, "${checkout_date}"); outDate.dispatchEvent(new Event('input', { bubbles: true })); outDate.dispatchEvent(new Event('change', { bubbles: true }));
    Sleep    0.5s

Click Book Now
    Scroll Element Into View    ${BOOK_NOW_BUTTON}
    Sleep    0.5s
    Execute Javascript    let btn = Array.from(document.querySelectorAll('button')).find(el => el.textContent.includes('Đặt phòng ngay')); if(btn) btn.click();

Verify Date Validation Error
    [Documentation]    Kiểm tra thông báo lỗi khi ngày check-out nhỏ hơn check-in hiển thị trong trang
    Wait Until Page Contains    Ngày trả phòng phải sau ngày nhận phòng    timeout=10s

