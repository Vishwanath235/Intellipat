===============================================================================================
3. Initialize a Docker Swarm Cluster, and deploy two ubuntu containers in a overlay network.
Demonstrate they can communicate with each other, by pinging them
===============================================================================================



root@ip-172-31-36-254:~/Intellipat/Dockers/CaseStudy/docker-2/3# docker network ls
NETWORK ID          NAME                        DRIVER              SCOPE
0ae77208a14a        bridge                      bridge              local
ec08467bbb78        casestudy-docker2_default   bridge              local
38fd19cc2db5        docker_gwbridge             bridge              local
ee9be3660867        host                        host                local
10opsvjv95jw        ingress                     overlay             swarm
febe30dda6d9        none                        null                local

root@ip-172-31-36-254:~/Intellipat/Dockers/CaseStudy/docker-2/3# docker network create -d overlay --attachable mynet
olde0to930a1enl9qnkab69hj

root@ip-172-31-36-254:~/Intellipat/Dockers/CaseStudy/docker-2/3# docker network ls
NETWORK ID          NAME                        DRIVER              SCOPE
0ae77208a14a        bridge                      bridge              local
ec08467bbb78        casestudy-docker2_default   bridge              local
38fd19cc2db5        docker_gwbridge             bridge              local
ee9be3660867        host                        host                local
10opsvjv95jw        ingress                     overlay             swarm
olde0to930a1        mynet                       overlay             swarm
febe30dda6d9        none                        null                local

root@ip-172-31-36-254:~/Intellipat/Dockers/CaseStudy/docker-2/3# docker run -it --name cont1 --network mynet ubuntu:18.04

root@cb1766cb046e:/# apt-get update
root@cb1766cb046e:/# apt-get install iputils-ping

root@cb1766cb046e:/# ping cont2
PING cont2 (10.0.4.4) 56(84) bytes of data.
64 bytes from cont2.mynet (10.0.4.4): icmp_seq=1 ttl=64 time=0.536 ms
64 bytes from cont2.mynet (10.0.4.4): icmp_seq=2 ttl=64 time=0.583 ms
64 bytes from cont2.mynet (10.0.4.4): icmp_seq=3 ttl=64 time=0.580 ms
^C
--- cont2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2055ms
rtt min/avg/max/mdev = 0.536/0.566/0.583/0.028 ms

root@ip-172-31-36-254:~/Intellipat/Dockers/CaseStudy/docker-2/3# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
cb1766cb046e        ubuntu:18.04        "/bin/bash"              7 minutes ago       Up 7 minutes                             cont1
9483f0dbaba2        httpd               "httpd-foreground"       2 hours ago         Up 2 hours          0.0.0.0:91->80/tcp   casestudy-docker2_web_1
3703ede4b941        nginx               "/docker-entrypoint.…"   2 hours ago         Up 2 hours          0.0.0.0:92->80/tcp   casestudy-docker2_app_1


-- on the other node 

root@ip-172-31-36-215:~# docker run -it --name cont2 --network mynet ubuntu:18.04

root@f3fc863b152d:/# root@ip-172-31-36-215:~#
root@ip-172-31-36-215:~# docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f3fc863b152d        ubuntu:18.04        "/bin/bash"         10 seconds ago      Up 8 seconds                            cont2


