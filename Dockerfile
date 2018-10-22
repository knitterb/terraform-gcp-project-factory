FROM hashicorp/terraform

ARG BUCKET
RUN echo $BUCKET
RUN echo ${BUCKET}

RUN apk update && \
    apk upgrade && \
    apk add git && \
    apk add bash
  
# Install the gcloud SDK
RUN apk add bash && \
    apk add curl && \
    apk add tar && \
    apk add which && \
    apk add python
RUN curl -sSL https://sdk.cloud.google.com > /tmp/gcl && bash /tmp/gcl --install-dir=~/gcloud --disable-prompts
ENV PATH $PATH:/root/gcloud/google-cloud-sdk/bin
RUN gcloud --version

WORKDIR /workspace

COPY *.tf ./
COPY credentials.json ./

RUN terraform init -backend=true -backend-config bucket=${BUCKET}

RUN ["terraform", "version"]
RUN ["terraform", "providers"]

ENTRYPOINT []
