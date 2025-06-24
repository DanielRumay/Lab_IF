FROM jenkins/jenkins:lts

USER root

# Instalar herramientas necesarias y Terraform
RUN apt-get update && \
    apt-get install -y curl unzip gnupg software-properties-common python3-pip python3-pipx && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    pipx install checkov && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins


