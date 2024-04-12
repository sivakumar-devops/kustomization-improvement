---
layout: post
title: Deploying Bold BI on Local cluster with kubectl and kustomization.
description: Learn how to deploy a Bold BI Application on Local cluster using Kustomization. This approach involves using Kubernetes Kustomize, a tool that allows you to customize Kubernetes resource configurations, to deploy Bold BI on Local cluster
platform: bold-bi
documentation: ug
---
# Deploy BoldBI in Local Cluster

To deploy Bold BI in Local Cluster, you need to have the following prerequisites:

**1. Install Local Cluster**
| Cluster Name  | Support Environment | Link |
| ------------- | ------------- | -----------|
| Rancher Desktop | Windows,Linux and MacOS| [Link](https://docs.rancherdesktop.io/getting-started/installation/)
| K0s Cluster | Windows,Linux and MacOS  | [Link](https://docs.k0sproject.io/v1.27.2+k0s.0/install/)
| Kind Cluster | Linux and MacOS  | [Link](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
|Kubeadm Cluster | Windows,Linux and MacOS | [Link](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)




**2. Database** 

Choose and set up a  [database](Local_Database.md) for Bold BI, such as Microsoft SQL Server 2012+, PostgreSQL, or MySQL. This database will store the application data.

**3. Load Balancer** 

Currently we have provided support for [`Nginx`](https://kubernetes.github.io/ingress-nginx/deploy/#azure) and [`Istio`](https://istio.io/latest/docs/setup/install/) as Load Balancers in Bold BI.

**4. Web Browser**

 Ensure you have a compatible web browser installed, such as Microsoft Edge, Mozilla Firefox, or Chrome, to access the Bold BI application once deployed.

# Bold BI on Local Cluster
1. Download the Kustomization.yaml file below for Bold BI deployment in Local Cluster <a href="https://raw.githubusercontent.com/sivakumar-devops/kustomization-improvement/mohamed/local/boldbi/kustomization.yaml" download="kustomization.yaml">Download YAML File</a>.
2. Create a Kubernetes cluster in Local machine to deploy Bold BI.
4. Create a Database.
5. Open the Kustomization.yaml file that was downloaded in Step 1. Replace the `mount path` noted in the steps above with `<Example/path/here>` respectively, in the file.
    ![Replace File storage name](images/path_before.png)
    ![After Replacing File Storage name](images/path_change.png)
7. After createing with your cluster, deploy the latest Nginx ingress controller to your cluster.
8. Run the following command to obtain the ingress IP address.
    ```bash 
    kubectl get service/ingress-nginx-controller -n ingress-nginx
9. After obtaining the External IP address, replace the app-base URL with your External IP address.
    ![App-Base-URL](images/app-base-url.png)
10. Navigate to the folder where the deployment file were downloaded from Step 1.
11. Run the following command to deploy Bold BI application on Local cluster
    ```bash
    kubectl apply -k .
12. If you encounter an issue such as "snippet annotation cannot be used because snippet directives are disabled by the Ingress administrator," then edit the config file and change "allow-snippet-annotation" to true.
    ![snippet error](images/snippet-error.png)
    ![snippet annotation](images/snippet-annotation.png)
    Use the Below command to Edit config Map file 
    ```bash
    kubectl edit cm ingress-nginx-controller -n ingress-nginx

13. Again apply the step 11. Please wait for some time until the Bold BI On-Premise application is deployed to your Local cluster.

14. Use the following command to get the pods status.
    ```bash 
    kubectl get pods -n bold-services

15. Wait until you see the applications running. Then, use the DNS or ingress IP address you obtained from Step 10 to access the application in the browser.

16. Configure the Bold BI On-Premise application startup to utilize the application. Please refer to the following [link](https://help.boldbi.com/embedded-bi/application-startup) for more details on configuring the application startup.
