#!/bin/zsh

# Define colors
RED='\033[0;31m'
ORANGE='\033[38;5;214m'
NC='\033[0m'

SRC_FILE=$(find . -maxdepth 1 -name "*.cpp" | fzf)
EXE_FILE="run"
LOG_FILE="run.log"
INPUT_FILE="Input.txt"
OUTPUT_FILE="Output.txt"
INTERACTIVE=false

# Check for -i or --input mode
if [[ "$1" == "-i" || "$1" == "--input" ]]; then
  INTERACTIVE=true
fi

if [[ -n "$SRC_FILE" ]]; then
  FILE_NAME=$(basename "$SRC_FILE")
  echo -e "${ORANGE}Compiling: $FILE_NAME${NC}"

  if clang++ -std=c++17 "$SRC_FILE" -o "$EXE_FILE" 2>"$LOG_FILE"; then
    echo -e "${ORANGE}Compilation successful.${NC}"

    if $INTERACTIVE; then
      echo -e "${ORANGE}Entering interactive input mode...${NC}"

      if [[ ! -f "$INPUT_FILE" ]]; then
        echo -e "${ORANGE}Creating and editing $INPUT_FILE...${NC}"
        nano "$INPUT_FILE"
      else
        echo -e "${ORANGE}Using existing $INPUT_FILE${NC}"
      fi

      echo -e "${ORANGE}Running ./$EXE_FILE < $INPUT_FILE > $OUTPUT_FILE${NC}"
      ./"$EXE_FILE" <"$INPUT_FILE" >"$OUTPUT_FILE"

      if command -v bat &>/dev/null; then
        bat "$OUTPUT_FILE"
      else
        cat "$OUTPUT_FILE"
      fi
    else
      echo -e "${ORANGE}Running ./$EXE_FILE normally...${NC}"
      ./"$EXE_FILE"
    fi

  else
    echo -e "${RED}Compilation failed. See the error messages below:${NC}"
    cat "$LOG_FILE"
  fi
else
  echo -e "${RED}No file selected. Exiting.${NC}"
fi

# Cleanup
if [[ -f $EXE_FILE ]]; then
  rm -f $EXE_FILE
  echo -e "${ORANGE}Removed $EXE_FILE${NC}"
fi

if [[ $? -eq 0 ]]; then
  rm -f $LOG_FILE
  echo -e "${ORANGE}Removed $LOG_FILE${NC}"
fi
