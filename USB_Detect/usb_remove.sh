#!/bin/zsh

# Define the target USB and closed flag file
TARGET_USB="SanDisk"
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CLOSED_FLAG="$CURRENT_PATH/.privateaccess_closed"
LOG_FILE="$CURRENT_PATH/usb_detect.log"

# Logging function
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Monitoring USB removal for '$TARGET_USB'..."

# Continuously check if the USB is still mounted
while [[ -d "/Volumes/$TARGET_USB" ]]; do
  log "usb_remove.sh running"
  sleep 2
done

# USB was removed, delete the closed flag
rm -f "$CLOSED_FLAG"
rm -f "$LOG_FILE"
log "USB removed. Restart enabled."

exit 0
