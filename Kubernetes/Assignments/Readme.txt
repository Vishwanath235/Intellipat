Problem Statement:
A developer wants to the following task:
Use this github https://github.com/hshar94/helloworld
1. Create a 3 node setup of Kubernetes Master and Slave
2. Use the docker image which you created Docker 1 assignment
3. Deploy 2 pods with the same container but different index.html content, modify the
content from the above github to the following:
Pod 1: “Welcome to Pod 1”
Pod 2: “Welcome to Pod 2”
4. Each pod should have 2 replicas
5. Create the desired services for these pods
6. Setup path based routing on these services, which can be accessed from the outside
“/pod1” -> service 1
“/pod2” -> service 2


root@ip-172-31-41-247:~# kubectl create -f serv.yml
deployment.apps/pod1 created
service/pod1 created
deployment.apps/pod2 created
service/pod2 created

root@ip-172-31-41-247:~# kubectl create -f ingress2.yml
ingress.extensions/ing created


root@ip-172-31-41-247:~# kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
pod1-79c5c8d5dc-2vz5z     1/1     Running   0          60s
pod1-79c5c8d5dc-76wgw     1/1     Running   0          60s
pod2-768f464f75-j7rvz     1/1     Running   0          60s
pod2-768f464f75-xrch6     1/1     Running   0          60s

root@ip-172-31-41-247:~# kubectl exec -it pod1-79c5c8d5dc-2vz5z /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl kubectl exec [POD] -- [COMMAND] instead.

root@pod1-79c5c8d5dc-2vz5z:/# cd /usr/share/nginx/html/
root@pod1-79c5c8d5dc-2vz5z:/usr/share/nginx/html# ls
50x.html  index.html

root@pod1-79c5c8d5dc-2vz5z:~# cd /usr/share/nginx/html/
root@pod1-79c5c8d5dc-2vz5z:/usr/share/nginx/html# echo "Welcome to Pod 1" >index.html
root@pod1-79c5c8d5dc-2vz5z:/usr/share/nginx/html# cat index.html
Welcome to Pod 1

root@ip-172-31-41-247:~# kubectl exec -it pod1-79c5c8d5dc-76wgw /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl kubectl exec [POD] -- [COMMAND] instead.

root@pod1-79c5c8d5dc-76wgw:/usr/share/nginx/html# ls
50x.html  index.html
root@pod1-79c5c8d5dc-76wgw:/usr/share/nginx/html# echo "Welcome to Pod 1" > index.html
root@pod1-79c5c8d5dc-76wgw:/usr/share/nginx/html# exec attach failed: error on attach stdin: read escape sequence
command terminated with exit code 12
root@ip-172-31-41-247:~# kubectl exec -it pod2-768f464f75-j7rvz /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl kubectl exec [POD] -- [COMMAND] instead.
root@pod2-768f464f75-j7rvz:/# cd /usr/share/nginx/html/
root@pod2-768f464f75-j7rvz:/usr/share/nginx/html# echo "Welcome to Pod 2" > index.html
root@pod2-768f464f75-j7rvz:/usr/share/nginx/html# exec attach failed: error on attach stdin: read escape sequence
command terminated with exit code 126
root@ip-172-31-41-247:~# kubectl exec -it pod2-768f464f75-xrch6 /bin/bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl kubectl exec [POD] -- [COMMAND] instead.
root@pod2-768f464f75-xrch6:/# cd /usr/share/nginx/html/
root@pod2-768f464f75-xrch6:/usr/share/nginx/html# echo "Welcome to Pod 2" >index.html
root@pod2-768f464f75-xrch6:/usr/share/nginx/html# exec attach failed: error on attach stdin: read escape sequence
command terminated with exit code 126

