FROM ros:humble

# Install python, system tools, and some python dependencies
RUN apt update && apt upgrade -yq ;\
    apt install -yq \
        python3 \
        python3-pip \
        python3-venv \
        curl \
        git \
        sudo \
        ros-humble-ros-base \
        ros-dev-tools \
        locales ;\
    apt autoclean

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a user named 'developer' and assign sudo rules to it
RUN adduser --disabled-password --gecos '' developer ;\
    adduser developer sudo ;\
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set environment variables to seamlessly work with python
ENV PATH="${PATH}:/home/developer/.local/bin"

# Use the user 'developer' for the dev container
USER developer