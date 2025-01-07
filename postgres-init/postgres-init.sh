#!/bin/bash

set -e

echo "Cloning "$GIT_BRANCH "of repo" $GIT_REPO_URL "for" $MOSIP_DB_NAME "db_scripts"

git clone --depth 1 --branch $GIT_BRANCH $GIT_REPO_URL

echo "Sucessfully cloned the repository"

echo "extracting db_scripts"

git_repo_name="$(basename "$GIT_REPO_URL" .git)"

cd $git_repo_name

git sparse-checkout init --cone && git sparse-checkout set db_scripts

find . -type f ! -path "./db_scripts/*" -exec rm -f {} \;

echo "Extracted only db_scripts"

cd db_scripts/$MOSIP_DB_DIR_NAME

echo "Executing db_script"

bash deploy.sh
