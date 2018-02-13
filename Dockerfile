FROM python:2.7-alpine

ENV PYTHONUNBUFFERED 1

ENV GOOGLE_CLOUD_SDK_VERSION 188.0.1
ENV GOOGLE_CLOUD_SDK_SHA256SUM 2966e8c21b4176037cc7f1916a170f2b6c7fcdb563cde25e26063986d2bdc047

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
