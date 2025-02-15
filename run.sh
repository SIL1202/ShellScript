#!/bin/zsh  # Specify that this script runs using Zsh

# Define color variables for better output readability
RED='\033[0;31m'       # Red color for errors
ORANGE='\033[38;5;214m' # Orange color for debug/info messages
NC='\033[0m'           # Reset color

# Default DEBUG mode to false
DEBUG=false

# Enable DEBUG mode if the first argument is '--debug'
if [[ "$1" == "--debug" ]]; then
    DEBUG=true
fi

# Select a C++ source file using fzf (interactive fuzzy finder)
SRC_FILE=$(find . -maxdepth 1 -name "*.cpp" | fzf)

# Define the compiled executable file name and the log file
EXE_FILE="run"
LOG_FILE="run.log"

# Clear the previous log file to ensure fresh logs
> "$LOG_FILE"

# Check if a file was selected
if [[ -n "$SRC_FILE" ]]; then
    # Extract the filename without the path
    FILE_NAME=$(basename "$SRC_FILE")

    # If DEBUG mode is enabled, only compile the file without executing it
    if $DEBUG; then
        echo -e "${ORANGE}[DEBUG] Compiling: $FILE_NAME${NC}"
        
        # Compile the C++ file with debugging symbols (-g)
        if clang++ -g -std=c++17 "$SRC_FILE" -o "$EXE_FILE" 2>"$LOG_FILE"; then
            echo -e "${ORANGE}[DEBUG] Compilation successful.${NC}"
        else
            echo -e "${RED}[DEBUG] Compilation failed. See the error messages below:${NC}"
            cat "$LOG_FILE"  # Display compilation errors
            exit 1  # Exit with an error
        fi
        exit 0  # Stop execution here in debug mode (do not run the program)
    fi

    # Normal mode: Compile and execute the program
    echo -e "${ORANGE}Compiling: $FILE_NAME${NC}"
    if clang++ -std=c++17 "$SRC_FILE" -o "$EXE_FILE" 2>"$LOG_FILE"; then
        echo -e "${ORANGE}Compilation successful. Running ./$EXE_FILE${NC}"
        ./"$EXE_FILE"  # Execute the compiled program
    else
        echo -e "${RED}Compilation failed. See the error messages below:${NC}"
        cat "$LOG_FILE"  # Display compilation errors
        exit 1
    fi
else
    # If no file was selected, display an error message and exit
    echo -e "${RED}No file selected. Exiting.${NC}"
    exit 1
fi
