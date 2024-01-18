Deploying Wordpress App Over AWS Cloud

Prerequisites: • AWS cloud platform

• Ec2 instance (Uuntu)

• Networking (VPC, SG)

• Load Balancer

• Terraform

• MySQL database

• Apache web server

• Wordpress app

Creation of VPC and Ec2 instance using Terraform

• Install Terraform on your local machine

• Install AWS CLI to local machine

• Using this connect your local machine to your AWS account using command

 aws configure 
• Create a file called Provider.tf, vpc.tf, key.tf, ec2.tf, sg.tf. To create vpc networking in that we used private subnets and 2 public subnets which is in 2 availability zones, IGW gateway, NAT gateway, router and 2 ec2 machines ion which one is bastion server which is in public subnet and other one is app server which is in private subnet

• Initialize terraform in this folder using command

  terraform init
• To view the plan what we are creating in the aws cloud platform use

  terraform plan
• To apply all palns to execute use

  terraform apply
Creation of Load Balancer

• Create the Load Balancer in AWS cloud platform which is in the same vpc in which we are deploying the WordPress app • Select the create load balancer (ALB) named it as aws-app-deployment which is in the vpc where we want to deploy the app • Select scheme as internet facing • Select the public subnets is in which Load Balancer should be • Security group in which port 80 should be open for all, and I selected default security group. to apply those plans to execute in aws cloud platform • Create a target group which is instance typed, name it as aws-app-deploy-tg. • In this we selected the HTTP protocol on port 80 • Add the listener in which all signal in the app server instance goes to the load balancer • Click on the create the load balancer button.

Deploying the WordPress app

• Ssh to Bastion server to connect to the app server • After this we should add the private key inside this server and then we shh to the actual app server • Install all the dependencies which is required for WordPress app by using following command

  Sudo apt update
  Sudo apt install apache2 \
                   ghostscript \
                   libapache2-mod-php \
                   mysql-server \ 
                   php \
                   php-bcmath \
                   php-curl \
                   php-imagick \ 
                   php-intl \ 
                   php-json \
                   php-mbstring \
                   php-mysql \ 
                   php-xml \
                   php-zip
Installing the WordPress app by using the following command • Make the parent directory to import the WordPress dependencies

    sudo mkdir –p /srv/www
• Change the owner of that directory to www-data

    sudo chown www-data: /srv/www
• Use the curl command to get the WordPress app dependencies and untar this to src/www directory

     curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
• Configure the Apache web server by creating the file wordpress.conf by using the command

     sudo vim /etc/apache2/sites-available/wordpress.conf
• Insert these following lines

            <VirtualHost *:80>
       DocumentRoot /srv/www/wordpress
         <Directory /srv/www/wordpress>
        Options FollowSymLinks
     AllowOverride Limit Options FileInfo
     DirectoryIndex index.php
          Require all granted
              </Directory>
     <Directory /srv/www/wordpress/wp-content>
          Options FollowSymLinks
           Require all granted
     </Directory>
     </VirtualHost>
• Enable the wordpress site with the following command

   sudo a2ensite wordpress
• Enable URL rewriting with command

   sudo a22enmod rewrite
• Disable the default “It Works” site with

   sudo a2dissite 000-default
• Reload the apache server to change these settings

   sudo service apache2 reload
Configure database

To configure the wordpress, we have to create database by providing username, password, by using the foloowing command

       sudo mysql -u root
       mysql> ALTER USER ‘root’@localhost IDENTIFIED WITH mysql_native_password BY ‘<PASSWORD>’;
       mysql > CREATE USER ‘<USERNAME>’@localhost IDENTIFIED BY ‘<PASSWORD>’;
       mysql> CREATE DATABASE <DATABASENAME>;
       mysql> GRANT ALL PRIVILEDGES ON <DATABASENAME>. * TO ‘<USERNAME>’@localhost
       mysql> FLUSH PRIVILEGES;
Start the mysql service using command

 sudo service mysql start
Now click on the load balancer URL fill the necessary which was provided during installation like username, password, database name etc... after that wp-config.php file gets created in the directory /srv/www/wordpress. After this you will get the necessary login page of wordpress app...

             ********wordPress app deployment*********
