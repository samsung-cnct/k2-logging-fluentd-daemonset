Dependencies for the Fluentd DaemonSet for Kubernetes logging. The docker image for this repo is located at: https://quay.io/leahnp/fluentd-daemon. Currently this component reads Docker logs from var/log/containers, filters Kubernetes metadata and writes to a zookeeper/Kafka component. 

The metadata filter adds the following data into the body of the log. 
-namespace
-pod id
-pod name
-labels
-host
-container name