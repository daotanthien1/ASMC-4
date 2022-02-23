Create database E_Commerce
Use E_Commerce
drop database  E_Commerce

Create table Products(
	productId int identity(1,1) primary key,
	productName nvarchar(50) not null,
	description nvarchar(150) not null,
	price float not null,
	quantity int  not null
);

Create table Categories(
	categoryId int identity(1,1) primary key,
	categoryName nvarchar(50)  not null
);

Create table Product_category(
	productId int not null,
	categoryId int not null,
	primary key(productId,categoryId),
	constraint FK1 foreign key (productId) references Products(productId),
	constraint FK2 foreign key (categoryId) references Categories(categoryId)
);

Create table Customers(
	customerId int identity(1,1)  primary key,
	email varchar(50) not null,
	password varchar(50) not null,
);

Create table Carts(
	cartId varchar(50) primary key,
	customerId int not null
	constraint FK3 foreign key (customerId) references Customers(customerId)
);

Create table Cart_item(
	cartId varchar(50) not null,
	productId int not null,
	price float not null,
	quantity int not null,
	primary key(cartId,productId),
	constraint FK4 foreign key (cartId) references Carts(cartId),
	constraint FK5 foreign key (productId) references Products(productId)
);

Create proc Sp_Login
@email varchar(100),
@password varchar(100)
As
Begin
Declare @Status int,@Parameter int
if exists(select * from Customers where email = @email and password = @password)
	set @Status = 1 
else
	set @Status = 0
select @Status
END

Create proc Sp_GetId
@email varchar(100),
@password varchar(100)
As
Begin
	Declare @Status int
if exists(select * from Customers where email = @email and password = @password and customerId = 1)
	set @Status = 1
else
	set @Status = 0
select @Status
End

Create proc Sp_GetPass
As
Begin
		Select email,password from Customers
End

