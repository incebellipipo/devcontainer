ARG DISTRO="latest"
FROM debian:${DISTRO}

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Install python, system tools, and some python dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && apt upgrade -yq && \
    apt install -yq \
        python3 \
        python3-pip \
        python3-venv \
        curl \
        git \
        sudo \
        bash-completion \
        locales && \
    apt autoclean

# Set up locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Create a user named 'developer' and assign sudo rules to it
RUN adduser --disabled-password --gecos '' developer ;\
    adduser developer sudo ;\
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set environment variables to seamlessly work with python
ENV PATH="${PATH}:/home/developer/.local/bin"

# Use the user 'developer' for the dev container
USER developer