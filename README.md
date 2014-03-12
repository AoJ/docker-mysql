# Docker Mysql

- mysql version 5.5, ubuntu 12.04
- root can login only from localhost without password
- generate admin superuser with passwords (see docker logs)
- optimize filesystem for innodb
- with ssh and supervisor

## Usage

### in Dockerfile
    FROM aooj/mysql:latest
    # load your public key for ssh
    # you can connect to container
    # ssh -p[port] -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost
    ADD /path/to/your/ssh/public/key /root/.ssh/authorized_keys
    
### direct run
    docker run -t -i aooj/mysql:latest

### build
    git clone https://github.com/AoJ/docker-mysql.git
    make build
    
### and start it
    make run

### or build, start and attach
    make debug
    


## TODO
- optimize config
    
## Changelog
- 1.0 first realese
