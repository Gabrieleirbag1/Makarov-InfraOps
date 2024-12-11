vagrant up
vagrant ssh controlplane -c "cd /vagrant/scripts && ./start.sh"
sleep 120
vagrant ssh controlplane -c "cd /vagrant/scripts && ./install_helm.sh"