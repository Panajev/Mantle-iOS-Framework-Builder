#!/bin/sh

#  Mantle-iOS-Framework-Builder.sh
#  
#
#  Created by YuAo on 2/24/13.
#

# 
# User configurations
#
# --------------------------
#
# MANTLE_CODE_BASE_DIRECTORY
#
# Mantle Code Base Directory: The absolute path to the directory which contains the Mantle.xcodeproj file.
#
# -------------------------
#
# MANTLE_BUILD_DIRECTORY
#
# Mantle Build Directory: The final .framework file will be generated here.
#
# -------------------------
#
# MANTLE_FRAMEWORK_NAME
#
# Mantle Framework Name: The name of the framework.
#
# -------------------------
#

MANTLE_CODE_BASE_DIRECTORY="${HOME}/Developer/Open Source Libraries/Mantle/"
if [ MANTLE_CODE_BASE_DIRECTORY"$1" != MANTLE_CODE_BASE_DIRECTORY ]; then
    MANTLE_CODE_BASE_DIRECTORY="$1"
fi

MANTLE_BUILD_DIRECTORY="${HOME}/Desktop/Mantle-OSX-Framework/"
if [ MANTLE_BUILD_DIRECTORY"$2" != MANTLE_BUILD_DIRECTORY ]; then
    MANTLE_BUILD_DIRECTORY="$2"
fi

readonly MANTLE_FRAMEWORK_NAME="Mantle"


# Build Settings
# You should not change these settings.

readonly MANTLE_WORKSPACE_NAME="Mantle.xcworkspace"
readonly MANTLE_BUILD_CONFIGURATION_NAME="Release"
readonly MANTLE_BUILD_SCHEME_NAME="Mantle Mac"
readonly MANTLE_LIB_NAME_TEMP="Mantle"
readonly MANTLE_LIB_NAME="Mantle-Mac"

readonly MAC_OS_SDK_NAME="macosx"

readonly MANTLE_PRODUCT_NAME="${MANTLE_LIB_NAME}"

# First of all, we should "Exit on Error"
set -e

# Begin

if [ -d "${MANTLE_BUILD_DIRECTORY}" ]; then
    read -p "MANTLE_BUILD_DIRECTORY: ${MANTLE_BUILD_DIRECTORY} already exists, it will be overwritten, countinue? (y/n) "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Cleaning MANTLE_BUILD_DIRECTORY: ${MANTLE_BUILD_DIRECTORY}"
        rm -rf "${MANTLE_BUILD_DIRECTORY}"
    else
        echo "Operation Cancelled."
        exit 1
    fi
fi

cd "${MANTLE_CODE_BASE_DIRECTORY}"

echo "Building Mantle (MacOS X)..."

xcodebuild -workspace "${MANTLE_WORKSPACE_NAME}" -configuration "${MANTLE_BUILD_CONFIGURATION_NAME}" -scheme "${MANTLE_BUILD_SCHEME_NAME}" -sdk "${MAC_OS_SDK_NAME}" SYMROOT="${MANTLE_BUILD_DIRECTORY}"  >/dev/null

echo "Creating Framework Layout..."

mkdir -p "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/A/Headers"
ln -sfh A "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/Current"
ln -sfh Versions/Current/Headers "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Headers"
ln -sfh "Versions/Current/${MANTLE_FRAMEWORK_NAME}" "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/${MANTLE_FRAMEWORK_NAME}"

echo "Copying Headers To Framework..."

cp -a ./Mantle/*.h "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/A/Headers"

echo "Generating Universal Binary File..."

lipo -create "${MANTLE_BUILD_DIRECTORY}/${MANTLE_BUILD_CONFIGURATION_NAME}/${MANTLE_FRAMEWORK_NAME}.framework/${MANTLE_LIB_NAME_TEMP}" -output "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/A/${MANTLE_FRAMEWORK_NAME}"

echo "All Done!"