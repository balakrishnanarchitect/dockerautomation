FROM jenkins/inbound-agent:latest
## Docker installation steps:
User root
RUN apt-get -y install telnet
RUN apt-get update -y
RUN apt-get -y install unzip
RUN apt-get -y install mtr
RUN apt-get -y install sudo
RUN apt-get -y install \
     ca-certificates \
     curl \
        gnupg \
        lsb-release
RUN mkdir  /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian  \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get -y  install docker-ce docker-ce-cli containerd.io docker-compose-plugin
RUN adduser jenkins sudo
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN usermod -aG docker jenkins
USER jenkins
