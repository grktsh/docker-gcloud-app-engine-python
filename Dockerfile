FROM python:2.7-alpine

ENV PYTHONUNBUFFERED 1

ENV GOOGLE_CLOUD_SDK_VERSION 155.0.0
ENV GOOGLE_CLOUD_SDK_SHA256SUM 4b64fba9d98b9e48cc7a37ed3b321e50f92e87f9c2b358d183f966dae05216a2

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

ENV PATH /google-cloud-sdk/bin:$PATH
