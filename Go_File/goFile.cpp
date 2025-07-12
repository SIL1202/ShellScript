#include <cstdlib>
#include <filesystem>
#include <iostream>
#include <unistd.h>
#include <vector>

std::vector<std::filesystem::path> listPaths(const std::filesystem::path &PATH);
std::filesystem::path
selectPath(const std::vector<std::filesystem::path> &paths);

int main() {
  const std::filesystem::path PATH = "/Users/sil/Projects/";
  const std::vector<std::filesystem::path> paths = listPaths(PATH);
  const std::filesystem::path path = selectPath(paths);
  // check if the file is executable.
  /* if ((std::filesystem::status(path).permissions() &
       std::filesystem::perms::owner_exec) == std::filesystem::perms::none) {
    std::cerr << "Error: File is not executable!" << std::endl;
    return 1;
  } */

  std::string parent_path = path.parent_path().string();

  std::cout << "Opening " << path << " in Neovim...\n";
  if (chdir(parent_path.c_str()) != 0) {
    std::cerr << "Error: Failed to change directory to " << parent_path
              << std::endl;
    return 1;
  }

  std::cout << "Changed working directory to: " << parent_path << std::endl;

  // 繼續執行 nvim
  std::string command = "nvim \"" + path.filename().string() + "\"";
  system(command.c_str());
  return 0;
}

std::vector<std::filesystem::path>
listPaths(const std::filesystem::path &PATH) {
  const char options = 'a';
  int number = 0;
  std::vector<std::filesystem::path> paths;

  std::cout << "Current directory: " << PATH.filename() << std::endl;
  for (const auto &entry : std::filesystem::directory_iterator(PATH)) {
    paths.push_back(entry.path());
    std::cout << static_cast<char>(options + number) << "  ->  "
              << entry.path().filename() << std::endl;
    number++;
    if (number > 25)
      number = -32;
  }
  return paths;
}

// recursion finding file.
std::filesystem::path
selectPath(const std::vector<std::filesystem::path> &paths) {
  std::cout << "Enter a file's label:\n";
  char option;
  std::cin >> option;
  std::cout << std::endl;
  const int index = (option >= 'a' && option <= 'z')   ? (option - 'a')
                    : (option >= 'A' && option <= 'Z') ? (option - 'A' + 26)
                                                       : -1;
  // make sure the option is valid.
  if (index < 0 || index >= paths.size()) {
    std::cerr << "Invalid option!" << std::endl;
    exit(1);
  }

  const std::filesystem::path &path = paths[index]; // system(path.c_str());

  // base case.
  if (std::filesystem::is_regular_file(path)) {
    return path;
  }

  // if path is directory then go deeper.
  return selectPath(listPaths(path)); // 臨時變數需要在參數上加上const
}

/*
std::filesystem::perms::owner_exec  =  0b001000000   // 擁有者的執行權限
std::filesystem::perms::owner_read  =  0b100000000   // 擁有者的讀取權限
std::filesystem::perms::owner_write =  0b010000000   // 擁有者的寫入權限
*/

/*
  0b101000000  // 檔案實際權限
& 0b001000000  // 只檢查 owner_exec 權限
--------------
  0b001000000  // 結果不為 0，表示檔案是可執行的
*/
