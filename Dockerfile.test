FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    xz-utils \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash dima \
    && echo "dima ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER dima
ENV USER=dima
ENV HOME=/home/dima

WORKDIR /home/dima

RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

RUN mkdir -p ~/.config/nix \
    && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

COPY --chown=dima:dima . /home/dima/dotfiles

WORKDIR /home/dima/dotfiles

RUN . ~/.nix-profile/etc/profile.d/nix.sh \
    && nix build ".#homeConfigurations.\"dima@x86_64-linux\".activationPackage" \
    && ./result/activate

ENV PATH="/home/dima/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

CMD ["zsh", "-l"]
