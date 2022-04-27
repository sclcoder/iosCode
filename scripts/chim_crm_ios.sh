#!/bin/zsh

export LC_CTYPE="en_US.UTF-8"
export BUILD_ID=dontKillMe
##### Constant Variables #####
BUNDLE_ID='com.Appsurdity.Chime'
PRJ_NAME='RenrenEstate'
WORKSPACE='RenrenEstate'

echo "--------------"
echo $(pwd)
echo "--------------"

git fetch
commit_id=$(git rev-parse origin/$branch)
git checkout -f $commit_id

echo "IAP_TEST============"$BUILD_TYPE
echo "GEN_LINK_FOR_US============"$GEN_LINK_FOR_US

if [  "$BUILD_TYPE"x = "iaptest"x ] ;then
  #sed -i "" 's/= QWHN6BWZ4W/= HM2XFJ76LK/g' $PRJ_NAME.xcodeproj/project.pbxproj
  #sed -i "" 's/PRODUCT_BUNDLE_IDENTIFIER = "ent.Trucker-Path-Pro"/PRODUCT_BUNDLE_IDENTIFIER = "com.Trucker-Path-Pro-Dev"/g' $PRJ_NAME.xcodeproj/project.pbxproj
  SCHEME_NAME='Estate-Enterprise-Formal'
  EXPORTOPTIONSPLIST='ExportOptions-dev.plist'
  #/usr/libexec/Plistbuddy -c "Set CFBundleDisplayName 'TP IAP'" "TruckerPath/$SCHEME_NAME-Info.plist"
elif [  "$BUILD_TYPE"x = "adhoc"x ] ;then

  # chimeCRM 需要再创建一个scheme作为打ad-hoc的包。此处暂时使用Dev的scheme
  SCHEME_NAME='Estate-Enterprise-Formal' 
  EXPORTOPTIONSPLIST='ExportOptions-dev.plist'
fi

# 打包机的密码 `chime`

security unlock-keychain -p chime ~/Library/Keychains/login.keychain

mkdir -p ../archive_ipa

IPA_DIR=$( cd ../archive_ipa && pwd )

rm -rf ../archive_ipa/*

if [[ "$POD_REPO_UPDATE" = true ]] ;then
        pod repo update --verbose
fi

# 进入 pod 目录
cd RenrenEstate

pod install

if [[ "$CLEAR_BUILD_CACHE" = true ]] ;then
  xcodebuild clean -workspace "$WORKSPACE".xcworkspace -scheme "$SCHEME_NAME" -configuration Release > temp.build.out
fi

xcodebuild archive -allowProvisioningUpdates -workspace "$WORKSPACE".xcworkspace -scheme "$SCHEME_NAME" -configuration Release -archivePath $IPA_DIR/"$SCHEME_NAME".xcarchive

xcodebuild -exportArchive -allowProvisioningUpdates -archivePath $IPA_DIR/"$SCHEME_NAME".xcarchive -exportPath $IPA_DIR/"$SCHEME_NAME" -exportOptionsPlist $EXPORTOPTIONSPLIST

APIPATH=$IPA_DIR/"$SCHEME_NAME/chime_crm_ios.ipa"
# result=$(curl -F "file=@$APIPATH" "http://10.2.54.251:8082/app/upload?buildNumber=$BUILD_NUMBER&jobName=$branch")
# result=$(curl -F "file=@$APIPATH" "http://172.31.11.226:8082/app/upload?buildNumber=$BUILD_NUMBER&jobName=$branch")
# code_url=$(echo $result | sed 's/.*\(http.*\)",.*/\1/g')
