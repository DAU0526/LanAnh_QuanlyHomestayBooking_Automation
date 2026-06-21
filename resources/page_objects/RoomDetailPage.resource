*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/RoomDetailPageLocators.py

*** Keywords ***
Verify Room Detail Page Is Loaded
    Wait Until Element Is Visible    ${BOOK_NOW_BUTTON}    10s
    Wait Until Element Is Visible    ${ROOM_TITLE}    10s

Select Dates
    [Arguments]    ${checkin_date}    ${checkout_date}
    Execute Javascript    let setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set; let inDate = document.querySelectorAll("input[type='date']")[0]; setter.call(inDate, "${checkin_date}"); inDate.dispatchEvent(new Event('input', { bubbles: true })); inDate.dispatchEvent(new Event('change', { bubbles: true }));
    Execute Javascript    let setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set; let outDate = document.querySelectorAll("input[type='date']")[1]; setter.call(outDate, "${checkout_date}"); outDate.dispatchEvent(new Event('input', { bubbles: true })); outDate.dispatchEvent(new Event('change', { bubbles: true }));

Select Check In And Check Out Dates
    Execute Javascript    document.querySelectorAll("input[type='date']")[0].value = "2026-10-10";
    Execute Javascript    document.querySelectorAll("input[type='date']")[0].dispatchEvent(new Event('input', { bubbles: true }));
    Execute Javascript    document.querySelectorAll("input[type='date']")[1].value = "2026-10-12";
    Execute Javascript    document.querySelectorAll("input[type='date']")[1].dispatchEvent(new Event('input', { bubbles: true }));
    Sleep    1s

Click Book Now
    Scroll Element Into View    ${BOOK_NOW_BUTTON}
    Sleep    0.5s
    Execute Javascript    let btn = Array.from(document.querySelectorAll('button')).find(el => el.textContent.includes('Đặt phòng ngay')); if(btn) btn.click();
