#!/bin/sh

# This script is a very thin wrapper used to manage GitHub issues from the command line. It uses the 'gh' command line tool for GitHub,
# 'jq' for JSON processing, and 'gum' for user prompts. It can list, close, add and open issues.
# Recommend 'installing' by adding an alias to your .zshrc or .bashrc file:
# alias todos="sh ~/path/to/todos.sh"

if ! command -v gum &> /dev/null
then
    echo "gum could not be found"
    echo "Install gum with homebrew: brew install gum"
    exit
fi

if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    gum confirm "Install jq with homebrew?" && brew install jq
    exit
fi

if ! command -v gh &> /dev/null
then
    echo "gh could not be found"
    gum confirm "Install gh with homebrew?" && brew install gh
    exit
fi

if [ -z "$1" ]
then
    echo "Usage: todos [command]"
    echo ""
    echo "Commands:"
    echo "  list    List all issues"
    echo "  close   Close an issue"
    echo "  add     Add a new issue"
    echo "  view    View an issue in GitHub"
    exit
fi

if [ "$1" = "list" ]; then
  gh issue list | cut -f1,3 | gum choose --no-limit --header="Use spacebar to choose issues to show details" | cut -f1 | xargs -I {} gh issue view {}
fi

if [ "$1" = "close" ]; then
  gh issue list | cut -f1,3 | gum choose --no-limit --header="Use spacebar to choose issues to close" | cut -f1 | xargs -I {} gh issue close {}
fi

if [ "$1" = "add" ]; then
  if [ -z "$2" ]
  then
    title=$(gum input --placeholder "Enter the title of the issue")
  else
    title="$2"
  fi
  gh issue create --title "$title" --body ""
fi

if [ "$1" = "view" ]; then
  gh issue list | cut -f1,3 | gum choose --no-limit --header="Use spacebar to choose issues to view in GitHub" | cut -f1 | xargs -I {} gh issue view {} --web
fi