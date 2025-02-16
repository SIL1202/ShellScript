#!/bin/zsh

TARGET_USB="Sandisk"

if [[ -d "/Volumes/$TARGET_USB" ]]; then
  open /Volumes/SanDisk/sandisk/PrivateAccess_mac.app
fi
