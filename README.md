# Homestay Booking - QA Automation Framework
---

# Project Overview

Automation Testing Framework cho hệ thống:

**Homestay Booking Management System**

Framework sử dụng để tự động kiểm thử giao diện Web Application.

Mục tiêu:

- Automation UI Testing
- Kiểm thử chức năng Đăng ký & Đăng nhập (Authentication)
- Validate form input & Hiển thị lỗi
- Regression Testing
- Generate Test Report tự động

---

# Technology Stack

| Technology | Usage |
|-|-|
| Python | Programming Language |
| Robot Framework | Automation Framework |
| SeleniumLibrary | Web Automation |
| ChromeDriver | Browser Driver |
| YAML | Environment Configuration |
| Page Object Model | Test Architecture |

---

# Requirements

| Tool | Version |
|-|-|
| Python | 3.8+ |
| Google Chrome | Latest |
| ChromeDriver | Match Chrome |
| Robot Framework | 7.x |

Check version:

```bash
python --version
robot --version
```

---

# Installation

## Clone Repository

```bash
git clone https://github.com/DAU0526/LanAnh_QuanlyHomestayBooking_Automation.git
```

Move to project:
```bash
cd LanAnh_QuanlyHomestayBooking_Automation
```

---

## Create Virtual Environment

Windows:

```bash
python -m venv venv
venv\Scripts\activate
```

Linux / Mac:

```bash
python3 -m venv venv
source venv/bin/activate
```

---

## Install Libraries

```bash
pip install -r requirements.txt
```

---

# Project Structure

```text
LanAnh_QuanlyHomestayBooking_Automation/
│
├── resources/
│   ├── locators/
│   │   ├── CheckoutPageLocators.py
│   │   ├── HomePageLocators.py
│   │   ├── ListingPageLocators.py
│   │   ├── LoginPageLocators.py
│   │   ├── ProfilePageLocators.py
│   │   ├── RegisterPageLocators.py
│   │   └── RoomDetailPageLocators.py
│   │
│   ├── page_objects/
│   │   ├── CheckoutPage.resource
│   │   ├── HomePage.resource
│   │   ├── ListingPage.resource
│   │   ├── LoginPage.resource
│   │   ├── ProfilePage.resource
│   │   ├── RegisterPage.resource
│   │   └── RoomDetailPage.resource
│   │
│   ├── common_keywords.resource
│   └── environment.variables.yml
│
├── results/
│   ├── log.html
│   ├── output.xml
│   └── report.html
│
├── tests/
│   ├── AccountTests.robot
│   ├── AdminTests.robot
│   ├── AdvancedCheckoutTests.robot
│   ├── LoginTests.robot
│   ├── RegisterTests.robot
│   └── SearchTests.robot
│
├── .gitignore
├── requirements.txt
└── README.md
```

---

# Automation Architecture

```text
Test Cases
      |
      v
Common Keywords
      |
      v
Page Objects
      |
      v
Locators
      |
      v
Homestay Application
```

---

# Test Coverage

# Authentication Testing

## Login

File:

```text
tests/LoginTests.robot
```

Test Cases:

| ID | Description |
|-|-|
| TC_01 | Valid Login Should Succeed |
| TC_02 | Login With Empty Fields |
| TC_03 | Login With Empty Email |
| TC_04 | Login With Empty Password |
| TC_05 | Login With Unregistered Email |
| TC_06 | Login With Wrong Password |
| TC_07 | Login With Invalid Email Format |
| TC_08 | Login With Short Password |
| TC_09 | Login With Uppercase Email |
| TC_10 | Login With Email Containing Spaces |
| TC_14 | Login With Wrong Password Case Sensitivity |
| TC_15 | Password Field Is Masked |

---

## Register

File:

```text
tests/RegisterTests.robot
```

Test Cases:

| ID | Description |
|-|-|
| TC_01 | Valid Registration Should Succeed |
| TC_02 | Register With Empty Fields |
| TC_03 | Register With Empty Name |
| TC_04 | Register With Invalid Email Format |
| TC_05 | Register With Short Password |
| TC_06 | Register With Password Mismatch |
| TC_07 | Register With Existing Phone |
| TC_08 | Register With Existing Email |
| TC_09 | Register Without Terms Checked |
| TC_10 | Register With Non-Gmail Email |
| TC_11 | Register With Empty Password |
| TC_12 | Register With Invalid Phone Format |
| TC_13 | Register With Empty Confirm Password |

---

# Total Test Cases

```text
Authentication
Login        12
Register     13

=================
Total: 25 Tests
=================
```

---

# Running Tests

## Run All Tests

```bash
robot -d results tests/
```

---

## Run Login Test

```bash
robot -d results tests/LoginTests.robot
```

---

## Run Register Test

```bash
robot -d results tests/RegisterTests.robot
```

---

# Test Report

After execution:

```text
results/
├── output.xml
├── log.html
└── report.html
```

Open report:

Windows:

```bash
start results/log.html
```

---

# Page Object Model

## Locator Layer

Contains:
- XPath
- CSS Selector

Example:

```python
LOGIN_BUTTON = "xpath=//button[contains(text(), 'Đăng nhập')]"
```

---

## Page Object Layer

Contains:
- Click action
- Input action
- Navigation

Example:

```robot
*** Keywords ***
Enter Email
    [Arguments]    ${email}
    Input Text    ${EMAIL_INPUT}    ${email}

Click Login Button
    Click Element    ${LOGIN_BUTTON}
```

---

## Test Layer

Only contains:
- Test scenario
- Expected result

Example:

```robot
*** Test Cases ***
TC_01 Valid Login Should Succeed
    Go To Login Page
    Enter Email    ${VALID_EMAIL}
    Enter Password    ${VALID_PASSWORD}
    Click Login Button
    Verify Login Successful
```

---

# Environment Configuration

File:

```text
environment.variables.yml
```

Example:

```yaml
BASE_URL: http://127.0.0.1:8000
BROWSER: chrome
TIMEOUT: 10s
```

---

# Troubleshooting

## Element Not Found

Cause:
- Wrong XPath
- Page loading slow

Solution:

```robot
Wait Until Element Is Visible    ${LOCATOR}    timeout=10s
```

---

## Keyword Not Found

Check resource:

```robot
Resource    ../resources/common_keywords.resource
```

---

## Browser Not Open

Check:

```robot
Suite Setup    Open Browser To Application
```

---

# Git Workflow

Check changes:

```bash
git status
```

Add:

```bash
git add .
```

Commit:

```bash
git commit -m "Update automation tests"
```

Push:

```bash
git push origin main
```

---

# Future Improvements

- Add Screenshot On Failure
- Add Selenium Explicit Wait
- Add GitHub Actions CI/CD
- Add Test Data Management
- Automate Checkout & Room Booking Flows
- Automate Admin Dashboard & Profile Management

---


