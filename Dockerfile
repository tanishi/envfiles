FROM alpine:edge
MAINTAINER tanishi

RUN apk --no-cache add \
    git \
    neovim \
    python3 \
    sudo \
    tmux \
    zsh \

