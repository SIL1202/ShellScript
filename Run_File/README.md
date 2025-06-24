# Run Script

This script allows you to compile and run a C++ file in the current directory with ease.

## How It Works

1. Simply type `run` in the terminal while inside the directory containing your C++ files.
2. The script will use `fzf` to let you select a `.cpp` file interactively.
3. Once selected, it will be compiled using `clang++ -std=c++17`.
4. If the compilation is successful:
   - If you run `run` without any arguments, it will execute the compiled file using standard input/output (keyboard and terminal).
   - If you run `run -i` or `run --input`, it will:
     - Check if `Input.txt` exists.  
       - If not, it opens it in `nano` for you to enter test input.
       - If it exists, it reuses the existing content.
     - Redirect input from `Input.txt`, output to `Output.txt`.
     - Display `Output.txt` content using `bat` or fallback to `cat`.

5. If there are any compilation errors, they will be displayed in the terminal.

## Requirements

- `clang++` (C++ compiler)
- `fzf` (fuzzy finder for interactive file selection)
- `zsh` (since the script is written for zsh)
- `bat` (optional, for colored output viewing; falls back to `cat` if unavailable)

## Usage

1. Place the `run.sh` script in your project directory.
2. Grant execute permission using:
   ```bash
   chmod +x run.sh
   ```
   
   ```bash
   cp run.sh /usr/local/bin/run
   ```

