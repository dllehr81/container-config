From ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    jq \
    software-properties-common

RUN curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - && \
    curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu18.04/nvidia-docker.list | \
        tee /etc/apt/sources.list.d/nvidia-docker.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    nvidia-container-runtime

WORKDIR /work

COPY src/. .

RUN chmod +x /work/run.sh /work/toolkit.sh /work/docker.sh

RUN ln -s /work/run.sh nvidia-toolkit && \
	ln -s /work/toolkit.sh toolkit && \
	ln -s /work/crio.sh crio && \
	ln -s /work/docker.sh docker

ENV PATH=/work:$PATH

ENTRYPOINT ["nvidia-toolkit"]
