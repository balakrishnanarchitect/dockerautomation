FROM jenkins/inbound-agent:latest
## Docker installation steps:
User root
RUN apt-get update
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
## ASP .net application steps:
User root
RUN apt install -y wget
RUN apt install -y telnet
RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN sudo dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-7.0
RUN sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-7.0
RUN sudo apt-get install -y dotnet-runtime-7.0
## GCloud installation
RUN apt-get install apt-transport-https ca-certificates gnupg -y
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
RUN sudo apt-get update && sudo apt-get install google-cloud-cli -y

## Helm Installation
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod +x get_helm.sh
RUN ./get_helm.sh

## Java Installation
RUN sudo apt install default-jdk -y

## Maven Installation
RUN sudo apt install maven -y

## Terraform Installation
RUN apt-get install wget curl unzip software-properties-common gnupg2 -y

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -

RUN apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

RUN apt-get update -y

RUN apt-get install terraform -y

##Azure Cli installation
RUN apt-get install azure-cli -y 

## Kubectl installation
RUN apt-get install -y ca-certificates curl

RUN  curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

RUN apt-get install -y kubectl

