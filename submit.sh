#!/bin/bash

# 自动提交和推送更改到 GitHub 仓库
# 使用方法: ./github.sh "提交信息" [分支名]

# 检查是否提供了提交信息
if [ -z "$1" ]; then
    echo "错误：请提供提交信息！"
    echo "示例: ./github.sh '更新了README文件' main"
    exit 1
fi

# 设置默认分支（如果未提供）
BRANCH=${2:-main}

# 检查当前目录是否是 Git 仓库
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "错误：当前目录不是 Git 仓库！"
    exit 1
fi

# 添加所有更改到暂存区
git add .

# 提交更改
git commit -m "$1"

# 推送到远程仓库
git push origin $BRANCH

# 检查推送是否成功
if [ $? -eq 0 ]; then
    echo "✅ 成功提交并推送到分支 $BRANCH！"
else
    echo "❌ 推送失败，请检查网络或权限！"
fi