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
# Warning: The MANTLE_BUILD_DIRECTORY will be removed then created before each build.
#
# -------------------------
#
# MANTLE_FRAMEWORK_NAME
#
# Mantle Framework Name: The name of the framework.
#
# -------------------------
#

readonly MANTLE_CODE_BASE_DIRECTORY="${HOME}/Developer/Open Source Libraries/Mantle/"
readonly MANTLE_BUILD_DIRECTORY="${HOME}/Desktop/Mantle-iOS-Framework/"
readonly MANTLE_FRAMEWORK_NAME="Mantle"


# Build Settings
# You should not change these settings.

readonly MANTLE_PROJECT_NAME="Mantle.xcodeproj"
readonly MANTLE_BUILD_CONFIGURATION_NAME="Release"
readonly MANTLE_BUILD_SCHEME_NAME="Mantle iOS"

readonly IPHONE_OS_SDK_NAME="iphoneos"
readonly IPHONE_SIMULATOR_SDK_NAME="iphonesimulator"


# First of all, we should "Exit on Error"
set -e

# Begin

if [ -d "${MANTLE_BUILD_DIRECTORY}" ]; then
    echo "Cleaning MANTLE_BUILD_DIRECTORY: ${MANTLE_BUILD_DIRECTORY}"
    rm -r "${MANTLE_BUILD_DIRECTORY}"
fi

cd "${MANTLE_CODE_BASE_DIRECTORY}"

echo "Building Mantle (iPhone OS)..."

xcodebuild -project "${MANTLE_PROJECT_NAME}" -configuration "${MANTLE_BUILD_CONFIGURATION_NAME}" -scheme "${MANTLE_BUILD_SCHEME_NAME}" -sdk "${IPHONE_OS_SDK_NAME}" SYMROOT="${MANTLE_BUILD_DIRECTORY}" >/dev/null

echo "Building Mantle (Simulator)..."

xcodebuild -project "${MANTLE_PROJECT_NAME}" -configuration "${MANTLE_BUILD_CONFIGURATION_NAME}" -scheme "${MANTLE_BUILD_SCHEME_NAME}" -sdk "${IPHONE_SIMULATOR_SDK_NAME}" SYMROOT="${MANTLE_BUILD_DIRECTORY}" >/dev/null

echo "Creating Framework Layout..."

mkdir -p "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/A/Headers"
ln -sfh A "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/Current"
ln -sfh Versions/Current/Headers "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Headers"
ln -sfh "Versions/Current/${MANTLE_FRAMEWORK_NAME}" "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/${MANTLE_FRAMEWORK_NAME}"

echo "Copying Headers To Framework..."

cp -a ./Mantle/*.h "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/A/Headers"

echo "Generating Universal Binary File..."

lipo -create "${MANTLE_BUILD_DIRECTORY}/${MANTLE_BUILD_CONFIGURATION_NAME}-${IPHONE_OS_SDK_NAME}/libMantle.a" "${MANTLE_BUILD_DIRECTORY}/${MANTLE_BUILD_CONFIGURATION_NAME}-${IPHONE_SIMULATOR_SDK_NAME}/libMantle.a" -output "${MANTLE_BUILD_DIRECTORY}/${MANTLE_FRAMEWORK_NAME}.framework/Versions/A/${MANTLE_FRAMEWORK_NAME}"

echo "All Done!"