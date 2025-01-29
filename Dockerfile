# syntax = docker/dockerfile:latest

FROM python:3.13.1-alpine3.21
ARG TARGETARCH

LABEL maintainer='f69m'

ENV LANG='en_US.UTF-8'                   \
    LANGUAGE='en_US.UTF-8'               \
    TERM='xterm'                         \
    TZ="Europe/London"

RUN <<EOF
    set -xe
    apk upgrade --update --no-cache

    apk add --no-cache -U   \
        bash                \
        bash-completion     \
        bash-doc            \
        ca-certificates     \
        curl                \
        findmnt             \
        fuse                \
        acl-libs            \
        libxxhash           \
        logrotate           \
        lz4-libs            \
        mariadb-client      \
        mariadb-connector-c \
        mongodb-tools       \
        openssl             \
        pkgconfig           \
        postgresql-client   \
        sqlite              \
        sshfs               \
        tzdata              \
        xxhash
    apk upgrade --no-cache
EOF

COPY --link requirements.txt /

RUN --mount=type=cache,id=pip,target=/root/.cache,sharing=locked \
    <<EOF
    set -xe
    python3 -m pip install -U pip
    python3 -m pip install -Ur requirements.txt
    borgmatic --bash-completion > "$(pkg-config --variable=completionsdir bash-completion)"/borgmatic
EOF

VOLUME /root/.local/state/borgmatic
VOLUME /root/.config/borg
VOLUME /root/.cache/borg

HEALTHCHECK --interval=30s --timeout=10s --start-period=20s --retries=3 CMD borgmatic config validate
