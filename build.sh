#!/bin/sh

echo "Clean dist"
rm -rf dist
mkdir dist
mkdir dist/package
mkdir dist/package/platforms

echo "Build android"
mkdir dist/package/platforms/android
cd android
gradle build
cd ..
cp android/build/widgets-release.aar dist/package/platforms/android/widgets-release.aar

echo "Build ios"
mkdir dist/package/platforms/ios
cd ios
./build.sh
cd ..
cp -r ios/TNSWidgets/build/TNSWidgets.framework dist/package/platforms/ios/TNSWidgets.framework

echo "Copy NPM artefacts"
cp LICENSE dist/package/LICENSE
cp LICENSE.md dist/package/LICENSE.md
cp README.md dist/package/README.md
cp package.json dist/package/package.json

echo "NPM pack"
cd dist/package
PACKAGE="$(npm pack)"
cd ../..
mv dist/package/$PACKAGE dist/$PACKAGE
echo "Output: dist/$PACKAGE"

