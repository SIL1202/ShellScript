#!/bin/zsh

TARGET_USB="SanDisk"
APP_NAME="PrivateAccess_mac"
APP_PATH="/Volumes/SanDisk/sandisk/PrivateAccess_mac.app"

# Wait for USB to be mounted (max 5 seconds)
for i in {1..5}; do
  if [[ -e "$APP_PATH" ]]; then
    # Check if the application is already running
    if pgrep -x "$APP_NAME" >/dev/null; then
      echo "This application is already running."
      exit 0
    fi

    # Open the application
    open "$APP_PATH"
    exit 0
  fi
  sleep 1
done

# Print error message if the application path is not found
echo "USB detection failed: $APP_PATH not found."
exit 1
