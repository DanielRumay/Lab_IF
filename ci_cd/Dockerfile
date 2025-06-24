FROM jenkins/jenkins:lts

USER root

# Paso 1: Actualizar e instalar dependencias básicas
RUN apt-get update && \
    apt-get install -y curl unzip gnupg software-properties-common python3-pip || (echo "❌ Falló en apt-get install base packages" && exit 1)

# Paso 2: Añadir clave de HashiCorp
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg || (echo "❌ Falló al descargar clave GPG" && exit 1)

# Paso 3: Añadir repositorio de Terraform
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" > /etc/apt/sources.list.d/hashicorp.list

# Paso 4: Instalar Terraform
RUN apt-get update && \
    apt-get install -y terraform || (echo "❌ Falló al instalar Terraform" && exit 1)

# Paso 5: Instalar Checkov
RUN pip3 install --upgrade pip && \
    pip3 install checkov || (echo "❌ Falló al instalar Checkov" && exit 1)

USER jenkins

