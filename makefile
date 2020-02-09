RESULT_IMAGE = "medmouine/catsvsdogs-result"
VOTE_IMAGE = "medmouine/catsvsdogs-vote"
WORKER_IMAGE = "medmouine/catsvsdogs-worker"

all: build-images push-images

.PHONY: build-images
build-images:
	sudo docker build -t $(RESULT_IMAGE) ./result && \
  sudo docker build -t $(VOTE_IMAGE) ./vote && \
  sudo docker build -t $(WORKER_IMAGE) ./worker

.PHONY: push-images
push-images:
	sudo docker push $(RESULT_IMAGE) && \
  sudo docker push $(VOTE_IMAGE) && \
  sudo docker push $(WORKER_IMAGE)


