ansible@ip-172-31-33-14:~$ ansible-playbook site.yml

PLAY [slave2] ******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [172.31.47.201]

TASK [website : install apache2] ***********************************************
ok: [172.31.47.201]

TASK [configure website] *******************************************************
ok: [172.31.47.201]

TASK [website : starting apache2 services] *************************************
changed: [172.31.47.201]

PLAY RECAP *********************************************************************
172.31.47.201              : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


