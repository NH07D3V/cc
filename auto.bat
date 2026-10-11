@echo off
chcp 65001 > nul
echo =========================================
echo       DANG TU DONG UPLOAD LEN GIT
echo =========================================
echo.

:: 1. Chuyen den thu muc duoc keo tha (neu co)
if "%~1"=="" (
    echo [!] Ban khong keo thu muc vao. Dang dung thu muc hien tai...
) else (
    if exist "%~1\" (
        cd /d "%~1"
    ) else (
        cd /d "%~1\.."
    )
    echo [+] Da chuyen den thu muc: %cd%
)

echo.
:: 2. Kiem tra xem co phai la Git repository chua
git rev-parse --is-inside-work-tree >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Thu muc chua co Git. Dang khoi tao 'git init'...
    git init
)

:: 3. Kiem tra va gan remote origin
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Dang ket noi toi repository: https://github.com/NH07D3V/cc.git
    git remote add origin https://github.com/NH07D3V/cc.git
)

:: 4. Tu dong lay ten nhanh hien tai (master hoac main) de tranh loi push
for /f "tokens=*" %%i in ('git branch --show-current') do set current_branch=%%i
if "%current_branch%"=="" set current_branch=master

:: 5. Trang thai hien tai
git status

echo.
echo -----------------------------------------
:: 6. Nhap noi dung Commit (Dung dau nhay kep bao quanh bien de tranh loi ky tu dac biet)
set /p commit_msg="Nhap commit message (An Enter de dung mac dinh): "
if "%commit_msg%"=="" (
    set commit_msg=Auto update
)

echo.
echo [1/3] Dang add tat ca file...
git add .

echo [2/3] Dang commit...
git commit -m "%commit_msg%"

echo [3/3] Dang push len server (Nhanh: %current_branch%)...
git push -u origin %current_branch%

echo.
echo =========================================
echo       DA HOAN THANH AUTO PUSH!
echo =========================================
pause