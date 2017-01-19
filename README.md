## Fluentd DaemonSet

Dependencies for the Fluentd DaemonSet for Kubernetes logging. The docker image for this repo is located at: quay.io/samsung_cnct/fluentd_daemonset. Currently this component reads Docker logs from var/log/containers, filters Kubernetes metadata and writes to a zookeeper/Kafka component.

## Bootstrap
```
kubectl create -f fluentd-daemonset.yaml
```

## Plugins

#### Kubernetes Metadata Filter

This filter adds the following data into the body of the log.
* namespace
* pod id
* pod name
* labels
* host
* container name
* docker container id

For more information on the filter or to see a list of configuration options: https://github.com/fabric8io/fluent-plugin-kubernetes_metadata_filter

#### Named Logfile Filter for non-standard logfile collection

This filter will add the filename and filepath to the event metadata.
Requires setup of shared-logging-directory: https://github.com/samsung-cnct/shared-logging-directory
