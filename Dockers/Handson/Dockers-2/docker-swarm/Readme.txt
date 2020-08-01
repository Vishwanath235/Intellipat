root@ip-172-31-10-31:~# docker swarm init --advertise-addr 35.154.89.226
Swarm initialized: current node (21jfbzm4cl12md5697egwaye8) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-01gezocerytdoaih4bvfxkuzj6yla8vpxaygq51p5l7zey359z-76t47z9ibulgrae2tt8utdzkr 35.154.89.226:2377



To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

-- ran below command on slave node.

root@ip-172-31-39-253:~# docker swarm join --token SWMTKN-1-01gezocerytdoaih4bvfxkuzj6yla8vpxaygq51p5l7zey359z-76t47z9ibulgrae2tt8utdzkr 35.154.89.226:2377
This node joined a swarm as a worker.

-- output of docker node ls command.

ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
21jfbzm4cl12md5697egwaye8 *   ip-172-31-10-31     Ready               Active              Leader              19.03.12


jnlr4vnzgvw9hlt9mtj28iflw     ip-172-31-39-253    Ready               Active                                  19.03.12\


root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm# docker swarm leave --force
Node left the swarm.
root@ip-172-31-10-31:~/Intellipat/Hands_on/docker-swarm# docker node ls
Error response from daemon: This node is not a swarm manager. Use "docker swarm init" or "docker swarm join" to connect this node to swarm and try again.

