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
cd /d "C:\Users\ASUS\Desktop\墨西哥t完整发布\图片处理\轮播图"

REM 清理旧历史记录 (关键步骤)
REM 1. 创建新的孤立分支
git checkout --orphan latest_branch

REM 2. 添加所有文件到新分支
git add --all

REM 3. 提交更改
git commit -am "%commit_date%"

REM 4. 删除主分支
git branch -D master

REM 5. 重命名当前分支为主分支
git branch -m master

REM 6. 强制推送到远程仓库 (覆盖历史)
git push -f origin master

REM 7. 清理不必要的文件和历史
git for-each-ref --format="%(refname)" refs/original/ | for /f "delims=" %%i in ('git for-each-ref --format="%(refname)" refs/original/') do git update-ref -d %%i
git reflog expire --expire=now --all
git gc --aggressive --prune=now

endlocal
