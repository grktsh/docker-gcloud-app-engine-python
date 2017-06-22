FROM python:2.7-alpine

ENV PYTHONUNBUFFERED 1

ENV GOOGLE_CLOUD_SDK_VERSION 160.0.0
ENV GOOGLE_CLOUD_SDK_SHA256SUM e799bfbc35ee75f2b7c2181a9e090be28e7a1a73b92953e9087b77bc7fc7a894

RUN set -ex \
 && apk add --no-cache --virtual .fetch-deps openssl \
 && wget -qO google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GOOGLE_CLOUD_SDK_VERSION-linux-x86_64.tar.gz \
 && apk del .fetch-deps \
 && echo "$GOOGLE_CLOUD_SDK_SHA256SUM  google-cloud-sdk.tar.gz" | sha256sum -c \
 && tar xf google-cloud-sdk.tar.gz \
 && rm -f google-cloud-sdk.tar.gz \
 && /google-cloud-sdk/install.sh \
    --usage-reporting false \
    --command-completion false \
    --path-update false \
    --additional-components app-engine-python

ENV GAE_SDK_PATH /google-cloud-sdk/platform/google_appengine
ENV GAE_SDK_ROOT /google-cloud-sdk/platform/google_appengine

ENV PATH /google-cloud-sdk/bin:$PATH

VOLUME ["/root/.config"]
