# How to access OpenContrail OpenStack Helm Cluster?


Once OpenStack & OpenContrail Helm cluster provisioning is completed please follow below steps to access OpenStack & Contrail WebUI and prepare openstack client for CLI

### Export OS_CLOUD environment variable and test openstack client commands
  ```bash
  export OS_CLOUD=openstack_helm
  openstack server list
  openstack stack list
  openstack --help
  ```

### Accessing Contrail WebUI

Contrail WebUI is accessible via port 8143 (secure) and 8180 (insecure).

##### Contrail WebUI is authenticated using keystone, you should be able to access contrail webui using keystone credentials. By default keystone credentials are configured as `admin/password` and they are available in `keystone/values.yaml`

### Accessing OpenStack Horizon

Openstack Horizon is exposed via k8s service using node port. Default NodePort used for horizon service is 31000.
You can check NodePort used for horizon service via following command. In below output port 31000 is used and you can access GUI using following URL.

* Openstack GUI username/password: admin/password

```Text
1. kubectl get svc -n openstack | grep horizon-int
horizon-int           NodePort    10.99.150.28     <none>        80:31000/TCP         4d

2. http://<Node-IP>:31000/auth/login/?next=/
```

### Acessing Virtual Machine Console via Horizon

* To access VM console you have to add nova novncproxy FQDN in "/etc/hosts" file. Please add host-ip where "osh-ingress" POD is running. In below example ingree pod is running on host with IP 10.13.82.233. Here are instructions for updating "/etc/hosts entries for MAC-OS.

```bash
# Sample /etc/hosts
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
10.13.82.233 nova-novncproxy.openstack.svc.cluster.local
```

Tip: If you don't want to make changes in "/etc/hosts" you can replace "nova-novncproxy.openstack.svc.cluster.local" part in URL with the IP address of your compute node.

### Refernces:

* https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html
* https://docs.openstack.org/openstack-helm/latest/install/ext-dns-fqdn.html
