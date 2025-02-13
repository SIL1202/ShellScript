#!/bin/bash

SRC_FILE=$(find . -maxdepth 1 -name "*.cpp" | fzf)
EXE_FILE="run"
LOG_FILE="run.log"

if [[ -n "$SRC_FILE" ]]; then
  echo "正在編譯: SRC_FILE..."

  if clang++ -std=c++17 "$SRC_FILE" -o "$EXE_FILE" 2>"$LOG_FILE"; then
    echo "編譯成功，執行 ./$EXE_FILE"
    ./"$EXE_FILE"
  else
    echo "編譯失敗，請查看 $LOG_FILE"
  fi
else
  echo "未選擇檔案，退出。"
fi
