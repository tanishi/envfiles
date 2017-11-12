FROM alpine:edge
MAINTAINER tanishi

RUN apk --update --no-cache add \
    git \
    neovim \
    python3 \
    sudo \
    tmux \
    zsh \
