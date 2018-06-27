# Kafka Chart

The `nem-kafka` helm chart is available at:
<https://github.com/kubernetes/charts/tree/master/incubator/kafka>

To install `nem-kafka` you can use:

```shell 
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator 
helm install -n nem-kafka incubator/kafka 
```

If you are experierencing problems with a multi instance installation of kafka,
you can try to install a single instance of it:

```shell 
helm install -n nem-kafka incubator/kafka -f examples/kafka-single.yaml 
```
