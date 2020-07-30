root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm-service# docker service create --name nginx1 --replicas 3 --publish 80:80 nginx:latest
at64nlm3bipot0th4el75oygb
overall progress: 3 out of 3 tasks
1/3: running
2/3: running
3/3: running
verify: Service converged
root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm-service#
root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm-service# docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
at64nlm3bipo        nginx1              replicated          3/3                 nginx:latest        *:80->80/tcp
root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm-service# docker service ps nginx1
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
xk4p2rdy521z        nginx1.1            nginx:latest        ip-172-31-39-253    Running             Running 29 seconds ago
tkt5xphtl1l3        nginx1.2            nginx:latest        ip-172-31-39-253    Running             Running 30 seconds ago
oh70ltn903nn        nginx1.3            nginx:latest        ip-172-31-10-31     Running             Running 32 seconds ago

root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm-service# docker service rm nginx1
nginx1
root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm-service# docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS

