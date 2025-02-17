FROM postgres

ARG SOURCE
ARG COMMIT_HASH
ARG COMMIT_ID
ARG BUILD_TIME
LABEL source=${SOURCE}
LABEL commit_hash=${COMMIT_HASH}
LABEL commit_id=${COMMIT_ID}
LABEL build_time=${BUILD_TIME}

RUN apt-get update && apt-get install -y python3 python3-pip libpq-dev python3-dev python3-xlrd python3-psycopg2

WORKDIR /home/mosip/repos/db_upgrade_scripts

VOLUME /home/mosip/repos/db_upgrade_scripts/upgrade.csv
VOLUME /home/mosip/repos/db_upgrade_scripts/archive_upgrade.csv

COPY ./repos/commons/db_upgrade_scripts .
COPY ./repos/pre-registration/db_upgrade_scripts .
COPY ./repos/registration/db_upgrade_scripts .
COPY ./repos/id-repository/db_upgrade_scripts .
COPY ./repos/id-authentication/db_upgrade_scripts .
COPY ./repos/partner-management-services/db_upgrade_scripts .
COPY ./repos/admin-services/db_upgrade_scripts .
COPY ./repos/keymanager/db_upgrade_scripts .
COPY ./repos/audit-manager/db_upgrade_scripts .
COPY ./repos/resident-services/db_upgrade_scripts .

ENV MOSIP_DBDIR_NAME=
ENV MOSIP_DB_NAME=
ENV DB_SERVERIP=
ENV DB_PORT=
ENV SU_USER=postgres
ENV SU_USER_PWD=
ENV DB_USER_PWD=
ENV PRIMARY_LANGUAGE_CODE=
ENV DEFAULT_DB_NAME=postgres
ENV CURRENT_VERSION=
ENV UPGRADE_VERSION=
ENV ACTION=
ENV UPDATE_ARCHIVEDB=false
ENV ARCHIVE_MOSIP_DB_NAME=mosip_archive
ENV ARCHIVE_DB_SERVERIP=localhost
ENV ARCHIVE_DB_PORT=5435
ENV ARCHIVE_SU_USER=postgres
ENV ARCHIVE_SU_USER_PWD=mosip@123
ENV ARCHIVE_DEFAULT_DB_NAME=postgres
ENV ARCHIVE_DBUSER_PWD=mosip@123

CMD ["/bin/bash", "-c", " \
    if [ \"$UPDATE_ARCHIVEDB\" = \"true\" ]; then \
        CSV_FILE=archive_upgrade.csv; \
    else \
        CSV_FILE=upgrade.csv; \
    fi; \
    while IFS=',' read -r $( [ \"$UPDATE_ARCHIVEDB\" = \"true\" ] && echo 'MOSIP_DBDIR_NAME MOSIP_DB_NAME CURRENT_VERSION UPGRADE_VERSION ACTION' || echo 'MOSIP_DB_NAME CURRENT_VERSION UPGRADE_VERSION ACTION' ); do \
        cd /home/mosip/repos/db_upgrade_scripts; \
        echo \"DB_DIR=\" $MOSIP_DBDIR_NAME; \
        echo \"DB=\" $MOSIP_DB_NAME; \
        echo \"CV=\" $CURRENT_VERSION; \
        echo \"UV=\" $UPGRADE_VERSION; \
        echo \"ACTION=\" $ACTION; \
        if [ \"$UPDATE_ARCHIVEDB\" = \"true\" ]; then \
            cd \"$MOSIP_DBDIR_NAME\"; \
        else \
            cd \"$MOSIP_DB_NAME\"; \
        fi; \
        bash upgrade.sh || exit 1; \
        echo \"Upgrade script execution completed for $MOSIP_DB_NAME.\"; \
    done <<< $(cat $CSV_FILE) \
"]

