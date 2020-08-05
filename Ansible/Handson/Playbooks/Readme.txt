Playbook

- hosts: slave1
  become: yes
  name: Installing apache2 on dev
  tasks:
    - name: Install apache2
      apt: name=apache2 state=latest

- hosts: slave2
  become: yes
  name: Installing nginx
  tasks:
    - name: installing nginx
      apt: name=nginx state=latest
    - name: Running a script
      script: script.sh

	  
ansible@ip-172-31-33-14:~$ ansible-playbook play.yml

PLAY [Installing apache2 on dev] ***********************************************

TASK [Gathering Facts] *********************************************************
ok: [172.31.36.13]

TASK [Install apache2] *********************************************************
changed: [172.31.36.13]

PLAY [Installing nginx] ********************************************************

TASK [Gathering Facts] *********************************************************
ok: [172.31.47.201]

TASK [installing nginx] ********************************************************
changed: [172.31.47.201]

TASK [Running a script] ********************************************************
changed: [172.31.47.201]

PLAY RECAP *********************************************************************
172.31.36.13               : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.31.47.201              : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
