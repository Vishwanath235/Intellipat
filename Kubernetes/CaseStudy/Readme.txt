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
