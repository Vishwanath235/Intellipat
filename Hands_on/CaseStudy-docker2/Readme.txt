root@ip-172-31-10-31:~# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
wordpress           latest              04b52c96c4b6        7 days ago          543MB
mysql               5.7                 8679ced16d20        7 days ago          448MB
nginx               latest              8cf1bfb43ff5        8 days ago          132MB
hshar/webapp        latest              0cbc1f535ed8        18 months ago       303MB
hshar/mysql         5.6                 9b8d97435534        18 months ago       205MB


root@ip-172-31-10-31:~# docker pull ubuntu:18.04
18.04: Pulling from library/ubuntu
7595c8c21622: Pull complete
d13af8ca898f: Pull complete
70799171ddba: Pull complete
b6c12202c5ef: Pull complete
Digest: sha256:a61728f6128fb4a7a20efaa7597607ed6e69973ee9b9123e3b4fd28b7bba100b
Status: Downloaded newer image for ubuntu:18.04
docker.io/library/ubuntu:18.04


root@ip-172-31-10-31:~# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              18.04               2eb2d388e1a2        5 days ago          64.2MB
wordpress           latest              04b52c96c4b6        7 days ago          543MB
mysql               5.7                 8679ced16d20        7 days ago          448MB
nginx               latest              8cf1bfb43ff5        8 days ago          132MB
hshar/webapp        latest              0cbc1f535ed8        18 months ago       303MB
hshar/mysql         5.6                 9b8d97435534        18 months ago       205MB


root@ip-172-31-10-31:~# docker run -it -d ubuntu:18.04
e19d3e3f50f25814d2a29f0399ed535b3073fbae6759daf03807df29cb61584d
root@ip-172-31-10-31:~# docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS               NAMES
e19d3e3f50f2        ubuntu:18.04          "/bin/bash"              3 seconds ago       Up 3 seconds                            inspiring_herschel
48af758a970d        hshar/mysql:5.6       "docker-entrypoint.s…"   7 minutes ago       Up 6 minutes        3306/tcp            db.1.ch027j0xbzmjivu9b8wnz2sda
a952e94252d0        hshar/webapp:latest   "/bin/sh -c 'apachec…"   7 minutes ago       Up 6 minutes        80/tcp              website.2.xqvgywfxkocw8kp8fod0tad7l


root@ip-172-31-10-31:~# docker exec -it e19d3e3f50f2 /bin/bash
root@e19d3e3f50f2:/# apt-get update
root@e19d3e3f50f2:/# apt-get install -y apache2

-- command to manually create custom docker image

root@ip-172-31-10-31:~# docker commit -m "ubuntu with apache2 image" -c 'CMD ["apachectl", "-D", "FOREGROUND"]' -c 'EXPOSE 80' e19d3e3f50f2 imgapache
sha256:8cc29662cb9cb12e303c4655725f5555a525884073952ffb668d86bf395fd628

root@ip-172-31-10-31:~# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
imgapache           latest              8cc29662cb9c        12 seconds ago      190MB
ubuntu              18.04               2eb2d388e1a2        5 days ago          64.2MB
wordpress           latest              04b52c96c4b6        7 days ago          543MB
mysql               5.7                 8679ced16d20        7 days ago          448MB
nginx               latest              8cf1bfb43ff5        8 days ago          132MB
hshar/webapp        latest              0cbc1f535ed8        18 months ago       303MB
hshar/mysql         5.6                 9b8d97435534        18 months ago       205MB

root@ip-172-31-10-31:~# docker run -it -P -v /root/container:/var/www/html -d imgapache:latest
09c885fd217ac4dea9e54775dcc194425f295bf0dcd8806f69d228aafd5b1b8e

root@ip-172-31-10-31:~# docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                   NAMES
09c885fd217a        imgapache:latest      "apachectl -D FOREGR…"   7 seconds ago       Up 5 seconds        0.0.0.0:32774->80/tcp   lucid_feynman
e19d3e3f50f2        ubuntu:18.04          "/bin/bash"              9 minutes ago       Up 9 minutes                                inspiring_herschel
48af758a970d        hshar/mysql:5.6       "docker-entrypoint.s…"   16 minutes ago      Up 15 minutes       3306/tcp                db.1.ch027j0xbzmjivu9b8wnz2sda
a952e94252d0        hshar/webapp:latest   "/bin/sh -c 'apachec…"   16 minutes ago      Up 15 minutes       80/tcp                  website.2.xqvgywfxkocw8kp8fod0tad7l

root@ip-172-31-10-31:~/Intellipat/Hands_on/CaseStudy-docker2# docker run -it -P -v /root/Intellipat/Hands_on/CaseStudy-docker2:/var/www/html -d imgapache:latest
7ea692a353661fd1728761717de4911a60e8ab3a6563c4c7986d6d5b3cebb156

root@ip-172-31-10-31:~/Intellipat/Hands_on/CaseStudy-docker2# docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                   NAMES
7ea692a35366        imgapache:latest      "apachectl -D FOREGR…"   4 seconds ago       Up 3 seconds        0.0.0.0:32777->80/tcp   awesome_clarke
09c885fd217a        imgapache:latest      "apachectl -D FOREGR…"   19 minutes ago      Up 19 minutes       0.0.0.0:32774->80/tcp   lucid_feynman
e19d3e3f50f2        ubuntu:18.04          "/bin/bash"              28 minutes ago      Up 28 minutes                               inspiring_herschel
48af758a970d        hshar/mysql:5.6       "docker-entrypoint.s…"   35 minutes ago      Up 35 minutes       3306/tcp                db.1.ch027j0xbzmjivu9b8wnz2sda
a952e94252d0        hshar/webapp:latest   "/bin/sh -c 'apachec…"   35 minutes ago      Up 35 minutes       80/tcp                  website.2.xqvgywfxkocw8kp8fod0tad7l

root@ip-172-31-10-31:~/Intellipat/Hands_on/CaseStudy-docker2# vi index.html
root@ip-172-31-10-31:~/Intellipat/Hands_on/CaseStudy-docker2# cat index.html
<html>
<head>
        <h1> Welcome to the world of dockers ... </h1>
</head>
</html>

