# Summary

Details about the individual charts can be found in the
[Helm Reference](../..charts/helm.md) section, but to summarize,
bringing up the entirety of R-CORD on a multi-node POD
(VOLTHA+ONOS+XOS) involves the following steps:

```shell
cd ~/cord/helm-charts
helm dep build voltha

helm install -n voltha-kafka \
--set replicas=1 \
--set persistence.enabled=false \
--set zookeeper.servers=1 \
--set zookeeper.persistence.enabled=false \
incubator/kafka

helm install -n voltha --set etc-operator.customResources.createEtcdClusterCRD=false voltha
helm upgrade voltha ./voltha

helm dep update xos-core
helm install -n xos-core xos-core

helm install -n onos-fabric -f configs/onos-fabric.yaml onos
helm install -n onos-voltha -f configs/onos-voltha.yaml onos

helm dep update xos-profiles/rcord-lite
helm install -n rcord-lite xos-profiles/rcord-lite

helm install -n cord-kafka incubator/kafka 
helm install -n hippie-oss xos-services/hippie-oss 
```

The last two charts (`cord-kafka` and `hippie-oss`) are not strictly 
required, but they are used in the "bottom up" subscriber provisioning 
workflow described in the [Operations Guide](configuration.md). And 
yes, there are currently two instantiations of Kafka: `kafka-voltha`
and `kafka-cord`.

> **Note:** It is probably a good idea to check the status of the deployed
> containers at each step using `kubectl get pod` rather than running
> the whole sequence of `helm install` commands back-to-back.
