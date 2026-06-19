NAME_INPUT = "id:name"
EMAIL_INPUT = "id:email"
PHONE_INPUT = "id:phone"
PASSWORD_INPUT = "id:password"
CONFIRM_PASSWORD_INPUT = "id:password_confirmation"
TERMS_CHECKBOX = "id:terms"
REGISTER_BUTTON = "xpath://button[@type='submit']"

# Validation Errors
NAME_ERROR = "xpath://input[@id='name']/following-sibling::p[contains(@class, 'text-red-500')]"
EMAIL_ERROR = "xpath://input[@id='email']/following-sibling::p[contains(@class, 'text-red-500')]"
PHONE_ERROR = "xpath://input[@id='phone']/following-sibling::p[contains(@class, 'text-red-500')]"
PASSWORD_ERROR = "xpath://input[@id='password']/following-sibling::p[contains(@class, 'text-red-500')]"
