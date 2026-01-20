# Guacamole
[![](https://status.dontddos.me/api/badge/36/status)](https://status.dontddos.me) [![](https://status.dontddos.me/api/badge/36/uptime?duration=365&label=Uptime%20(365d))](https://status.dontddos.me)

- **Deployment date:** 20th January 2026

## Initialise DB
Do this BEFORE starting the stack
```bash
sudo mkdir -p /opt/containers/guacamole/init
cd /opt/containers/guacamole/init
sudo wget https://github.com/apache/guacamole-client/raw/1.6.0/extensions/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-postgresql/schema/001-create-schema.sql
sudo wget https://github.com/apache/guacamole-client/raw/1.6.0/extensions/guacamole-auth-jdbc/modules/guacamole-auth-jdbc-postgresql/schema/002-create-admin-user.sql
```