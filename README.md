# Metabase


## Use PostgreSQL

```
postgres@meta:~$ psql
psql (11.5 (Debian 11.5-1+deb10u1))
Type "help" for help.

postgres=# create user metabase;
CREATE ROLE
postgres=# create database metabase with owner metabase;
CREATE DATABASE
postgres=# alter user metabase with password '01DKM9K01DXPRGJY6A4VD6HPEW';
ALTER ROLE
postgres=# 
```

* See: https://metabase.com/docs/latest/operations-guide/configuring-application-database.html
* See: https://metabase.com/docs/latest/operations-guide/migrating-from-h2.html




## Building from Source


## Install NodeJS

    curl -sL https://deb.nodesource.com/setup_11.x | bash -
    apt-get install -y nodejs


## Install Yarn

    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
    apt-get update
    apt-get install yarn

## Install Lein

    wget 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'
    chmod 0755 ./lein
    export PATH="$PATH:$(readlink -f .)"


