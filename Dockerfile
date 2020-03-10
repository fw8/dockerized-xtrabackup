FROM    debian:stretch-slim

LABEL   MAINTAINER="Florian Wolpert <wolpert@freinet.de>"

ARG     XTRABACKUP_VERSION="2.4.18-1"
ENV     XTRABACKUP_TARGET_DIR="/target" \
        XTRABACKUP_SOURCE_DIR="/var/lib/mysql"

RUN     set -x && \
        apt-get -qq update && \
        apt-get -qq install wget && \
        # do some sick versioning stuff because percona has a very "special" versioning
        ## '8.0.6-1' to '80'
        XTRABACKUP_VERSION_MINOR="$(echo "${XTRABACKUP_VERSION%.*}" | sed "s#\.##g")" && \
        wget -q -O /tmp/xtrabackup.deb \
            "https://www.percona.com/downloads/Percona-XtraBackup-${XTRABACKUP_VERSION%.*}/Percona-XtraBackup-${XTRABACKUP_VERSION%-*}/binary/debian/stretch/x86_64/percona-xtrabackup-${XTRABACKUP_VERSION_MINOR}_${XTRABACKUP_VERSION}.stretch_amd64.deb" && \
        apt-get -qq -f install /tmp/xtrabackup.deb && \
        apt-get -qq purge wget && \
        apt-get -qq autoclean && apt-get -qq autoremove && rm -rf /tmp/* /var/cache/apt/* /var/cache/depconf/*

COPY    entrypoint.sh /entrypoint.sh
RUN     chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]