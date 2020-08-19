@echo off

echo Building AAB
flutter build appbundle
echo Done building AAB

echo Building APK(s)
flutter build apk --target-platform android-arm64 --split-per-abi
flutter build apk --target-platform android-arm --split-per-abi
flutter build apk --target-platform android-x64 --split-per-abi
echo Done building APK(s)

@echo on