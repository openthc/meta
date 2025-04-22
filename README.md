# Metabase

A Reporting Tool

## Docker Install

### Prepare the PostgreSQL

```sql
CREATE USER openthc_meta WITH ENCRYPTED PASSWORD 'openthc_meta';
CREATE DATABASE openthc_meta with owner openthc_meta;
```

* See: https://metabase.com/docs/latest/operations-guide/configuring-application-database.html
* See: https://metabase.com/docs/latest/operations-guide/migrating-from-h2.html


## Development

To connect to a PostgreSQL that is running on the localhost, we have to do a trick.
First create a special IP address on the loopback device.
Then configure PostgreSQL to listen to that address and maybe update `/etc/hosts`
Adjust the firewall to allow traffic to it as needed

```shell
iptables -t filter -I INPUT 1 -s 172.0.0.0/8 -d 10.4.20.69/32 -j ACCEPT
```

Adjust the pg_hba to allow access from the docker images.

```
host    all    all    172.0.0.0/8    md5
```

- https://discourse.metabase.com/t/connect-to-my-local-postgres-database/90447
- https://discourse.metabase.com/t/cant-connect-to-my-local-postgres-database/29272


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

## Notes

### Database Connections

Some times it can leave connections open for a long time?

- https://github.com/metabase/metabase/issues/8679#issuecomment-783748133


### Password Reset

Get a current-ish timestamp.

```sql
UPDATE core_user SET reset_triggered = 1514706508, reset_token = 'AAA'  where id = 1;
```

Then go to https://YOURHOSTNAME/auth/reset_password/YOURTOKEN

- https://discourse.metabase.com/t/how-do-you-reset-a-users-password-without-an-email-service-configured-or-admin-access/395
- https://discourse.metabase.com/t/reset-password-admin/18530
- https://discourse.metabase.com/t/metabase-super-user-login-password/15042/4
- https://discourse.metabase.com/t/reset-admin-account-without-email/12821
