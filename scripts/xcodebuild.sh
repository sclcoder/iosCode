
# jenkins xcodebulid 相关脚本

/usr/bin/xcodebuild -showsdks

/usr/bin/xcodebuild -list -workspace RenrenEstate/RenrenEstate.xcworkspace

/usr/bin/xcodebuild -help

/usr/bin/xcodebuild -version


# ARCHIVE
/usr/bin/xcodebuild
    -scheme Estate-Enterprise-Formal
    -workspace RenrenEstate/RenrenEstate.xcworkspace
    -configuration Debug
    archive -archivePath /Users/apple/jenkins/workspace/ChimeCRM_iOS/build/Estate-Enterprise-Formal.xcarchive
    BUILD_DIR=/Users/apple/jenkins/workspace/ChimeCRM_iOS/build DEVELOPMENT_TEAM=687C4JR3J3 -allowProvisioningUpdates


# Packaging IPA
12:07:59 Cleaning up previously generated .ipa files
12:07:59 Cleaning up previously generated .dSYM.zip files
12:07:59 Packaging IPA
12:07:59 [ChimeCRM_iOS] $ /usr/libexec/PlistBuddy -c "Print :ApplicationProperties:CFBundleVersion" /Users/apple/jenkins/workspace/ChimeCRM_iOS/build/Estate-Enterprise-Formal.xcarchive/Info.plist
12:07:59 [ChimeCRM_iOS] $ /usr/libexec/PlistBuddy -c "Print :ApplicationProperties:CFBundleShortVersionString" /Users/apple/jenkins/workspace/ChimeCRM_iOS/build/Estate-Enterprise-Formal.xcarchive/Info.plist
12:07:59 Packaging Estate-Enterprise-Formal.xcarchive => /Users/apple/jenkins/workspace/archive_ipa/EstateEnterprise-Formal.ipa



# EXPORT IPA
12:07:59 [ChimeCRM_iOS] $ /usr/bin/xcodebuild -exportArchive -archivePath /Users/apple/jenkins/workspace/ChimeCRM_iOS/build/Estate-Enterprise-Formal.xcarchive -exportPath /Users/apple/jenkins/workspace/archive_ipa -exportOptionsPlist /Users/apple/jenkins/workspace/archive_ipa/development687C4JR3J3ExportOptions.plist -allowProvisioningUpdates


12:08:01 2022-04-08 12:07:59.811 xcodebuild[84132:941942] [MT] IDEDistribution: -[IDEDistributionLogging _createLoggingBundleAtPath:]: Created bundle at path "/var/folders/jn/msbb9n2x0yz1vkx2tjl0mr2c0000gn/T/Estate-Enterprise-Formal_2022-04-08_12-07-59.810.xcdistributionlogs".
12:08:01 2022-04-08 12:07:59.943 xcodebuild[84132:942124] CFURLRequestSetHTTPCookieStorageAcceptPolicy_block_invoke: no longer implemented and should not be called
12:08:29 Exported Estate-Enterprise-Formal to: /Users/apple/jenkins/workspace/archive_ipa
12:08:29 ** EXPORT SUCCEEDED **
