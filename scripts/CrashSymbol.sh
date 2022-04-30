#!/bin/bash

# https://cloud.tencent.com/developer/article/1558379

export DEVELOPER_DIR=/Applications/XCode.app/Contents/Developer

echo "----开始 第一个参数是crash路径 -----"

symbolToolPath="./symbolicatecrash"
crashPath=""
dSYMPath=""

# -f: 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。  

if [ ! -f "$symbolToolPath" ]
then
    echo "文件为特殊文件"
    symbolToolPath="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"
    echo "symbolicatecrash工具的路径是为："$symbolToolPath

    if [ -f "$symbolToolPath" ]
    then 
        echo "symbolicatecrash工具存在（文件为普通文件）"
    else
        echo "无法找到symbolicatecrash工具"
    fi
fi

function findFile(){
    crashPath=$(find . -name "*.crash")
}

# -n : 检测字符串长度是否不为 0，不为 0 返回 true。
if [ -n "$1" ]
then
    crashPath=$1
    echo "已传入crash文件路径：$crashPath"
else
    findFile
    echo "未传入crash文件路径,搜索同级目录下crash文件"
fi

if [ ! -f "$crashPath" ]
then
    echo "搜索失败，无法找到crash文件"
    exit
fi

# -print：假设find指令的回传值为Ture，就将文件或目录名称列出到标准输出。格式为每列一个名称，每个名称前皆有“./”字符串

dSYMPath=$(find . -name "*.dSYM" -print)
echo "找到的符号表路径：$dSYMPath"

if [ ! -d $dSYMPath ]
then
    echo "无法找到符号表dSYM文件"
    exit
fi

# ./symbolicatecrash ./*.crash ./*.app.dSYM > symbol.crash
$symbolToolPath $crashPath $dSYMPath > symbol.crash