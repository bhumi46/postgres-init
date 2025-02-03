#!/bin/bash

set -e
# Default CREATE_ARCHIVE_DB to false if not set
CREATE_ARCHIVE_DB=${CREATE_ARCHIVE_DB:-false}

echo "Cloning "$GIT_BRANCH "of repo" $GIT_REPO_URL "for" $MOSIP_DB_NAME "db_scripts"

git clone --depth 1 --branch $GIT_BRANCH $GIT_REPO_URL

echo "Successfully cloned the repository"

echo "Extracting db_scripts"

git_repo_name="$(basename "$GIT_REPO_URL" .git)"

cd $git_repo_name

git sparse-checkout init --cone && git sparse-checkout set db_scripts

find . -type f ! -path "./db_scripts/*" -exec rm -f {} \;

echo "Extracted only db_scripts"

if [ "$CREATE_ARCHIVE_DB" = "true" ]; then
    echo "Creating archive database"
    cd db_scripts/$MOSIP_ARCHIVE_DB_DIR_NAME
    echo "Executing archive db_script"
    bash deploy.sh
else
    echo "Creating main database"
    cd db_scripts/$MOSIP_MAIN_DB_DIR_NAME
    echo "Executing main db_script"
    bash deploy.sh
fi
