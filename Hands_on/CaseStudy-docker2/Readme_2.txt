Case-study 2: Deploy apache and nginx containers using Docker Compose, Apache should be exposed on
Port 91 and nginx on port 92


root@ip-172-31-38-6:~/Intellipat/Hands_on/CaseStudy-docker2# ls -lrt
total 3216
-rw-r--r-- 1 root root      89 Jul 31 05:13 index.html
-rw-r--r-- 1 root root    5880 Jul 31 05:13 Readme.txt
-rw-r--r-- 1 root root 1435706 Jul 31 05:13 Case-study-Docker2-frontend2.bmp
-rw-r--r-- 1 root root 1836558 Jul 31 05:13 Case-study-Docker2-Frontend.bmp
-rw-r--r-- 1 root root     121 Jul 31 05:17 compose.yml
root@ip-172-31-38-6:~/Intellipat/Hands_on/CaseStudy-docker2# cat compose.yml
version: '3'
services:
  web:
    image: httpd
    ports:
      - "91"
  app:
    image: nginx
    ports:
      - "92"

root@ip-172-31-38-6:~/Intellipat/Hands_on/CaseStudy-docker2# docker-compose -f compose.yml up -d
Creating casestudy-docker2_app_1 ... done
Creating casestudy-docker2_web_1 ... done
root@ip-172-31-38-6:~/Intellipat/Hands_on/CaseStudy-docker2# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                           NAMES
57b41ffdd2e9        httpd               "httpd-foreground"       9 seconds ago       Up 7 seconds        80/tcp, 0.0.0.0:32777->91/tcp   casestudy-docker2_web_1
4834c38d1829        nginx               "/docker-entrypoint.…"   9 seconds ago       Up 7 seconds        80/tcp, 0.0.0.0:32776->92/tcp   casestudy-docker2_app_1


