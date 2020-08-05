Ansible Assignment:
===================
1. Create two server Groups. One for Apache and another for Nginx.
2. Push two html files with their server information.

make sure that you dont forget to start the services once the installation is done. Also send post installation messages for both the server groups.

Using Ansible roles accomplish the above tasks.

Also, once the Apache server configuration is done you need to install java on that server group using ansible role in a playbook.

ansible@ip-172-31-33-14:~/roles$ tree nginx
nginx
├── README.md
├── defaults
│   └── main.yml
├── files
│   └── index.html
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   ├── configure.yml
│   ├── install.yml
│   ├── main.yml
│   └── services.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

8 directories, 12 files

ansible@ip-172-31-33-14:~/roles/nginx/tasks$ ls -lrt
total 16
-rw-rw-r-- 1 ansible ansible 105 Aug  5 04:37 main.yml
-rw-rw-r-- 1 ansible ansible  76 Aug  5 04:48 services.yml
-rw-rw-r-- 1 ansible ansible 120 Aug  5 05:39 install.yml
-rw-rw-r-- 1 ansible ansible  74 Aug  5 11:58 configure.yml
ansible@ip-172-31-33-14:~/roles/nginx/tasks$
ansible@ip-172-31-33-14:~/roles/nginx/tasks$ cat main.yml
---
# tasks file for nginx
  - include: install.yml
  - include: configure.yml
  - include: services.yml
ansible@ip-172-31-33-14:~/roles/nginx/tasks$
ansible@ip-172-31-33-14:~/roles/nginx/tasks$ cat install.yml
---
  - name: installing nginx
    apt: name=nginx state=latest
  - debug:
      msg: "Nginx installation successfully"
ansible@ip-172-31-33-14:~/roles/nginx/tasks$
ansible@ip-172-31-33-14:~/roles/nginx/tasks$ cat configure.yml
---
  - name: configure nginx
    copy: src=index.html dest=/var/www/html
ansible@ip-172-31-33-14:~/roles/nginx/tasks$
ansible@ip-172-31-33-14:~/roles/nginx/tasks$ cat services.yml
---
  - name: restarting the services
    service: name=nginx state=started

ansible@ip-172-31-33-14:~/roles/nginx/files$ cat index.html
<html>
<body>
<h1> I am from nginx server. My ipaddre is 13.233.99.221 </h1>
</body>
</html>



ansible@ip-172-31-33-14:~/roles$ tree apache/
apache/
├── README.md
├── defaults
│   └── main.yml
├── files
│   └── index.html
├── handlers
│   └── main.yml
├── meta
│   └── main.yml
├── tasks
│   ├── configure.yml
│   ├── install.yml
│   ├── main.yml
│   └── services.yml
├── templates
├── tests
│   ├── inventory
│   └── test.yml
└── vars
    └── main.yml

8 directories, 12 files


ansible@ip-172-31-33-14:~/roles/apache/tasks$ cat main.yml
---
# tasks file for apache
  - include: install.yml
  - include: configure.yml
  - include: services.yml

ansible@ip-172-31-33-14:~/roles/apache/tasks$
ansible@ip-172-31-33-14:~/roles/apache/tasks$ cat services.yml
  - name: starting the services
    service: name=apache2 state=restarted
ansible@ip-172-31-33-14:~/roles/apache/tasks$
ansible@ip-172-31-33-14:~/roles/apache/tasks$ cat configure.yml
---
  - name: configure the apache services.
    copy: src=index.html dest=/var/www/html
    notify:
      - install java

ansible@ip-172-31-33-14:~/roles/apache/tasks$
ansible@ip-172-31-33-14:~/roles/apache/tasks$ cat install.yml
 - name: installing apache
   apt: name=apache2 update_cache=yes state=latest
 - debug:
      msg: "installation of apache completed sucessfully"

ansible@ip-172-31-33-14:~/roles/apache/tasks$


ansible@ip-172-31-33-14:~/roles/apache/files$ cat index.html
<html>
<body>
<h1> I am from apache server. My Public IP-address is 13.126.155.194 </h1>
</body>
</html>

ansible@ip-172-31-33-14:~/roles/apache/handlers$ cat main.yml
---
# handlers file for apache
  - name: install java
    apt: name=openjdk-8-jdk state=present


ansible@ip-172-31-33-14:~$ cat play3.yml
---
  - hosts: slave1
    become: yes
    roles:
      - nginx
  - hosts: slave2
    become: yes
    roles:
      - apache
	




ansible@ip-172-31-33-14:~$ ansible-playbook play3.yml

PLAY [slave1] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [172.31.36.13]

TASK [installing nginx] ********************************************************
ok: [172.31.36.13]

TASK [nginx : debug] ***********************************************************
ok: [172.31.36.13] => {
    "msg": "Nginx installation successfully"
}

TASK [configure nginx] *********************************************************
ok: [172.31.36.13]

TASK [nginx : restarting the services] *****************************************
ok: [172.31.36.13]

PLAY [slave2] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [172.31.47.201]

TASK [installing apache] *******************************************************
ok: [172.31.47.201]

TASK [apache : debug] **********************************************************
ok: [172.31.47.201] => {
    "msg": "installation of apache completed sucessfully"
}

TASK [configure the apache services.] ******************************************
changed: [172.31.47.201]

TASK [apache : starting the services] ******************************************
changed: [172.31.47.201]

RUNNING HANDLER [apache : install java] ****************************************
ok: [172.31.47.201]

PLAY RECAP *********************************************************************
172.31.36.13               : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.31.47.201              : ok=6    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

