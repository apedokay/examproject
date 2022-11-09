#!/usr/bin/bash

# add postgresql package repository
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

sudo apt update

#install postgresql
sudo apt install postgresql postgresql-client -y

sudo systemctl start postgresql.service

#connect postgress to remote server

postgressAccess=/etc/postgresql/15/main/pg_hba.conf
postgressConfig=/etc/postgresql/15/main/postgresql.conf

# edit the PostgreSQL access policy configuration file
echo $'listen_addresses = \'*\' '  >>  $postgressAccess

echo "host all all 0.0.0.0/0 md5" >>  $postgressConfig

systemctl restart postgresql

sudo ufw allow 5432/tcp

