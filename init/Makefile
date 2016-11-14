all: push

TAG = 0.1
PREFIX = quay.io/samsung_cnct/fluentd_daemonset

container:
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	docker rmi $(PREFIX):$(TAG)