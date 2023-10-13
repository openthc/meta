# Metabase

A Reporting Tool


## Use PostgreSQL

Just skip the H2 option, use PostgreSQL

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

### Migrating from H2 to PostgreSQL

* https://www.metabase.com/docs/latest/installation-and-operation/migrating-from-h2


## Building from Source

Building from source will require the latest versions of NodeJS and Yarn.

### Install NodeJS

```
curl -sL https://deb.nodesource.com/setup_11.x | bash -
apt-get install -y nodejs
```


### Install Yarn

```
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update
apt-get install yarn
```


### Install Lein

```
wget 'https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein'
chmod 0755 ./lein
export PATH="$PATH:$(readlink -f .)"
```

## Database Connections

Some times it can leave connections open for a long time?

- https://github.com/metabase/metabase/issues/8679#issuecomment-783748133


## Password Reset

http://discourse.metabase.com/t/how-do-you-reset-a-users-password-without-an-email-service-configured-or-admin-access/395/2

Get a current-ish timestamp.

```sql
UPDATE core_user SET reset_triggered = 1514706508, reset_token = 'AAA'  where id = 1;
```

Then go to https://YOURHOSTNAME/auth/reset_password/YOURTOKEN

