FROM ubuntu:20.04

# Ignore all interactive dialog during apt-get update
ENV DEBIAN_FRONTEND noninteractive

# Install linux package
RUN apt-get update && apt-get upgrade -y; \
    apt-get install -y \
    build-essential libssl-dev libffi-dev \
    python3-dev python3-pip \
    sudo vim git openssh-server curl \
    htop iotop screen reptyr libsndfile1;

# Add all user into sudoers
RUN echo '%staff   ALL=(ALL:ALL) ALL' >> /etc/sudoers;

# Python package install
COPY obspy/requirements.txt /tmp/
RUN python3 -m pip install --upgrade pip; \
    python3 -m pip --no-cache-dir install --upgrade --requirement /tmp/requirements.txt;

# SSH login fix. Otherwise user is kicked off after login
RUN mkdir /var/run/sshd; \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd;

# Hide server profile form docker container, only which written into '/etc/profile' will be seen
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile;

# Clear login message for sftp login
RUN cp /etc/skel/.bashrc /etc/bash.bashrc;

# Start ssh service
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]