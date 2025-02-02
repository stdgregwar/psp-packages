ARG BASE_DOCKER_IMAGE

FROM $BASE_DOCKER_IMAGE

ARG PACKAGES_REPO 

COPY . /src

RUN apk add build-base bash wget curl libarchive-dev gpgme-dev tree
RUN cd /src && ./install-latest.sh ${PACKAGES_REPO}

RUN cd /usr/local/pspdev && tree

# Second stage of Dockerfile
FROM alpine:latest

ENV PSPDEV /usr/local/pspdev
ENV PATH $PATH:${PSPDEV}/bin

COPY --from=0 ${PSPDEV} ${PSPDEV}