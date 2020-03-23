FROM jenkins/jenkins:lts

# switch to root user
USER root

# install Docker
# ref: https://medium.com/@gustavo.guss/jenkins-building-docker-image-and-sending-to-registry-64b84ea45ee9
# ref: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
RUN apt update && \
    apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt update && \
    apt install -y docker-ce
# add jenkins user to docker group
RUN usermod -aG docker jenkins

# instal CI/CD dependencies
RUN apt install -y \
    tidy \
    ansible \
    python-pip
RUN pip install \
    boto \
    pylint \
    pytest
RUN pip install pylint --upgrade
RUN wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 &&\
        chmod +x /bin/hadolint

# switch back to jenkins user
USER jenkins
