root@ip-172-31-36-254:~# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              <none>              1e4467b07108        8 days ago          73.9MB
ubuntu              18.04               2eb2d388e1a2        8 days ago          64.2MB
httpd               latest              9d2a0c6e5b57        9 days ago          166MB
nginx               latest              8cf1bfb43ff5        10 days ago         132MB
root@ip-172-31-36-254:~# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
cb1766cb046e        ubuntu:18.04        "/bin/bash"              10 hours ago        Up 10 hours                              cont1
9483f0dbaba2        httpd               "httpd-foreground"       12 hours ago        Up 12 hours         0.0.0.0:91->80/tcp   casestudy-docker2_web_1
3703ede4b941        nginx               "/docker-entrypoint.…"   12 hours ago        Up 12 hours         0.0.0.0:92->80/tcp   casestudy-docker2_app_1

root@ip-172-31-36-254:~# docker run -it --name vish1 -d ubuntu
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
Digest: sha256:5d1d5407f353843ecf8b16524bc5565aa332e9e6a1297c73a92d3e754b8a636d
Status: Downloaded newer image for ubuntu:latest
f79bd46cfad046e853ff0a47e343450cac7b6f2d9f4c0b2495c9283cd241e657

root@ip-172-31-36-254:~# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
f79bd46cfad0        ubuntu              "/bin/bash"              7 seconds ago       Up 6 seconds                             vish1
cb1766cb046e        ubuntu:18.04        "/bin/bash"              10 hours ago        Up 10 hours                              cont1
9483f0dbaba2        httpd               "httpd-foreground"       12 hours ago        Up 12 hours         0.0.0.0:91->80/tcp   casestudy-docker2_web_1
3703ede4b941        nginx               "/docker-entrypoint.…"   12 hours ago        Up 12 hours         0.0.0.0:92->80/tcp   casestudy-docker2_app_1

root@ip-172-31-36-254:~# docker run -it --name vish2 --link vish1 -d ubuntu
a0ddb370bb76fe8c2c2ede9d5225c1bf7bfcb45d6305391660bf2a42f6b99a2c

root@ip-172-31-36-254:~# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
a0ddb370bb76        ubuntu              "/bin/bash"              3 seconds ago       Up 2 seconds                             vish2
f79bd46cfad0        ubuntu              "/bin/bash"              10 minutes ago      Up 10 minutes                            vish1
cb1766cb046e        ubuntu:18.04        "/bin/bash"              11 hours ago        Up 11 hours                              cont1
9483f0dbaba2        httpd               "httpd-foreground"       12 hours ago        Up 12 hours         0.0.0.0:91->80/tcp   casestudy-docker2_web_1
3703ede4b941        nginx               "/docker-entrypoint.…"   12 hours ago        Up 12 hours         0.0.0.0:92->80/tcp   casestudy-docker2_app_1

root@ip-172-31-36-254:~# docker exec -it vish2 /bin/bash

root@a0ddb370bb76:/# apt-get update

root@a0ddb370bb76:/# apt-get install iputils-ping

root@a0ddb370bb76:/# ping vish1
PING vish1 (172.17.0.2) 56(84) bytes of data.
64 bytes from vish1 (172.17.0.2): icmp_seq=1 ttl=64 time=0.069 ms
64 bytes from vish1 (172.17.0.2): icmp_seq=2 ttl=64 time=0.062 ms
64 bytes from vish1 (172.17.0.2): icmp_seq=3 ttl=64 time=0.062 ms
^C
--- vish1 ping statistics ---

