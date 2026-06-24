*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/CheckoutPageLocators.py

*** Keywords ***
Enter Customer Details
    [Arguments]    ${name}    ${email}    ${phone}
    Wait Until Element Is Not Visible    xpath=//*[contains(text(), 'Đang tải thông tin thanh toán')]    15s
    Wait Until Element Is Visible    ${FULLNAME_INPUT}    10s
    Execute Javascript    let n=document.getElementById('name');n.value='${name}';n.dispatchEvent(new Event('input',{bubbles:true}));let e=document.getElementById('email');e.value='${email}';e.dispatchEvent(new Event('input',{bubbles:true}));let p=document.getElementById('phone');p.value='${phone}';p.dispatchEvent(new Event('input',{bubbles:true}));

Click Confirm Booking
    Wait Until Element Is Visible    xpath=//button[@type='submit']    15s
    Sleep    1s
    Run Keyword And Ignore Error    Execute Javascript    document.querySelector("button[type='submit']").click()

Verify Booking Success
    [Documentation]    Kiểm tra đặt phòng thành công - accept alert rồi chờ trang PaymentSuccess
    ${alert_text}=    Handle Alert    timeout=15s
    Wait Until Location Contains    /payment-success    timeout=15s
    Wait Until Page Contains    Thanh toán thành công    timeout=10s

Verify Guest Cannot Book Without Login
    [Documentation]    Kiểm tra Guest không thể thanh toán nếu chưa đăng nhập
    ${alert_text}=    Handle Alert    timeout=10s
    Should Contain    ${alert_text}    đăng nhập
    Location Should Contain    /payment
