sudo apt update
sudo apt install mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo mysql -e "CREATE DATABASE makarov_airport;"
sed -i 's/utf8mb4_uca1400_ai_ci/utf8mb4_general_ci/g' /vagrant/MAKAROV-AIRPORT/makarov_airport_dump.sql
sudo mysql -u root makarov_airport < /vagrant/MAKAROV-AIRPORT/makarov_airport_dump.sql