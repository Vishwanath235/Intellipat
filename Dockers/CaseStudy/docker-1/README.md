Assignment
Problem Statement:
====================

A developer wants to the following task:
1. Create a web container(apache) using Dockerfile
Deploy index.html, use this github link https://github.com/hshar94/helloworld
2. Save changes to this container, and upload to your Dockerhub


Command to install Docker:
==========================
    
      sudo apt-get remove docker docker-engine docker.io containerd runc
      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io

Creation of docker image using dockerfiler:   
===========================================

    docker build -f dockerfile -t docker-case1:v3 .
    docker images
    docker run -d -P docker-case1:v3
    docker ps

docker images
=============

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker-case1        v3                  bb1cf4b2a5ba        10 minutes ago      190MB
docker-case1        v2                  95b56c853f34        16 minutes ago      190MB
docker-case1        v1                  85aceb3ae4db        22 minutes ago      190MB
ubuntu              18.04               d27b9ffc5667        2 weeks ago         64.2MB

Content of Index.html
=======================

<html>
<body>
<h1>Welcome to Intellipaat </h1>
</body>
</html>

Content of dockerfile
=====================

FROM ubuntu:18.04
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y apache2
ADD . /var/www/html
EXPOSE 80 
CMD ["apachectl", "-D", "FOREGROUND"] 

docker ps 
===================

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                   NAMES
bb3a0645c257        docker-case1:v3     "apachectl -D FOREGR…"   16 minutes ago      Up 16 minutes       0.0.0.0:32784->80/tcp   pedantic_mcnulty
3e26f05dc4d4        docker-case1:v2     "apachectl -D FOREGR…"   22 minutes ago      Up 22 minutes       0.0.0.0:32783->80/tcp   naughty_hodgkin
10d7cf74f9c2        docker-case1:v1     "apachectl -D FOREGR…"   25 minutes ago      Up 24 minutes       0.0.0.0:32782->80/tcp   elastic_wilbur
99f4b6648f0c        docker-case1:v1     "apachectl -D FOREGR…"   27 minutes ago      Up 27 minutes       0.0.0.0:32780->80/tcp   great_lamport

Uploading Images to Docker Hub
==================================

docker tag docker-case1:v3 vish2020/dockerfile1

docker images
REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
vish2020/dockerfile1   latest              bb1cf4b2a5ba        About an hour ago   190MB
docker-case1           v3                  bb1cf4b2a5ba        About an hour ago   190MB
docker-case1           v2                  95b56c853f34        About an hour ago   190MB
docker-case1           v1                  85aceb3ae4db        About an hour ago   190MB
ubuntu                 18.04               d27b9ffc5667        2 weeks ago         64.2MB


root@ip-172-31-8-13:~# docker push vish2020/dockerfile1
The push refers to repository [docker.io/vish2020/dockerfile1]
36799c91df92: Pushed
0f338df9e620: Pushed
554c08c598f3: Pushed
4b07a7bca5b7: Mounted from vish2020/webapp1
2af0e1f1e531: Mounted from vish2020/webapp1
bf509d6bc5ec: Mounted from vish2020/webapp1
88cc1a200eb9: Mounted from vish2020/webapp1
latest: digest: sha256:d072b0e5ac90fd5749abff0f644551035b3dca07ee950c2dc28d57268cc216cd size: 1785
