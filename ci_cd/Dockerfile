FROM jenkins/jenkins:lts

USER root

# Instalar utilidades y dependencias
RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        zip \
        gnupg \
        lsb-release \
        software-properties-common \
        python3-pip \
        python3-venv \
        python3-dev \
        build-essential \
        git \
        nodejs \
        npm \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" && \
    unzip /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# Instalar Checkov en entorno virtual
RUN python3 -m venv /opt/checkov-env && \
    /opt/checkov-env/bin/pip install --upgrade pip && \
    /opt/checkov-env/bin/pip install checkov && \
    ln -s /opt/checkov-env/bin/checkov /usr/local/bin/checkov

# Crear entorno virtual para pruebas con pytest
RUN python3 -m venv /opt/pytest-env && \
    /opt/pytest-env/bin/pip install --upgrade pip && \
    /opt/pytest-env/bin/pip install pytest && \
    ln -s /opt/pytest-env/bin/pytest /usr/local/bin/pytest

# Configurar credenciales AWS
RUN mkdir -p /root/.aws && echo "\
[default]\n\
aws_access_key_id = AKIAYVRQNPNHBRFAGQPP\n\
aws_secret_access_key = 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\n\
region = us-east-1\n\
output = json\n\
" > /root/.aws/credentials

USER jenkins
