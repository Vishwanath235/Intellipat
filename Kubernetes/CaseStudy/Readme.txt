You have just joined a startup Ventura Software as a Devops Lead Engineer. The company
relies on a Monolithic Architecture for its product. Recently, the senior management was hired.
The new CTO insists on having a Microservice Architecture. The Development Team, is
working on breaking the Monolith. Meanwhile, you have been asked to host a Test Application
on Kubernetes, to understand how it works.
Following things have to be implemented:
1. Deploy an Apache2 deployment of 2 replicas
2. Sample code has been checked-in at the following Git-Hub repo:
https://github.com/hshar/website.git.
You have to containerize this code, and push it to Docker Hub. Once done, deploy it on
Kubernetes with 2 replicas
3. Deploy Ingress with the following rules:
i) */apache* should point to the apache pods
ii) */custom* should point to the GitHub application


root@ip-172-31-41-247:~# kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
apache       ClusterIP   10.98.227.251   <none>        80/TCP    19m
git          ClusterIP   10.109.47.128   <none>        80/TCP    19m
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP   4h38m

root@ip-172-31-41-247:~# kubectl get deployment
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
apache   2/2     2            2           19m
git      2/2     2            2           19m


root@ip-172-31-41-247:~# kubectl get ing
NAME    CLASS    HOSTS   ADDRESS         PORTS   AGE
mying   <none>   *       172.31.47.227   80      19m


root@ip-172-31-41-247:~# kubectl get svc --all-namespaces
NAMESPACE       NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
default         apache                               ClusterIP   10.98.227.251    <none>        80/TCP                       19m
default         git                                  ClusterIP   10.109.47.128    <none>        80/TCP                       19m
default         kubernetes                           ClusterIP   10.96.0.1        <none>        443/TCP                      4h38m
ingress-nginx   ingress-nginx-controller             NodePort    10.101.222.153   <none>        80:30362/TCP,443:32010/TCP   3h12m
ingress-nginx   ingress-nginx-controller-admission   ClusterIP   10.97.252.81     <none>        443/TCP                      3h12m
kube-system     kube-dns                             ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP       4h38m




root@ip-172-31-41-247:~# kubectl create -f ser.yml
deployment.apps/git created
service/git created
deployment.apps/apache created
service/apache created
root@ip-172-31-41-247:~# kubectl create -f ingress1.yml
ingress.extensions/mying created
root@ip-172-31-41-247:~# kubectl get svc --all-namespaces
NAMESPACE       NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
default         apache                               ClusterIP   10.98.227.251    <none>        80/TCP                       55s
default         git                                  ClusterIP   10.109.47.128    <none>        80/TCP                       55s
default         kubernetes                           ClusterIP   10.96.0.1        <none>        443/TCP                      4h19m
ingress-nginx   ingress-nginx-controller             NodePort    10.101.222.153   <none>        80:30362/TCP,443:32010/TCP   173m
ingress-nginx   ingress-nginx-controller-admission   ClusterIP   10.97.252.81     <none>        443/TCP                      173m
kube-system     kube-dns                             ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP       4h19m

