-- wordpress docker-compose yml file.

version: '3.3'
services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: somewordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
volumes:
  db_data:

-- run docker-compose file.
 docker-compose up -d

-- details of docker images command

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
wordpress           latest              04b52c96c4b6        6 days ago          543MB
mysql               5.7                 8679ced16d20        6 days ago          448MB

-- details of docker ps command

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
390b4afedc83        wordpress:latest    "docker-entrypoint.s…"   6 hours ago         Up 6 hours          0.0.0.0:8000->80/tcp   wordpress_wordpress_1
1319095efe0d        mysql:5.7           "docker-entrypoint.s…"   6 hours ago         Up 6 hours          3306/tcp, 33060/tcp    wordpress_db_1
