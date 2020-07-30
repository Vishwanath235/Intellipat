root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
104e9874b4b0        bridge              bridge              local
702ddedbbb18        docker_gwbridge     bridge              local
f27fc36c4eec        host                host                local
t2897uw5j8ez        ingress             overlay             swarm
88186058008d        none                null                local
d5cede776d14        wordpress_default   bridge              local
root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App#

-- create overlay network.

root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker network create -d overlay my-overlay
xypfsw4xewjrodxugz05mxjv5

root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
104e9874b4b0        bridge              bridge              local
702ddedbbb18        docker_gwbridge     bridge              local
f27fc36c4eec        host                host                local
t2897uw5j8ez        ingress             overlay             swarm
xypfsw4xewjr        my-overlay          overlay             swarm
88186058008d        none                null                local
d5cede776d14        wordpress_default   bridge              local

-- creating webapp services

root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker service create --name website --replicas 3 --network my-overlay --publish 80:80 hshar/webapp
xp5dra349li07doexbzr3jwqp
overall progress: 3 out of 3 tasks
1/3: running   [==================================================>]
2/3: running   [==================================================>]
3/3: running   [==================================================>]
verify: Service converged
root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                 PORTS
xp5dra349li0        website             replicated          3/3                 hshar/webapp:latest   *:80->80/tcp
root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED              STATUS              PORTS               NAMES
495e7377349d        hshar/webapp:latest   "/bin/sh -c 'apachec…"   About a minute ago   Up About a minute   80/tcp              website.2.xp4mnq5lf8uagt1q4geq2yaj7
390b4afedc83        wordpress:latest      "docker-entrypoint.s…"   27 hours ago         Up 27 hours                             wordpress_wordpress_1
1319095efe0d        mysql:5.7             "docker-entrypoint.s…"   27 hours ago         Up 27 hours                             wordpress_db_1

-- creating db services

root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker service create --name db --replicas 1 --network my-overlay hshar/mysql:5.6
rymn78cnxn6kel7w6gcuwet64
overall progress: 1 out of 1 tasks
1/1: running   [==================================================>]
verify: Service converged

-- connect with Mysql container and create Database

root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED              STATUS              PORTS               NAMES
fe45910d15c3        hshar/mysql:5.6       "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp            db.1.ypktqqr0w3rlo5fz4tqh2tjy3
495e7377349d        hshar/webapp:latest   "/bin/sh -c 'apachec…"   5 minutes ago        Up 5 minutes        80/tcp              website.2.xp4mnq5lf8uagt1q4geq2yaj7
390b4afedc83        wordpress:latest      "docker-entrypoint.s…"   27 hours ago         Up 27 hours                             wordpress_wordpress_1
1319095efe0d        mysql:5.7             "docker-entrypoint.s…"   27 hours ago         Up 27 hours                             wordpress_db_1
root@ip-172-31-10-31:~/Intellipat/Hands_on/Multi-tier_App# docker exec -it fe45910d15c3 /bin/bash
root@fe45910d15c3:/# mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1
Server version: 5.5.62 MySQL Community Server (GPL)

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database docker;
Query OK, 1 row affected (0.00 sec)

mysql> use docker;
Database changed
mysql> create table emp(name varchar(20), phone varchar(20));
Query OK, 0 rows affected (0.00 sec)

mysql> select * from emp;
Empty set (0.00 sec)

mysql> select * from emp;
+------------+-------+
| name       | phone |
+------------+-------+
| vishwanath | bhat  |
| Rianna     | Bhat  |
+------------+-------+
2 rows in set (0.00 sec)

