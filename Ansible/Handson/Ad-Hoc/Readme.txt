AD-HOC COMMANDS:
===============

The syntax is as follows while running the ad-hoc commands which help in running single or simple tasks just once and which need not be run later. For E.g. just installing Tomcat on all servers.
ansible hostORgroup -m module_name -a "arguments" -u username --become

1. Verify remote server is pingable.

ansible@ip-172-31-33-14:~$ ansible dev -m ping
172.31.36.13 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}

ansible@ip-172-31-33-14:~$ ansible dev -m command -a 'hostname'
172.31.36.13 | CHANGED | rc=0 >>
ip-172-31-36-13

ansible@ip-172-31-33-14:~$ ansible dev -m command -a 'uptime'
172.31.36.13 | CHANGED | rc=0 >>
 07:48:33 up  1:29,  2 users,  load average: 0.00, 0.00, 0.00

2. list files on remote server folder.

 ansible@ip-172-31-33-14:~$ ansible dev -m shell -a 'ls -l /tmp'
172.31.36.13 | CHANGED | rc=0 >>
total 12
drwx------ 2 ansible ansible 4096 Aug  4 07:49 ansible_command_payload_y5oxtsdw
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-resolved.service-TAdXmN
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-timesyncd.service-Nw1pcq
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:27 vish.txt
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:28 vish1.txt

3. Create OS user.

ansible@ip-172-31-33-14:~$ ansible dev -m user -a 'name=vish1 password=vish1' --become
[WARNING]: The input password appears not to have been hashed. The 'password'
argument must be encrypted for this module to work properly.
172.31.36.13 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "comment": "",
    "create_home": true,
    "group": 1002,
    "home": "/home/********",
    "name": "VALUE_SPECIFIED_IN_NO_LOG_PARAMETER",
    "password": "NOT_LOGGING_PASSWORD",
    "shell": "/bin/sh",
    "state": "present",
    "system": false,
    "uid": 1002
}

4. Verify user created on system.

ansible@ip-172-31-33-14:~$ ansible dev -m command -a 'cat /etc/passwd'
172.31.36.13 | CHANGED | rc=0 >>
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:100:102:systemd Network Management,,,:/run/systemd/netif:/usr/sbin/nologin
systemd-resolve:x:101:103:systemd Resolver,,,:/run/systemd/resolve:/usr/sbin/nologin
syslog:x:102:106::/home/syslog:/usr/sbin/nologin
messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
_apt:x:104:65534::/nonexistent:/usr/sbin/nologin
lxd:x:105:65534::/var/lib/lxd/:/bin/false
uuidd:x:106:110::/run/uuidd:/usr/sbin/nologin
dnsmasq:x:107:65534:dnsmasq,,,:/var/lib/misc:/usr/sbin/nologin
landscape:x:108:112::/var/lib/landscape:/usr/sbin/nologin
sshd:x:109:65534::/run/sshd:/usr/sbin/nologin
pollinate:x:110:1::/var/cache/pollinate:/bin/false
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
ansible:x:1001:1001::/home/ansible:/bin/bash
vish1:x:1002:1002::/home/vish1:/bin/sh

5. Delete user on system.

ansible@ip-172-31-33-14:~$ ansible dev -m user -a 'name=vish1 state=absent' --become
172.31.36.13 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "force": false,
    "name": "vish1",
    "remove": false,
    "state": "absent"
}


ansible@ip-172-31-33-14:~$ ansible dev -m command -a 'cat /etc/passwd'          172.31.36.13 | CHANGED | rc=0 >>
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:100:102:systemd Network Management,,,:/run/systemd/netif:/usr/sbin/nologin
systemd-resolve:x:101:103:systemd Resolver,,,:/run/systemd/resolve:/usr/sbin/nologin
syslog:x:102:106::/home/syslog:/usr/sbin/nologin
messagebus:x:103:107::/nonexistent:/usr/sbin/nologin
_apt:x:104:65534::/nonexistent:/usr/sbin/nologin
lxd:x:105:65534::/var/lib/lxd/:/bin/false
uuidd:x:106:110::/run/uuidd:/usr/sbin/nologin
dnsmasq:x:107:65534:dnsmasq,,,:/var/lib/misc:/usr/sbin/nologin
landscape:x:108:112::/var/lib/landscape:/usr/sbin/nologin
sshd:x:109:65534::/run/sshd:/usr/sbin/nologin
pollinate:x:110:1::/var/cache/pollinate:/bin/false
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash


ansible:x:1001:1001::/home/ansible:/bin/bash
ansible@ip-172-31-33-14:~$

6. Create file on remote server.

ansible@ip-172-31-33-14:~$ ansible dev -m file -a 'dest=/tmp/mickey.txt state=touch mode=600'
172.31.36.13 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "dest": "/tmp/mickey.txt",
    "gid": 1001,
    "group": "ansible",
    "mode": "0600",
    "owner": "ansible",
    "size": 0,
    "state": "file",
    "uid": 1001
}


ansible@ip-172-31-33-14:~$ ansible dev -m shell -a 'ls -l /tmp'                 172.31.36.13 | CHANGED | rc=0 >>
total 12
drwx------ 2 ansible ansible 4096 Aug  4 09:25 ansible_command_payload_6e0qqnxl
-rw------- 1 ansible ansible    0 Aug  4 09:24 mickey.txt
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-resolved.service-TAdXmN
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-timesyncd.service-Nw1pcq
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:27 vish.txt
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:28 vish1.txt

7. Create Directory.

ansible@ip-172-31-33-14:~$ ansible dev -m file -a 'dest=/tmp/mickey state=directory mode=755'
172.31.36.13 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "gid": 1001,
    "group": "ansible",
    "mode": "0755",
    "owner": "ansible",
    "path": "/tmp/mickey",
    "size": 4096,
    "state": "directory",
    "uid": 1001
}
ansible@ip-172-31-33-14:~$ ansible dev -m shell -a 'ls -l /tmp'                 172.31.36.13 | CHANGED | rc=0 >>
total 16
drwx------ 2 ansible ansible 4096 Aug  4 09:26 ansible_command_payload_pg8elbca
drwxr-xr-x 2 ansible ansible 4096 Aug  4 09:26 mickey
-rw------- 1 ansible ansible    0 Aug  4 09:24 mickey.txt
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-resolved.service-TAdXmN
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-timesyncd.service-Nw1pcq
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:27 vish.txt
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:28 vish1.txt


ansible@ip-172-31-33-14:~$ ansible dev -m file -a 'dest=/tmp/mickey.txt state=absent mode=600'
172.31.36.13 | CHANGED => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": true,
    "path": "/tmp/mickey.txt",
    "state": "absent"
}

8. copy file from source to destination server.

ansible@ip-172-31-33-14:~$ ansible dev -m copy -a "src=sakhi.txt dest=/tmp/"
172.31.36.13 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "checksum": "da39a3ee5e6b4b0d3255bfef95601890afd80709",
    "dest": "/tmp/sakhi.txt",
    "gid": 1001,
    "group": "ansible",
    "mode": "0664",
    "owner": "ansible",
    "path": "/tmp/sakhi.txt",
    "size": 0,
    "state": "file",
    "uid": 1001
}
ansible@ip-172-31-33-14:~$ ansible dev -m shell -a " ls -l /tmp"
172.31.36.13 | CHANGED | rc=0 >>
total 16
drwx------ 2 ansible ansible 4096 Aug  4 09:33 ansible_command_payload_giw54ve9
drwxr-xr-x 2 ansible ansible 4096 Aug  4 09:26 mickey
-rw-rw-r-- 1 ansible ansible    0 Aug  4 09:32 sakhi.txt
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-resolved.service-TAdXmN
drwx------ 3 root    root    4096 Aug  4 06:18 systemd-private-534c3c84e00c47aa87e9d1cf738ef894-systemd-timesyncd.service-Nw1pcq
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:27 vish.txt
-rw-rw-r-- 1 ansible ansible    0 Aug  4 07:28 vish1.txt
ansible@ip-172-31-33-14:~$

8. Install software on remote server.

ansible@ip-172-31-33-14:~$ ansible dev -m apt -a "name=git state=present" --become
172.31.36.13 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "cache_update_time": 1591904237,
    "cache_updated": false,
    "changed": false
}

9. Verify software installed on remote server.

ansible@ip-172-31-33-14:~$ ansible dev -m shell -a "git --version"
172.31.36.13 | CHANGED | rc=0 >>
git version 2.17.1


