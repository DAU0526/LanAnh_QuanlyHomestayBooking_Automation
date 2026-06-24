class AdminUsersLocators:
    BTN_ADD_USER = "xpath=(//button[contains(@class, 'bg-emerald-600')])[1]"
    INPUT_SEARCH = "xpath=(//input[@type='text'])[1]"
    BTN_SEARCH = "xpath=(//button[contains(@class, 'bg-gray-800')])[1]"
    
    # Form Modal
    INPUT_NAME = "xpath=(//form//input[@type='text'])[1]"
    INPUT_EMAIL = "xpath=//form//input[@type='email']"
    INPUT_PHONE = "xpath=//form//input[@type='tel']"
    SELECT_ROLE = "xpath=//form//select"
    INPUT_PASSWORD = "xpath=//form//input[@type='password']"
    
    BTN_SAVE_USER = "xpath=//form//button[@type='submit']"
    BTN_CANCEL_USER = "xpath=//form//button[@type='button']"
