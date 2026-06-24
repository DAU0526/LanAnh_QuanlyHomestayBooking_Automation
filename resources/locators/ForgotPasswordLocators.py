class ForgotPasswordLocators:
    LINK_FORGOT_PASSWORD = "xpath=//a[contains(text(), 'Quên mật khẩu')]"
    INPUT_LOGIN_ID = "id=loginId"
    BTN_SUBMIT = "xpath=//button[@type='submit' and contains(., 'Gửi link khôi phục')]"
    MSG_SUCCESS = "xpath=//div[contains(@class, 'bg-[#4A7055]/10')]"
