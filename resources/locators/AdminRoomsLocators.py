class AdminRoomsLocators:
    # --- AdminRooms.vue (List Page) ---
    BTN_ADD_ROOM = "xpath=//a[contains(@href, '/admin/rooms/create')]"
    INPUT_SEARCH = "xpath=//input[contains(@class, 'flex-1')]"
    
    # --- AdminRoomForm.vue (Create/Edit Page) ---
    BTN_RENT_WHOLE = "xpath=(//div[contains(@class, 'bg-emerald-50')]//button)[1]"
    BTN_RENT_PRIVATE = "xpath=(//div[contains(@class, 'bg-emerald-50')]//button)[2]"
    BTN_RENT_HOME = "xpath=(//div[contains(@class, 'bg-emerald-50')]//button)[3]"
    
    INPUT_TITLE = "xpath=(//form//input[@type='text'])[1]"
    INPUT_CAPACITY_ADULTS = "xpath=//input[@type='number' and @min='1']"
    INPUT_CAPACITY_CHILDREN = "xpath=(//input[@type='number' and @min='0'])[1]"
    INPUT_LOCATION = "xpath=(//form//input[@type='text'])[2]"
    INPUT_PRICE = "xpath=(//form//input[@type='number' and @min='0'])[2]"
    SELECT_STATUS = "xpath=//select[option[@value='available']]"
    TEXTAREA_DESC = "xpath=//textarea"
    
    BTN_SUBMIT = "xpath=//button[@type='submit']"
