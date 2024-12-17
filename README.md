# Makarov Airport InfraOps

Bienvenue dans le projet MAKAROV-AIRPORT ! Ce projet utilise Docker, Vagrant, et plusieurs scripts pour configurer et déployer une application web complexe.

## 🛠️ Prérequis 
Docker  
Vagrant  
VirtualBox  
Homebrew (pour macOS)
## 💻 Installation 
Pour les utilisateurs Mac/Linux
La dernière version de VirtualBox pour Mac/Linux peut causer des problèmes.

Créez/éditez le fichier `/etc/vbox/networks.conf` et ajoutez ce qui suit pour éviter tout problème lié au réseau :

<pre>* 0.0.0.0/0 ::/0</pre>
ou exécutez les commandes ci-dessous :
<pre>sudo mkdir -p /etc/vbox/
echo "* 0.0.0.0/0 ::/0" | sudo tee -a /etc/vbox/networks.conf</pre>

Cela permet aux réseaux uniquement hôtes d'être dans n'importe quelle plage, et pas seulement `192.168.56.0/21` comme décrit ici sur la [doc](https://discuss.hashicorp.com/t/vagrant-2-2-18-osx-11-6-cannot-create-private-network/30984/23).

## 🚀 Lancement du projet 
Pour démarrer le projet, exécutez le script `start.sh` :
<pre>./start.sh</pre>

Une fois l'installation terminée, le site web sera disponible à l'adresse suivante : 
[http://<votre_ip>:8080/home/](http://<votre_ip>:8080/home/)

## 📁 Structure du projet 
`configs` : Contient les fichiers de configuration.  
`scripts` : Contient les scripts pour installer et gérer les services.  
`MAKAROV-AIRPORT`: Contient les fichiers Docker et les dumps SQL.  
`Playbooks` : Contient les playbooks Ansible.  
`Vagrantfile` : Fichier de configuration Vagrant.

## 🤝 Contribution 
Les contributions sont les bienvenues ! Veuillez soumettre une pull request ou ouvrir une issue pour toute suggestion ou amélioration.

## ✍️ Auteurs
- **Gabriel Garrone** - [Github](https://github.com/Gabrieleirbag1)
- **Mahé Fradin** - [Github](https://github.com/Wewenito)
- **Owen Pichot** - [Github](https://github.com/ROCKS-IT)
- **Pierre Bourger** - [Github](https://github.com/ROCKS-IT)

Merci d'utiliser MAKAROV-AIRPORT ! ✈️