FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y curl unzip gnupg software-properties-common python3-pip && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y terraform && \
    pip3 install --break-system-packages pipx && \
    pipx ensurepath && \
    pipx install checkov && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

USER jenkins


