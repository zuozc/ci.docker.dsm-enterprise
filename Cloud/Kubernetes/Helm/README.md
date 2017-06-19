
This directory contains files to create a Helm chart for DSM.

1. Package files to chart:

    Helm package dsm
  
2. Install chart in  Kubernetes:

    Helm install --namespace <NAMSPACE> dsm-0.1.0.tgz
  
3. Then you can see release created and get release name:

    Helm ls
  
4. You can check service to get node port:

    kubectl describe svc <RELEASENAME-dsm>
  
5. After a while you can access DSM by http://<K8s-node-ip>:<Nodeport>
