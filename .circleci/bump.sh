#!/bin/bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

set -o pipefail

previous_version=$(semversioner current-version)
echo "Current version: v$previous_version"

semversioner release

new_version=$(semversioner current-version)
echo "New version: v$new_version"

echo "Generating CHANGELOG.md file..."
semversioner changelog > CHANGELOG.md

# Use new version in the README.md examples
echo "Replace version 'v$previous_version' to 'v$new_version' in README.md ..."
sed -i "s/v$previous_version/v$new_version/g" README.md

# Git config
git config user.email "${GIT_EMAIL}"
git config user.name "CircleCI Job"
git checkout master

# Commit
git add .semversioner/*.json
git add .semversioner/next-release/*.json
git add README.md
git add CHANGELOG.md


echo -e "\nGit status before commit"
git status

git commit -m "Update files for new version 'v${new_version}' [skip ci]"
git push origin master

echo -e "\nGit status after commit and push"
git status

# Tag
echo "Add version tag ${new_version} to repo"
git tag -a -m "Tagging for release v${new_version}" "v${new_version}"
git push origin "v${new_version}"