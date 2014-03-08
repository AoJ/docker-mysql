# docker - mysql

FROM aooj/base:latest
 
# a mounted file systems table to make MySQL happy
RUN cat /proc/mounts > /etc/mtab

RUN apt-get -y install pwgen mysql-client mysql-server && apt-get clean

# supervisor
ADD files/mysql_supervisor.conf /etc/supervisor/conf.d/mysql.conf

 
# mysql
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
RUN sed -i '/^datadir*/ s|/var/lib/mysql|/data/mysql|' /etc/mysql/my.cnf
RUN mkdir -p /data/mysql
RUN rm -Rf /var/lib/mysql
ADD files/mysql.cnf /etc/mysql/conf.d/mysql.cnf 

ADD files/setup_mysql.sh /opt/run/setup_mysql.sh
 
EXPOSE 3306
