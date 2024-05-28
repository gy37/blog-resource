#!/bin/sh

# 需要先手动打包并导出，然后将导出的文件夹里的ExportOptions.plist文件复制到当前文件所在目录下

WORKSPACE="xxx.xcworkspace"
SCHEME="xxx"
CONFIGURATION="Release"
ARCHIVES_ROOT_PATH="/Users/xxx/Library/Developer/Xcode/Archives"
datetime=$(date '+%Y-%m-%d_%H:%M:%S')
echo "当前日期时间$datetime"
ARCHIVE_PATH="$ARCHIVES_ROOT_PATH/Auto_Archives/$SCHEME$datetime.xcarchive"
IPA_FOLDER_PATH="$ARCHIVES_ROOT_PATH/Auto_IPAs/$SCHEME$datetime"
IPA_PATH="$IPA_FOLDER_PATH/xxx.ipa"

# 清空缓存
echo "开始清空缓存"
xcodebuild clean
-workspace $WORKSPACE \
-scheme $SCHEME
echo "清空缓存完成"
echo

# 打包生成xcarchive文件
echo "开始打包"
xcodebuild archive \
-workspace $WORKSPACE \
-scheme $SCHEME \
-configuration $CONFIGURATION \
-archivePath $ARCHIVE_PATH
echo "打包完成"
echo

# 导出ipa文件
echo "开始导出"
xcodebuild -exportArchive \
-archivePath $ARCHIVE_PATH \
-exportPath $IPA_FOLDER_PATH \
-exportOptionsPlist "ExportOptions.plist"
echo "导出完成"
echo

# 安装ipaIPA_PATH
echo "开始安装"
ideviceinstaller -i $IPA_PATH
echo "安装完成"
