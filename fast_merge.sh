#!/bin/bash

# predefined GLOBAL variable
REMOTE="remote"
SOURCE_BRANCH=$(git branch --show-current)
TARGET_BRANCH="master"

init_global_variable() {
  if [[ $1 ]]; then
    SOURCE_BRANCH=$1
  fi

  if [[ $2 ]]; then
    TARGET_BRANCH=$2
  fi
}

check_if_branchs_are_same() {
  if [[ $1 == $2 ]]; then
    echo "You are trying to merge the same branch, idiot!"
    exit 1
  fi
}

check_branch_exist() {
  if git branch --list $1 | grep -q $1; then
    echo "Branch $1 does not exist."
    exit 1
  fi
}

check_remote_branch_exist() {
  if git branch -r | grep -q "$REMOTE/$1"; then
    echo "Remote branch $1 does not exist."
    exit 1
  fi
}

init_global_variable $1 $2

check_branch_exist $SOURCE_BRANCH
check_branch_exist $TARGET_BRANCH

check_if_branchs_are_same $SOURCE_BRANCH $TARGET_BRANCH

echo "$SOURCE_BRANCH -> $TARGET_BRANCH"
