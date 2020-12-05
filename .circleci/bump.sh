#!/bin/bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

set -o pipefail

previous_version=$(semversioner current-version)
echo "Current version: $previous_version"

semversioner release

new_version=$(semversioner current-version)
echo "New version: $new_version"

echo "Generating CHANGELOG.md file..."
semversioner changelog > CHANGELOG.md

# Use new version in the README.md examples
echo "Replace version '$previous_version' to '$new_version' in README.md ..."
sed -i "s/v$previous_version/v$new_version/g" README.md

# Commit
git add .changes/*.json
git add .changes/next-release/*.json
git add README.md
git add CHANGELOG.md


echo -e "\nGit status before commit"
git status

git commit -m "Update files for new version '${new_version}' [skip ci]"
git push origin ${BITBUCKET_BRANCH}

echo -e "\nGit status after commit and push"
git status

# Tag
echo "Add version tag ${new_version} to repo"
git tag -a -m "Tagging for release ${new_version}" "${new_version}"
git push origin ${new_version}