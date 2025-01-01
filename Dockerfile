# Docker Best Practices
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices

FROM ubuntu:latest

ENV LANG=en_US.utf8

SHELL ["/bin/bash", "-eo", "pipefail", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  git \
  locales \
  software-properties-common \
  sudo \
  vim-nox \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && useradd -m dotfiles && echo "dotfiles:dotfiles" | chpasswd && usermod -aG sudo dotfiles && \
  newgrp sudo &&  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY dotfiles-entrypoint.sh /usr/local/bin/
WORKDIR /home/dotfiles
USER dotfiles
RUN rm ~/.bashrc \
  && bash <(curl -fsSL https://raw.githubusercontent.com/dansomething/dotfiles/master/install) \
  && ./.apt \
  && bash <(curl -s https://raw.githubusercontent.com/dansomething/dot_vim/master/install) \
  && nvim -es -u /home/dotfiles/.config/nvim/init.vim -i NONE -c "PlugInstall|qa" || exit 0

ENTRYPOINT ["dotfiles-entrypoint.sh"]
