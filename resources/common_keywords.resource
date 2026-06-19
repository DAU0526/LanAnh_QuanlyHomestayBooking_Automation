*** Settings ***
Library    SeleniumLibrary
Variables  environment.variables.yml

*** Keywords ***
Open Browser To Application
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --window-size\=1920,1080
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    Call Method    ${chrome_options}    add_argument    --allow-insecure-localhost
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${chrome_options}
    Set Window Size    1920    1080



Close Application
    Close Browser
