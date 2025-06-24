FROM jenkins/jenkins:lts

USER root

# Instalar Terraform y dependencias necesarias
RUN apt-get update && \
    apt-get install -y curl unzip gnupg software-properties-common python3-pip python3-venv && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    python3 -m venv /opt/checkov-env && \
    /opt/checkov-env/bin/pip install --upgrade pip && \
    /opt/checkov-env/bin/pip install checkov && \
    ln -s /opt/checkov-env/bin/checkov /usr/local/bin/checkov && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jenkins


