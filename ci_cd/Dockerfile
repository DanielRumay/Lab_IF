FROM jenkins/jenkins:lts

USER root

# Instalar dependencias, Terraform, AWS CLI y Checkov
RUN apt-get update && \
    apt-get install -y curl unzip zip gnupg software-properties-common lsb-release python3-pip python3-venv && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    python3 -m venv /opt/checkov-env && \
    /opt/checkov-env/bin/pip install --upgrade pip && \
    /opt/checkov-env/bin/pip install checkov && \
    ln -s /opt/checkov-env/bin/checkov /usr/local/bin/checkov && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/aws /tmp/awscliv2.zip

USER jenkins

