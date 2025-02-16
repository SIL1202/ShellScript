#!/bin/zsh

APP_NAME="PrivateAccess_mac"
APP_PATH="/Volumes/SanDisk/sandisk/PrivateAccess_mac.app"
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CLOSED_FLAG="$CURRENT_PATH/.privateaccess_closed"
LOG_FILE="$CURRENT_PATH/usb_detect.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Monitoring application -> $APP_NAME..."

# Debug log
log "Closed flag path = $CLOSED_FLAG"

# Wait for application to close
while pgrep -x "$APP_NAME" >/dev/null; do
  log "watch_privateaccess.sh is running..."
  sleep 2
done

# Ensure the closed flag is created
touch "$CLOSED_FLAG"
log "Application closed. Created flag: $CLOSED_FLAG"

exit 0
