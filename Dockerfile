FROM python:2.7-alpine

ENV PYTHONUNBUFFERED 1

ENV GOOGLE_CLOUD_SDK_VERSION 161.0.0
ENV GOOGLE_CLOUD_SDK_SHA256SUM 7aa6094d1f9c87f4c2c4a6bdad6a1113aac5e72ea673e659d9acbb059dfd037e

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
