@echo off
chcp 65001 >nul
color 0A
title Homestay Booking - Automation Test Runner

echo =======================================================
echo     HOMESTAY BOOKING - AUTOMATION TEST RUNNER
echo =======================================================
echo.
echo Vui long chon che do test:
echo [1] Chay toan bo 52 chuc nang (Full Suite)
echo [2] Chay luong Dang Nhap (Login)
echo [3] Chay luong Dang Ky (Register)
echo [4] Chay luong Admin (Quan ly Phong)
echo [5] Tuy chon nang cao (Mo Terminal)
echo.

set /p choice="Nhap lua chon cua ban (1-5): "

if "%choice%"=="1" (
    echo.
    echo [*] Dang don dep va chay toan bo Test...
    python run.py
) else if "%choice%"=="2" (
    echo.
    echo [*] Dang chay luong Dang Nhap...
    python run.py --suite login
) else if "%choice%"=="3" (
    echo.
    echo [*] Dang chay luong Dang Ky...
    python run.py --suite register
) else if "%choice%"=="4" (
    echo.
    echo [*] Dang chay luong Admin Quan ly Phong...
    python run.py --suite adminRoom
) else if "%choice%"=="5" (
    echo.
    echo [*] Da mo che do nang cao. Go "python run.py --help" de xem HD.
    cmd /k
) else (
    echo [!] Lua chon khong hop le!
)

echo.
echo =======================================================
echo [*] TEST HOAN TAT! Nhan phim bat ky de mo file Báo cáo...
pause >nul
start results\report.html
