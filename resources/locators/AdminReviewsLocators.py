class AdminReviewsLocators:
    TABLE_ROWS = "xpath=//tbody/tr[not(contains(@class, 'text-center'))]"
    BTN_TOGGLE_FIRST = "xpath=(//tbody/tr[not(contains(@class, 'text-center'))])[1]//button[.//svg[contains(@class, 'lucide-eye') or contains(@class, 'lucide-eye-off')]]"
    BTN_DELETE_FIRST = "xpath=(//tbody/tr[not(contains(@class, 'text-center'))])[1]//button[.//svg[contains(@class, 'lucide-trash')]]"
