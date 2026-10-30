# PocketBase épinglé : version officielle stable v0.40.6
# Source : https://github.com/pocketbase/pocketbase/releases/tag/v0.40.6
# Empreinte SHA-256 de pocketbase_0.40.6_linux_amd64.zip vérifiée au build.
ARG PB_VERSION=0.40.6
ARG PB_SHA256=0e1f609158ed945f809f8a02ae012aa0427129c66ebb63c1aee76f2c0309373f

FROM alpine:3.20.3

ARG PB_VERSION
ARG PB_SHA256

RUN apk add --no-cache ca-certificates wget unzip tzdata su-exec \
    && addgroup -g 10001 -S pocketbase \
    && adduser -u 10001 -G pocketbase -S -H -h /pb pocketbase

WORKDIR /pb

RUN wget -q -O /tmp/pocketbase.zip \
        "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip" \
    && echo "${PB_SHA256}  /tmp/pocketbase.zip" | sha256sum -c - \
    && unzip -q /tmp/pocketbase.zip -d /pb \
    && rm -f /tmp/pocketbase.zip \
    && chmod 0755 /pb/pocketbase \
    && mkdir -p /pb_data /pb_migrations \
    && chown -R pocketbase:pocketbase /pb /pb_data

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh

EXPOSE 8090

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
    CMD wget -qO- http://127.0.0.1:8090/api/health >/dev/null 2>&1 || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["serve", "--dir=/pb_data", "--migrationsDir=/pb_migrations", "--http=0.0.0.0:8090", "--automigrate=0"]
