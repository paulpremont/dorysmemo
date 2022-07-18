# MariaDB

## Install

    sudo apt install mariadb

## Quick database setup

```bash
mariadb -u root
CREATE DATABASE librebooking;
GRANT ALL PRIVILEGES ON librebooking.* TO 'lb_user'@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'lb_user'@localhost;
```
