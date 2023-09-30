# todos.sh

This script is a very thin wrapper used to manage GitHub issues from the command line. It uses the 'gh' command line tool for GitHub, 'jq' for JSON processing, and 'gum' for user prompts. It can list, close, add and open issues.

## Installation

Recommend 'installing' by adding an alias to your .zshrc or .bashrc file. Here is an example:

```bash
alias todos="path/to/todos.sh"
```

After adding this line to your .zshrc or .bashrc file, you can use the `todos` command to manage your GitHub issues from the command line.

## Usage

To use the `todos` command, you need to be in a folder via the terminal where you have a GitHub repo. Here are the commands and what they do:

```bash
todos
Usage: todos [command]

Commands:
  list    List all issues
  close   Close an issue
  add     Add a new issue
  view    View an issue in GitHub
```
