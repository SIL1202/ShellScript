#!/bin/zsh

# Define the target USB name and application details
TARGET_USB="SanDisk"
APP_NAME="PrivateAccess_mac"
APP_PATH="/Volumes/$TARGET_USB/sandisk/PrivateAccess_mac.app"

# Get the absolute path of the script's directory (works in both terminal and launchd)
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Define paths for the closed flag and log file
CLOSED_FLAG="$CURRENT_PATH/.privateaccess_closed"
LOG_FILE="$CURRENT_PATH/usb_detect.log"

# Ensure the log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function to append messages to the log file
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Script started. Checking for USB device '$TARGET_USB'..."

# If the CLOSED_FLAG exists, do not open the application
if [[ -f "$CLOSED_FLAG" ]]; then
  log "File had been closed."
  exit 0
fi

# Wait up to 5 seconds for the USB to be mounted
for i in {1..5}; do
  if [[ -e "$APP_PATH" ]]; then
    log "USB detected at $APP_PATH."

    # Check if the application is already running
    if pgrep -x "$APP_NAME" >/dev/null; then
      log "Application '$APP_NAME' is already running."
      exit 0
    fi

    # Open the application
    open "$APP_PATH"

    # Start watch_privateaccess.sh in the background
    "$CURRENT_PATH/watch_privateaccess.sh" &

    exit 0
  fi
  sleep 1
done

# If the application path is not found, log the error
log "USB detection failed: $APP_PATH not found."
exit 1
