#!/usr/bin/env bash

help() {
  echo "Accepted arguments: ios, apk, bundle, android, all"
  exit
}

if [ $# -lt 1 ]
then
  echo "$0          Not enough arguments"
  help
fi

apk() {
  echo "Building apk(s)..."
  flutter build apk --target-platform android-arm64 --split-per-abi --obfuscate --split-debug-info=./debugInfo/apk
  flutter build apk --target-platform android-arm --split-per-abi --obfuscate --split-debug-info=./debugInfo/apk
  flutter build apk --target-platform android-x64 --split-per-abi --obfuscate --split-debug-info=./debugInfo/apk
  echo "Done"
}

aab() {
  echo "Building aab..."
  flutter build appbundle --obfuscate --split-debug-info=./debugInfo/aab
  echo "Done"
}

android() {
  echo "Building for android..."
  apk
  aab
}

ios() {
  echo "Building for ios..."
  flutter build ios --release
  echo "More steps from xcode required"
  echo "For more info, please visit: https://flutter.dev/docs/deployment/ios"
  echo "Done"
}

all() {
  echo "Building for all (ios, apk, aab)"
  android
  ios
}

case $1 in

"apk")
  apk
  ;;

"bundle")
  aab
  ;;

"android")
  android
  ;;

"ios")
  ios
  ;;

"all")
  all
  ;;

*)
  help
  ;;

esac