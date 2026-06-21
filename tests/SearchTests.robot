*** Settings ***
Documentation    Test luồng Tìm kiếm và Lọc phòng (Search & Filter)
Library          SeleniumLibrary
Resource         ../resources/common_keywords.resource
Resource         ../resources/page_objects/HomePage.resource
Resource         ../resources/page_objects/ListingPage.resource

Test Setup       Open Browser To Application
Test Teardown    Close Application

*** Test Cases ***
TC_01 User Can Search By Homestay Name
    [Documentation]    Tìm kiếm phòng theo tên Homestay trên trang chủ
    Verify Home Page Is Loaded
    Search For Homestay    Đà Nẵng
    Verify Search Results Are Shown

TC_02 User Can Filter Rooms By Price
    [Documentation]    Lọc phòng theo khoảng giá tối đa trên trang danh sách
    Go To Listing Page
    Verify Listing Page Is Loaded
    Filter By Price Range    0    2000000
    Verify Rooms Are Displayed
