@echo off

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo 请求管理员权限
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

echo 成功获取管理员权限，开始执行操作。
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /d "%systemroot%\system32\imageres.dll,197" /t REG_SZ /f

echo 正在重启Windows资源管理器以应用更改
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo 操作完成！快捷方式箭头已被隐藏。
echo 此窗口将在3秒后自动关闭
timeout /t 3 >nul
exit