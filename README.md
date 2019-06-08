## Description

Just a simple MariaDB Docker container I made for myself.

## Usage
Clone the repository and change to the repository folder.  
Build the Docker image.  
```
sudo docker build -t mariadb .
```
Decide where you want to store the MariaDB related files and create folders for the configuration, databases and logs and create your MariaDB configuration file named `mariadb-server.cnf` in your configuration folder.  
Start the container for initalization.
```
sudo docker run -d --name mariadb --mount src='path_to_configuration_folder',target=/etc/my.cnf.d,type=bind --mount src='path_to_log_folder',target=/var/log/mariadb,type=bind --mount src='path_to_database_folder',target=/var/lib/mysql,type=bind mariadb mysql_install_db
```
Start the container again for database configuration.
```
sudo docker run -it --name mariadb --user root --mount src='path_to_configuration_folder',target=/etc/my.cnf.d,type=bind --mount src='path_to_log_folder',target=/var/log/mariadb,type=bind --mount src='path_to_database_folder',target=/var/lib/mysql,type=bind mariadb mysql_secure_installation
```
Exit the container and run it normally.
```
sudo docker run -d --name mariadb --mount src='path_to_configuration_folder',target=/etc/my.cnf.d,type=bind --mount src='path_to_log_folder',target=/var/log/mariadb,type=bind --mount src='path_to_database_folder',target=/var/lib/mysql,type=bind -p 3306:host_port mariadb
```
The container is now running but you might need to access the database root user for further database configuration. E.g. adding users to connect to the database remotely.
```
sudo docker exec -it --user root mariadb /bin/bash
```
