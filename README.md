DATABASE: create database shopfashion; use shopfashion; create table
cloth(clothId int not null primary key auto_increment,clothTitle
varchar(50),clothDescription varchar(2000)); create table cart(cartId
int not null primary key auto_increment,productId int,userId int,size
varchar(50),quantity int,price int); create table user(userId int not
null primary key auto_increment,userName varchar(50),userEmail
varchar(50),userPassword varchar(50),userPhone varchar(50),userPic
varchar(50),userAddress varchar(2000),userType varchar(50)); create
table product(productId int not null primary key
auto_increment,productTitle varchar(1000),productDescription
varchar(2000),productPhoto varchar(50),productQuantity int,productFor
varchar(50),clothId int);

Comandos p/ admin: - Registrar - MYSQL Command: use shopfashion; select
\* from user; UPDATE user SET userType = \'admin\' WHERE userid =
(numero do usuario);

Server utilizado: apache-tomcat-9.0.34
