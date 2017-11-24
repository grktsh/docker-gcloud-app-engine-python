FROM python:2.7-alpine

ENV PYTHONUNBUFFERED 1

ENV GOOGLE_CLOUD_SDK_VERSION 180.0.1
ENV GOOGLE_CLOUD_SDK_SHA256SUM 7eb632fc2d932371b5a988da15b4ec591f3cb7343fdbcfba37053098a0884113

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

ENV GAE_SDK_ROOT /google-cloud-sdk/platform/google_appengine

ENV PATH /google-cloud-sdk/bin:$PATH

VOLUME ["/root/.config"]
