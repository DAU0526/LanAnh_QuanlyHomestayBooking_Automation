from selenium import webdriver
from selenium.webdriver.common.by import By
import time

options = webdriver.ChromeOptions()
options.add_argument('--headless')
driver = webdriver.Chrome(options=options)
driver.get('https://homestaybooking.id.vn/')
time.sleep(5)

inputs = driver.find_elements(By.TAG_NAME, 'input')
with open('live_inputs.txt', 'w', encoding='utf-8') as f:
    for i in inputs:
        placeholder = i.get_attribute('placeholder')
        if placeholder:
            f.write(placeholder + '\n')

buttons = driver.find_elements(By.TAG_NAME, 'button')
with open('live_buttons.txt', 'w', encoding='utf-8') as f:
    for b in buttons:
        text = b.text
        if text:
            f.write(text + '\n')

driver.quit()
