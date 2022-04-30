#!/bin/zsh

:<<!
   通过jenkins,配置 
   1.执行要打包的版本号: v346、develop等
   2.build参数:      Debug、Release
   3.ipa包导出方式:   development、adhoc、appstore
!




#调试代码
CLEAR=true
REBUILD=true
CLEAN=true

echo "~~~~~~~~~~~~~~~~开始执行脚本~~~~~~~~~~~~~~~~"


# 开始时间
beginTime=`date +%s`
DATE=`date '+%Y-%m-%d-%T'`


#workspace name
WORKSPACE_NAME="RenrenEstate"
#scheme name
SCHEME_NAME="Estate-Enterprise-Formal"
#target name
TARGET_NAME="EstateEnterprise-Formal"


#PATH
#workspace路径
WORKSPACE_PATH=~/.jenkins/workspace

#archives编译路径
BUILD_PATH=${WORKSPACE_PATH}/archives

#exports路径:输出的ipa目录
EXPORTS_PATH=${WORKSPACE_PATH}/exports

#settings: 存放export时的设置信息
SETTINGS_PATH=${WORKSPACE_PATH}/settings

#archive文件
ARCHIVE_PATH=${BUILD_PATH}/${SCHEME_NAME}.xcarchive

#ExportOptionsPlist: 导出ipa时所需plist
DEVELOPMENT_EOP=${SETTINGS_PATH}/developmentExportOptionsPlist.plist
ADHOC_EOP=${SETTINGS_PATH}/adhocExportOptionsPlist.plist
APPSTORE_EOP=${SETTINGS_PATH}/appstoreExportOptionsPlist.plist

if [ $package_type = "development" ]
then
EOP_PATH=${DEVELOPMENT_EOP}
elif [ $package_type = "adhoc" ]
then
EOP_PATH=${ADHOC_EOP}
else
EOP_PATH=${APPSTORE_EOP}
fi

echo "EOP: $EOP_PATH"


#git工作目录
GIT_WORKPATH=${WORKSPACE_PATH}/chime_crm_ios
#pod工作目录
POD_WORKPATH=${WORKSPACE_PATH}/chime_crm_ios/RenrenEstate

echo "WORKSPACE_PATH:" ${WORKSPACE_PATH}

echo "BUILD_PATH:" ${BUILD_PATH}

echo "ARCHIVE_PATH:" ${ARCHIVE_PATH}

echo "EXPORTS_PATH:" ${EXPORTS_PATH}

echo "EOP_PATH:" ${DEVELOPMENT_EOP}







if [ $CLEAR = true ]
then

echo "🚀 ~~~~~~~~~~~~~~~~删除之前的build~~~~~~~~~~~~~~~~"
rm -rf archives/* exports/*

fi





echo "🚀 ~~~~~~~~~~~~~~~~开始更新git仓库~~~~~~~~~~~~~~~~"

cd ${POD_WORKPATH}

# # 恢复现场

# echo "查看变动" && git status

# echo "🚀 开始恢复现场" && git checkout -- . && git clean -xfd

# # 切换分支
# echo "🚀 开始同步远程仓库"

git fetch
git checkout ${branch}


if [ $CLEAN = true ]
then
echo "🚀 ~~~~~~~~~~~~~~~~开始clean~~~~~~~~~~~~~~~~"
xcodebuild clean -workspace ${WORKSPACE_NAME}.xcworkspace \
-scheme ${SCHEME_NAME} \
-configuration ${build_type}    
fi





if [ $REBUILD = true ]
then

echo "🚀 ~~~~~~~~~~~~~~~~开始编译~~~~~~~~~~~~~~~~~~~"
xcodebuild archive -workspace ${WORKSPACE_NAME}.xcworkspace \
-scheme ${SCHEME_NAME} \
-archivePath ${ARCHIVE_PATH} \
-configuration ${build_type}
fi





echo "~~~~~~~~~~~~~~~~检查是否构建成功~~~~~~~~~~~~~~~~~~~"
# xcarchive 实际是一个文件夹不是一个文件所以使用 -d 判断

echo ${ARCHIVE_PATH}

if [ -d "$ARCHIVE_PATH" ]
then
echo "构建成功......"
else
echo "构建失败......"
rm -rf $BUILD_PATH
exit 1
fi
endTime=`date +%s`
ArchiveTime="构建时间$[ endTime - beginTime ]秒"





echo "🚀 ~~~~~~~~~~~~~~~~开始导出ipa~~~~~~~~~~~~~~~~"
beginTime=`date +%s`

xcodebuild -exportArchive \
-archivePath ${ARCHIVE_PATH} \
-exportOptionsPlist ${EOP_PATH} \
-exportPath ${EXPORTS_PATH}



echo "~~~~~~~~~~~~~~~~检查是否成功导出ipa~~~~~~~~~~~~~~~~~~~"
IPA_PATH=${EXPORTS_PATH}/${TARGET_NAME}.ipa
echo ${IPA_PATH}

if [ -f "$IPA_PATH" ]
then
echo "导出ipa成功......"
else
echo "导出ipa失败......"
# 结束时间
endTime=`date +%s`
echo "$ArchiveTime"
echo "导出ipa时间$[ endTime - beginTime ]秒"
exit 1
fi

endTime=`date +%s`
ExportTime="导出ipa时间$[ endTime - beginTime ]秒"






echo "~~~~~~~~~~~~~~~~开始上传到服务器~~~~~~~~~~~~~~~~~~~"
# 上传ipa

echo ${IPA_PATH}
