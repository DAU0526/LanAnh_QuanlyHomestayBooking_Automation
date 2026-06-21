*** Settings ***
Library    SeleniumLibrary
Variables  ../locators/CheckoutPageLocators.py

*** Keywords ***
Enter Customer Details
    [Arguments]    ${name}    ${email}    ${phone}
    Wait Until Element Is Visible    ${FULLNAME_INPUT}    10s
    # Use bulletproof JS setter for Vue/React
    Execute Javascript    function setVueValue(id, val) { let el = document.getElementById(id); let setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set; setter.call(el, val); el.dispatchEvent(new Event('input', {bubbles: true})); }; setVueValue('name', '${name}'); setVueValue('email', '${email}'); setVueValue('phone', '${phone}');

Click Confirm Booking
    # Use JS click to ensure it's not intercepted by overlapping elements
    Execute Javascript    document.querySelector("button[type='submit']").click()

Verify Booking Success
    # Native JS alerts in async callbacks can be flaky in headless Chrome (auto-dismissed or missed by polling).
    # We optionally check for it, but rely on the actual page content for success verification.
    Run Keyword And Ignore Error    Alert Should Be Present    timeout=3s
    Wait Until Page Contains    Thanh toán thành công    timeout=10s
