FROM postgres

ARG SOURCE
ARG COMMIT_HASH
ARG COMMIT_ID
ARG BUILD_TIME
LABEL source=${SOURCE}
LABEL commit_hash=${COMMIT_HASH}
LABEL commit_id=${COMMIT_ID}
LABEL build_time=${BUILD_TIME}
RUN apt-get update
RUN apt-get install -y python3 python3-pip python3-xlrd git

ARG container_user=mosip

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user_group=mosip

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user_uid=1001

# can be passed during Docker build as build time environment for github branch to pickup configuration from.
ARG container_user_gid=1001

# install packages and create user
RUN apt-get -y update \
&& apt-get install -y unzip \
&& groupadd -g ${container_user_gid} ${container_user_group} \
&& useradd -u ${container_user_uid} -g ${container_user_group} -s /bin/sh -m ${container_user}

WORKDIR /home/${container_user}/repos/

ENV GIT_REPO_URL=

ENV GIT_BRANCH=

ENV MOSIP_MAIN_DB_DIR_NAME=

ENV MOSIP_ARCHIVE_DB_DIR_NAME=

ENV MOSIP_DB_NAME=

ENV DB_SERVERIP=

ENV DB_PORT=5432

ENV SU_USER=postgres

ENV SU_USER_PWD=

ENV DEFAULT_DB_NAME=postgres

ENV DBUSER_PWD=

ENV DB_UNAME=

ENV DML_FLAG=

ENV CREATE_ARCHIVE_DB=

# ENV ARCHIVE_DB_SERVERIP=

# ENV ARCHIVE_DB_PORT=5435

# ENV ARCHIVE_SU_USER=postgres

# ENV ARCHIVE_SU_USER_PWD=

# ENV ARCHIVE_DEFAULT_DB_NAME=postgres

# ENV ARCHIVE_MOSIP_DB_NAME=

# ENV ARCHIVE_DML_FLAG=

# ENV ARCHIVE_DBUSER_PWD=

ADD postgres-init.sh postgres-init.sh

# change permissions of file inside working dir
RUN chown -R ${container_user}:${container_user} /home/${container_user}/repos/

# select container user for all tasks
USER ${container_user_uid}:${container_user_gid}

ENTRYPOINT ["./postgres-init.sh" ]
