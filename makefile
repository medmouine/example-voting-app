HOST = medmouine/
RESULT_IMAGE = catsvsdogs-result
VOTE_IMAGE = catsvsdogs-vote
WORKER_IMAGE = catsvsdogs-worker

all: build-images push-images

.PHONY: build-images
build-images:
	sudo docker build -t $(HOST)$(RESULT_IMAGE) ./result && \
  sudo docker build -t $(HOST)$(VOTE_IMAGE) ./vote && \
  sudo docker build -t $(HOST)$(WORKER_IMAGE) ./worker

.PHONY: push-images
push-images:
	sudo docker push $(HOST)$(RESULT_IMAGE) && \
  sudo docker push $(HOST)$(VOTE_IMAGE) && \
  sudo docker push $(HOST)$(WORKER_IMAGE)

.PHONY: persist-images
persist-images: 
	echo "Persisting images" && \
  sudo rm -r /caches && \
  sudo mkdir -p /caches && \
  sudo docker save -o /caches/${RESULT_IMAGE}.tar $(HOST)$(RESULT_IMAGE) && \
  sudo docker save -o /caches/${VOTE_IMAGE}.tar $(HOST)$(VOTE_IMAGE) && \
  sudo docker save -o /caches/${WORKER_IMAGE}.tar $(HOST)$(WORKER_IMAGE)

.PHONY: load-cached-images
load-cached-images: 
	echo "loading images" && \
  docker load -i /caches/${RESULT_IMAGE}.tar | true && \
  docker load -i /caches/${VOTE_IMAGE}.tar | true && \
  docker load -i /caches/${WORKER_IMAGE}.tar | true

