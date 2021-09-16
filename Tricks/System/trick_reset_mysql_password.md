https://support.rackspace.com/how-to/mysql-resetting-a-lost-mysql-root-password/


    sudo /etc/init.d/mysql stop
    sudo /etc/init.d/mysqld stop
    sudo mysqld_safe --skip-grant-tables &
    mysql -uroot

    use mysql;

    update user set password=PASSWORD("mynewpassword") where User='root';
    #ou
    update user set authentication_string=password('1111') where user='root';

    flush privileges;

    quit
