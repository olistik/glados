# GLADOS

A web application that collects pings/heartbeats from agents and notifies the presence of inactive agents.

It uses [Hanami](https://hanamirb.org), a Ruby based web framework, and the [Postgresql](https://www.postgresql.org) database to store:

- settings
- resources
- events

Notifies inactive agents through the [Telegram](https://telegram.org) platform, by sending text notifications to a private channel.

## Requirements

- Ruby 2.4.1p111
- Bundler
- Postgresql 9.4.13

## Setup

### Devuan

```bash
sudo apt-get install postgresql postgresql-contrib libpq-dev
sudo su postgres
psql
```

```sql
CREATE USER deployer with ENCRYPTED PASSWORD 'YOUR_PASSWORD_HERE';
CREATE DATABASE glados OWNER deployer;
GRANT ALL PRIVILEGES ON DATABASE glados TO deployer;
```

You can change the username from `deployer` to one that you like better.

Ensure that your `/etc/postgresql/9.4/main/pg_hba.conf` contains the `md5` authentication method. For example, for local connections:

```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             all                                     md5
```

```bash
psql -U deployer -W glados -f db/schema.sql
```

Tweak the values contained in the psql script, such as the api_key in the settings table.

Create a `.env` file according to the sample `.env.sample`.

Run the server:

```
bundle exec hanami server
```

Now you have to deploy the agents and configure them to send the heartbeats to GLADOS.

## Why?

Because I want to monitor the status of my devices and I want to try to build my own infrastructure.
It's basically for fun.

GLADOS is the name of the mad AI of the Portal game. It's a funny, yet evil, character.
GLADOS is the core element of the **Beholder** infrastructure.

##  License

This code is licensed under the AGPLv3 license.

See the LICENSE file for more details.

Developed with <3 by @olistik.
