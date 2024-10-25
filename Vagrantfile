# Vagrantfile for Debian with Docker installed
Vagrant.configure("2") do |config|
  #============================= ANSIBLE VM SECTION (TEMPORARY) ==============================

  config.vm.define "vagrant_ansible" do |vagrant_ansible|
    vagrant_ansible.vm.box = "ubuntu/focal64"
    vagrant_ansible.vm.network "private_network", ip: "10.0.0.10"

    vagrant_ansible.vm.provider "virtualbox" do |vb_ansible|
      vb_ansible.name = "vagrant_ansible"
      vb_ansible.memory = "4096"
    end

    vagrant_ansible.vm.synced_folder "./fix_ssh_folder", "/home/vagrant/fix_ssh_folder"

    vagrant_ansible.vm.provision "shell", inline: <<-SHELL
      cd /home/vagrant/fix_ssh_folder
      sudo chmod +x sshfix.sh
      sudo bash sshfix.sh
    SHELL
  end

  #============================= DB VM SECTION ==============================

  config.vm.define "vagrantdb" do |vagrantdb|
    vagrantdb.vm.box = "ubuntu/focal64"
    vagrantdb.vm.network "private_network", ip: "10.0.0.20"

    #Set VM memory size (optional)
    vagrantdb.vm.provider "virtualbox" do |vb|
      vb.name = "vagrantdb"
      vb.memory = "8192"
    end

    #Folder used for the db with configs and all..
    vagrantdb.vm.synced_folder "./copy_to_vagrantdb", "/home/vagrant/copied_files"

    #Folder used for the fixssh script
    vagrantdb.vm.synced_folder "./fix_ssh_folder", "/home/vagrant/fix_ssh_folder"

    vagrantdb.vm.provision "shell", inline: <<-SHELL
      cd /home/vagrant/fix_ssh_folder
      #sudo chmod +x sshfix.sh
      sudo bash sshfix.sh
      
      cd /home/vagrant

      # Update and install dependencies
      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

      sudo apt-get install -y docker.io

      # Add vagrant user to the docker group
      sudo usermod -aG docker vagrant

      # Enable and start Docker
      sudo systemctl enable docker
      sudo systemctl start docker
      
      mkdir -p /var/lib/mysql_primary
      mkdir -p /var/lib/mysql_replica

      sudo chmod -R 777 /var/lib/mysql_primary
      sudo chmod -R 777 /var/lib/mysql_replica
      
      #Move to the correct location
      cd /home/vagrant/copied_files
      
      echo "\n\n====================BUILDING PRIMARY DB IMAGE..====================\n\n"

      #Build Primary-db image
      docker build -t mariadb-primary -f /home/vagrant/copied_files/dockerfiles/Dockerfile-Primary-db .

      echo "\n\n====================RUNNING PRIMARY DB CONTAINER...====================\n\n"

      #Run the Primary-db container
      docker run -d --restart unless-stopped \
      --name mariadb-primary \
      -p 3306:3306 \
      -v /var/lib/mysql_primary:/var/lib/mysql \
      mariadb-primary

      echo "\n\n====================PRIMARY-DB CONTAINER DETAILS====================\n\n"
      docker inspect mariadb-primary | grep IPAddress
      
      echo "\n\n====================GETTING PRIMARY DB LOG FILE NAME & POSITION...====================\n\n"
      sleep 20
      rm ./master-status.txt #Just in case it already exists.
      docker exec -i mariadb-primary bash -c "mariadb -u root -ptoto -e 'SHOW MASTER STATUS'" > ./master-status.txt

      # Extract log file and position from the master-status.txt
      LOG_FILE=$(awk '/mysql-bin/ {print $1}' ./master-status.txt)
      LOG_POS=$(awk '/mysql-bin/ {print $2}' ./master-status.txt)

      echo "Log file: $LOG_FILE"
      echo "Log position: $LOG_POS"

      echo "\n\n====================CREATING INIT SQL FILE FOR REPLICA...====================\n\n"

      # Dynamically create the init_replica.sql file
cat > ./confs/init_replica.sql <<EOF
STOP SLAVE;
CHANGE MASTER TO
    MASTER_HOST='172.17.0.2',
    MASTER_USER='replicator',
    MASTER_PASSWORD='toto',
    MASTER_PORT=3306,
    MASTER_CONNECT_RETRY=10,
    MASTER_LOG_FILE='$LOG_FILE',
    MASTER_LOG_POS=$LOG_POS;
START SLAVE;
EOF

      echo "\n\n====================BUILDING REPLICA DB IMAGE..====================\n\n"

      #Build Replica-db image
      docker build -t mariadb-replica -f /home/vagrant/copied_files/dockerfiles/Dockerfile-Replica-db .

      echo "\n\n====================RUNNING REPLICA DB CONTAINER...====================\n\n"

      #Run the Replica-db container
      docker run -d --restart unless-stopped \
      --name mariadb-replica \
      -v /var/lib/mysql_replica:/var/lib/mysql \
      -p 3307:3306 \
      mariadb-replica

      echo "\n\n====================REPLICA-DB CONTAINER DETAILS====================\n\n"
      docker inspect mariadb-replica | grep IPAddress

      echo "\n\n====================DOCKER PS RESULT====================\n\n"
      docker ps
    SHELL
  end
end
