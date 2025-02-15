# Run Script

This script allows you to compile and run a C++ file in the current directory with ease.

## How It Works

1. Simply type `run` in the terminal while inside the directory containing your C++ files.
2. The script will use `fzf` to let you select a `.cpp` file interactively.
3. Once selected, it will be compiled using `clang++ -std=c++17`.
4. If the compilation is successful, the script will automatically execute the compiled file.
5. If there are any errors, they will be displayed in the terminal.

## Requirements

- `clang++` (C++ compiler)
- `fzf` (fuzzy finder for interactive file selection)
- `zsh` (since the script is written for zsh)

## Usage

1. Place the `run.sh` script in your project directory.
2. Grant execute permission using:
   ```
   chmod +x run.sh
   ```
3. Move the script to /usr/local/bin/ and rename it to run:
   ```
   sudo cp run.sh /usr/local/bin/run
   ```
