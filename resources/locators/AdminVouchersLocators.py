class AdminVouchersLocators:
    BTN_ADD_VOUCHER = "xpath=//button[contains(@class, 'bg-[#4A7055]')]"
    
    # Form
    INPUT_CODE = "xpath=(//form//input[@type='text'])[1]"
    SELECT_DISCOUNT_TYPE = "xpath=//form//select"
    INPUT_DISCOUNT_VALUE = "xpath=(//form//input[@type='number'])[1]"
    INPUT_MAX_USES = "xpath=(//form//input[@type='number'])[2]"
    INPUT_EXPIRES_AT = "xpath=//form//input[@type='date']"
    CHECKBOX_IS_ACTIVE = "xpath=//form//input[@type='checkbox']"
    
    BTN_SAVE_VOUCHER = "xpath=//button[@type='submit']"
    BTN_CANCEL_VOUCHER = "xpath=//button[@type='button' and contains(@class, 'bg-white')]"
