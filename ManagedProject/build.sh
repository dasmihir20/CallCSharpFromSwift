#!/bin/bash
set -e # bail on any error
set -euo pipefail
set -x
rm -rf bin && rm -rf obj
rm -rf build && mkdir build


dotnet publish -r iossimulator-x64
dotnet publish -r iossimulator-arm64
dotnet publish -r ios-arm64


mkdir build/ios-arm64 && cp bin/Release/net8.0/ios-arm64/Bundle/libManagedProject.dylib build/ios-arm64
mkdir build/iossimulator-x64 && cp bin/Release/net8.0/iossimulator-x64/Bundle/libManagedProject.dylib build/iossimulator-x64
mkdir build/iossimulator-arm64 && cp bin/Release/net8.0/iossimulator-arm64/Bundle/libManagedProject.dylib build/iossimulator-arm64

rm -rf build/iossimulator && mkdir build/iossimulator

lipo -create build/iossimulator-x64/libManagedProject.dylib build/iossimulator-arm64/libManagedProject.dylib -output build/iossimulator/libManagedProject.dylib

rm -rf build/xcFramework && mkdir build/xcFramework

xcrun xcodebuild -create-xcframework \
  -library build/iossimulator/libManagedProject.dylib \
  -library build/ios-arm64/libManagedProject.dylib \
  -output build/xcFramework/ManagedProject.xcframework