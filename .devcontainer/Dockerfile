FROM ubuntu:bionic

# Configure apt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
        && apt-get -y install --no-install-recommends apt-utils sudo 2>&1

# Install git, process tools, lsb-release (common in install instructions for CLIs)
RUN apt-get -y install git procps lsb-release \
        curl unzip gnupg \
        bash-completion

# Config user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh \
    && ./get_helm.sh

# Install Terragrunt
ENV TERRAGRUNT_VERSION=0.23.16
ENV TERRAGRUNT_TFPATH=/bin/terraform
RUN curl -sL https://github.com/gruntwork-io/terragrunt/releases/download/v$TERRAGRUNT_VERSION/terragrunt_linux_amd64 \
        -o /bin/terragrunt && chmod +x /bin/terragrunt

# Install Terraform
ENV TERRAFORM_VERSION=0.12.24
RUN curl -sL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
        unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
        rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install Gcloud, and Python Apis
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
        apt-get update -y && apt-get install google-cloud-sdk \
        python3-pip \
        python3-google-auth -y && \
        pip3 install --upgrade google-api-python-client

RUN pip3 install pre-commit

# Install kubectl
ENV KUBECTL_VERSION=v1.15.10
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
        chmod +x kubectl && \
        mv kubectl /usr/bin

# Install Kustomize
RUN curl -sLo kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.2.1/kustomize_kustomize.v3.2.1_linux_amd64 && \
        chmod +x kustomize && \
        mv kustomize /usr/bin

# Install create-token
RUN gsutil cp gs://cts-public-images-1-artifacts/create-token/create-token . && \
        chmod +x create-token && \
        mv create-token /usr/bin

# Install mukluk
ENV MUKLUK_VERSION=3.0.1
RUN gsutil cp gs://cts-public-images-1-artifacts/mukluk/mukluk_v${MUKLUK_VERSION} /usr/bin/mukluk && \
        chmod +x /usr/bin/mukluk

# Install yq
RUN curl -sLo yq https://github.com/mikefarah/yq/releases/download/3.2.1/yq_linux_amd64 && \
        chmod +x yq && \
        mv yq /usr/bin

# Install Docker
RUN apt-get update \
        #
        # Install Docker CE CLI and vim
        && apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common \
        && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
        && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" \
        && apt-get update \
        && apt-get install -y docker-ce-cli vim \
        #
        # Install Docker Compose
        && curl -sSL "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
        && chmod +x /usr/local/bin/docker-compose

# Install helpful tooling
RUN apt-get install -y keychain jq

# Clean up
RUN apt-get autoremove -y \
        && apt-get clean -y \
        && rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

# Set the default shell to bash instead of sh
ENV SHELL /bin/bash

# Copy any devcontainer bashrc setup and activate it
ADD .bashrc_devcontainer /home/$USERNAME/.bashrc_devcontainer
RUN echo "source ~/.bashrc_devcontainer" >> /home/$USERNAME/.bashrc

USER vscode