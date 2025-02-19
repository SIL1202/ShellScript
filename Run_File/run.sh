#!/bin/zsh

# Define colors
RED='\033[0;31m'
ORANGE='\033[38;5;214m' # Closer to orange in ANSI 256 colors
NC='\033[0m'            # No Color

SRC_FILE=$(find . -maxdepth 1 -name "*.cpp" | fzf)
EXE_FILE="run"
LOG_FILE="run.log"

if [[ -n "$SRC_FILE" ]]; then
  # Extract only the filename without the ./ prefix
  FILE_NAME=$(basename "$SRC_FILE")

  echo -e "${ORANGE}Compiling: $FILE_NAME${NC}"

  if clang++ -std=c++17 "$SRC_FILE" -o "$EXE_FILE" 2>"$LOG_FILE"; then
    echo -e "${ORANGE}Compilation successful. Running ./$EXE_FILE${NC}"
    ./"$EXE_FILE"
  else
    echo -e "${RED}Compilation failed. See the error messages below:${NC}"
    cat "$LOG_FILE"
  fi
else
  echo -e "${RED}No file selected. Exiting.${NC}"
fi

if rm -f $EXE_FILE $LOG_FILE; then
  echo -e "${ORANGE}successfully remove $EXE_FILE/$LOG_FILE${NC}"
else
  echo -e "${RED}failed remove $EXE_FILE/$LOG_FILE${NC}"
fi
