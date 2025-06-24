FROM jenkins/jenkins:lts

USER root

# Instalar herramientas necesarias
RUN apt-get update && \
    apt-get install -y curl unzip python3-pip gnupg lsb-release && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com debian main" > /etc/apt/sources.list.d/hashicorp.list \
    apt-get update && \
    apt-get install -y terraform && \
    pip3 install checkov && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins
