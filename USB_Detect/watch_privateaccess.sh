#!/bin/zsh

# Define necessary variables
APP_NAME="PrivateAccess_mac"
CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CLOSED_FLAG="$CURRENT_PATH/.privateaccess_closed"
LOG_FILE="$CURRENT_PATH/usb_detect.log"

# Logging function to append messages
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Monitoring application: $APP_NAME..."

# If the application is restarted manually, remove the closed flag
if [[ -f "$CLOSED_FLAG" ]]; then
  rm -f "$CLOSED_FLAG"
  log "Application restarted manually. Removed closed flag."
fi

# Wait for the application to close
while pgrep -x "$APP_NAME" >/dev/null; do
  sleep 2
done

# When the app is fully closed, create the closed flag
touch "$CLOSED_FLAG"
log "Application closed. Flag created."

exit 0
