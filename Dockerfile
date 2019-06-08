FROM fedora:30

COPY ./resources/MariaDB.repo  /etc/yum.repos.d/

RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB \
    && dnf install MariaDB-server -y --nodocs \
    && dnf upgrade -y \
    && dnf clean all
RUN chown mysql:mysql /var/lib/mysql && chmod 770 /var/lib/mysql \
    && mkdir /var/log/mariadb && chown mysql:mysql /var/log/mariadb && chmod 770 /var/log/mariadb \
    && mkdir /run/mariadb/ && chown mysql:mysql /run/mariadb/ 

VOLUME ["/var/lib/mysql", "/etc/my.cnf.d", "/var/log/mariadb"]

EXPOSE 3306/tcp

USER mysql

CMD ["mysqld_safe", "--defaults-extra-file=/etc/my.cnf.d/mariadb-server.cnf"]
