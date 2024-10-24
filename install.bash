#!/bin/bash

# Vérifier le système d'exploitation
OS="$(uname -s)"

# Fonction pour l'installation sur Debian
install_on_debian() {
    echo "Installation sur Debian..."

    # Mettre à jour les paquets
    sudo apt-get update

    # Installer Docker
    echo "Installation de Docker..."
    sudo apt-get install -y docker.io

    # Installer Minikube
    echo "Installation de Minikube..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
        && chmod +x minikube \
        && sudo mv minikube /usr/local/bin/

    # Installer Kubernetes (kubectl)
    echo "Installation de kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    sudo apt-get update
    sudo apt-get install -y kubectl

    # Installation de helm

    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install prometheus prometheus-community/kube-prometheus-stack

    # Installer Vagrant
    echo "Installation de Vagrant..."
    sudo apt-get install -y vagrant

    # Installer Grafana
    echo "Installation de Grafana..."
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
    sudo apt-get install -y grafana

    echo "Toutes les installations sont terminées sur Debian."
}

# Fonction pour l'installation sur macOS
install_on_macos() {
    echo "Installation sur macOS..."

    # Vérifier si Homebrew est installé
    if ! command -v brew &> /dev/null; then
        echo "Homebrew n'est pas installé. Installation de Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Installer Docker
    echo "Installation de Docker..."
    brew install --cask docker

    # Installer Minikube
    echo "Installation de Minikube..."
    brew install minikube

    # Installer Kubernetes (kubectl)
    echo "Installation de kubectl..."
    brew install kubectl

    # Installer Vagrant
    echo "Installation de Vagrant..."
    brew install --cask vagrant

    # Installer Grafana
    echo "Installation de Grafana..."
    brew install grafana

    echo "Toutes les installations sont terminées sur macOS."
}

# Exécuter l'installation en fonction de l'OS détecté
if [ "$OS" == "Linux" ]; then
    . /etc/os-release
    if [ "$ID" == "debian" ]; then
        install_on_debian
    else
        echo "Ce script ne supporte actuellement que Debian. Votre système est $ID."
        exit 1
    fi
elif [ "$OS" == "Darwin" ]; then
    install_on_macos
else
    echo "Système d'exploitation non supporté : $OS"
    exit 1
fi
