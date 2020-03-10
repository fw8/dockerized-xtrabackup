# Dockerized xtrabackup (2.4)

Percona XtraBackup makes MySQL hot backups for all versions of MySQL, including 5.6.

## Usage

Source and target directories need to be mounted as volumes. In order to gain access to the running database, credentials should be provided.

### Simple backup & prepare (use the defaults for datadir and target)

    docker run --rm \
      -v /var/lib/mysql:/var/lib/mysql \
      -v /nfs/xtrabackup:/target \
      -v $PWD/.my.cnf:/root/.my.cnf \
      --network host freinet/xtrabackup:2.4.18-1

### Create a new backup

    docker run --rm \
      -v /var/lib/mysql:/var/lib/mysql \
      -v /nfs/xtrabackup:/target \
      -v $PWD/.my.cnf:/root/.my.cnf \
      --network host freinet/xtrabackup:2.4.18-1 --no-version-check \
      --datadir=/var/lib/mysql \
      --target-dir=/target \
      --backup --safe-slave-backup

### Prepare a consistent backup, usable for immediate restore

    docker run --rm \
      -v /var/lib/mysql:/var/lib/mysql \
      -v /nfs/xtrabackup:/target \
      -v $PWD/.my.cnf:/root/.my.cnf \
      --network host freinet/xtrabackup:2.4.18-1 --no-version-check \
      --datadir=/var/lib/mysql \
      --target-dir=/target \
      --prepare

### Get a list of available options

    docker run --rm \
      -v /var/lib/mysql:/var/lib/mysql \
      -v /nfs/xtrabackup:/target \
      freinet/xtrabackup:2.4.18-1 \
      --help

## Build and push the docker image

docker build -t freinet/xtrabackup:2.4.18-1 .
docker push freinet/xtrabackup:2.4.18-1
