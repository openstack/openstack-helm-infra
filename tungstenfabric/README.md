# Contrail Helm based deployment

This repo consists of contrail helm charts which helps to deploy contrail networking components as microservices

___

## Architecure of contrail helm charts

Contrail-helm-deployer is divided into below charts


1. contrail-thrirdparty: Helps to install contrail thirdparty components like cassandra, zookepper, kafka and redis needed by other contrail charts
2. contrail-controller: Using this chart we can install contrail services related to config, control and webui components
3. contrail-analytics: Helps to install contrail analytics services
4. contrail-vrouter: Installs contrail vrouter services

___

## Link for installation instructions
* [Contrail all in one with OSH](doc/contrail-osh-aio-install.md)
* [Contrail HA with OSH](doc/contrail-osh-multinode-install.md)

___

### [FAQ's](doc/faq.md)

___

## To-Do list

1. ~~Coming up with basic charts, adding Makefile and trying it with openstack-helm charts~~
2. ~~Having an option to deploy each container as a separate pod~~
3. ~~Separating out config-zookeeper and analytics-zookeeper~~
4. Exposing all ports used by each container in the container spec
5. Analyzing and adding resource limits for each of the contrail container
6. Adding lifecycle hooks to each of the container and making sure that we delete everything we create while deleting the container
7. Adding charts for DPDK vrouter
8. Support for SRIOV and SRIOV+DPDK coexistence using helm
9. Evaluating headless services for NB APIs and webui in contrail
10. Documentation for Contrail Helm charts in 5.0
  * ~~Installation doc~~
  * High level Architecture doc for 5.0 charts
  * Troubleshooting 5.0 helm charts docs
11. Adding RBAC objects for each of the pod
12. Adding contrail-kubernetes related components
13. Support for adding TSN node
14. Test adding single vrouter at a time
15. Test contrail HA
17. Support for provisioning hybrid cloud connect
