@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

REM 获取当前日期并正确格式化为yyyymmdd
for /f "tokens=2 delims==" %%y in ('wmic os get localdatetime /value') do set "datetime=%%y"
set "year=!datetime:~0,4!"
set "month=!datetime:~4,2!"
set "day=!datetime:~6,2!"
set "commit_date=%year%%month%%day%"

REM 进入项目目录
cd /d "C:\Users\ASUS\Desktop\TS墨西哥完整发布\图片处理\轮播图"

REM 添加所有文件到暂存区
git add --all

REM 提交更改
git config --local i18n.commitencoding UTF-8
git commit -m "%commit_date%"

REM 推送到远程
git push origin master

endlocal