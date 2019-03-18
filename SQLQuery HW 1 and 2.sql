drop table if exists RoomStay;
drop table if exists RoomStatus;
drop table if exists Room;
drop table if exists GuestStatus;
drop table if exists GuestLinkClass;
drop table if exists Guest;
drop table if exists Class;
drop table if exists ClassType;
drop table if exists ServiceSale;
drop table if exists ServiceStatus;
drop table if exists Service;
drop table if exists Receipt;
drop table if exists Inventory;
drop table if exists Supply;
drop table if exists Tavern;
drop table if exists Location;
drop table if exists TavernUser;
drop table if exists Role;
go

create table Role (
	id int identity primary key,
	name varchar(50) not null,
	description varchar(200) not null
);

create table TavernUser (
	id int identity primary key,
	name varchar(50) not null,
	roleId int foreign key references Role(id)
);

create table Location (
	id int identity primary key,
	name varchar(100) not null,
);

create table Tavern (
	id int identity primary key,
	name varchar(50) not null,
	locationId int foreign key references Location(id),
	userId int foreign key references TavernUser(id),
	numFloors int not null
);

create table Supply (
	id int identity primary key,
	name varchar(50) not null,
	unit varchar(50)
);

create table Inventory (
	id int identity primary key,
	supplyId int foreign key references Supply(id),
	tavernId int foreign key references Tavern(id),
	updateDate date default(GETDATE()) not null,
	supplyCount int not null
);

create table Receipt (
	id int identity primary key,
	supplyId int foreign key references Supply(id),
	tavernId int foreign key references Tavern(id),
	cost money not null,
	amountReceived int not null,
	receiptDate date default(GETDATE()) not null
);

create table Service (
	id int identity primary key,
	name varchar(50) not null
);

create table ServiceStatus (
	id int identity primary key,
	name varchar(50) not null,
	serviceId int foreign key references Service(id)
);

create table ServiceSale (
	id int identity primary key,
	serviceId int foreign key references Service(id),
	guest varchar(50) not null,
	price money not null,
	purchaseDate date default(GETDATE()) not null,
	amountPurchased int not null,
	tavernId int foreign key references Tavern(id)
);

create table ClassType (
	id int identity primary key,
	name varchar(50) not null
);

create table Class (
	id int identity primary key,
	classTypeId int foreign key references ClassType(id),
	level int not null
);

create table Guest (
	id int identity primary key,
	name varchar(50) not null,
	notes varchar(200),
	birthday date not null,
	cakeday date,
	tavernId int
);
alter table Guest add foreign key (tavernId) references Tavern(id);

create table GuestLinkClass (
	guestId int foreign key references Guest(id),
	classId int foreign key references Class(id)
);

create table GuestStatus (
	id int identity,
	name varchar(50) not null,
	guestId int
);
alter table GuestStatus add primary key (id);
alter table GuestStatus add foreign key (guestId) references Guest(id);

create table Room (
	id int identity primary key,
	tavernId int foreign key references Tavern(id)
);

create table RoomStatus (
	id int identity primary key,
	name varchar(50) not null,
	roomId int foreign key references Room(id)
);

create table RoomStay (
	id int identity primary key,
	serviceSaleId int foreign key references ServiceSale(id),
	guestId int foreign key references Guest(id),
	roomId int foreign key references Room(id),
	dateStayedIn date default GETDATE(),
	dateCheckedOut date default GETDATE(),
	rate money not null
);
go

insert into Role values ('Blogger', 'Blogs about the tavern');
insert into Role values ('Manager', 'Supervises the tavern');
insert into Role values ('House Keeping', 'Cleans the tavern');
insert into Role values ('Entertainer', 'Entertains the guests');
insert into Role values ('Waiter', 'Serves the guest');
select * from Role;

insert into TavernUser values ('Rocky', 4);
insert into TavernUser values ('Apollo', 1);
insert into TavernUser values ('Adrian', 3);
insert into TavernUser values ('Paulie', 4);
insert into TavernUser values ('Tony Duke', 2);
select * from TavernUser;

insert into Location values ('New Jersey'), ('New York'), ('Texas'), ('California'), ('Philadelphi');
select * from Location;

insert into Tavern values ('Jersey Shore', 1, 5, 2);
insert into Tavern values ('City Life', 1, 5, 1);
insert into Tavern values ('Road House', 2, 3, 1);
insert into Tavern values ('Cali Dreams', 3, 2, 2);
insert into Tavern values ('Brotherly love', 4, 1, 3);
select * from Tavern;

insert into Supply values ('Milk', 'Gallons');
insert into Supply values ('Water', 'Gallons');
insert into Supply values ('Sugar', 'Pounds');
insert into Supply values ('Flour', 'Pounds');
insert into Supply values ('Eggs', NULL);
select * from Supply;



insert into Inventory values (1, 1, '2019-03-11', 5);
insert into Inventory values (2, 2, '2019-03-12', 4);
insert into Inventory values (3, 3, '2019-03-13', 3);
insert into Inventory values (4, 4, '2019-03-14', 2);
insert into Inventory values (5, 5, '2019-03-15', 1);
select * from Inventory;

insert into Receipt values (1, 1, 2.00, 5, '2019-03-16');
insert into Receipt values (2, 2, 4.00, 4, '2019-01-07');
insert into Receipt values (3, 3, 6.00, 3, '2019-01-08');
insert into Receipt values (4, 4, 8.00, 2, '2019-01-09');
insert into Receipt values (5, 5, 10.00, 1, '2019-01-10');
select * from Receipt;

insert into Service values ('Skying');
insert into Service values ('Night Life');
insert into Service values ('Painting');
insert into Service values ('Laundy');
insert into Service values ('House Keeping');
select * from Service;

insert into ServiceStatus values ('Active', 1);
insert into ServiceStatus values ('Inactive', 2);
insert into ServiceStatus values ('Active', 3);
insert into ServiceStatus values ('Active', 4);
insert into ServiceStatus values ('Active', 5);
select * from ServiceStatus;

insert into ServiceSale values (1, 'Carson', 8.00, '2019-03-10', 5, 1);
insert into ServiceSale values (2, 'Deshaun', 10.00, '2019-03-12', 4, 2);
insert into ServiceSale values (3, 'Westbrook', 19.00, '2019-03-13', 3, 3);
insert into ServiceSale values (4, 'Kobe', 49.00, '2019-03-15', 2, 4);
insert into ServiceSale values (5, 'Jordan', 51.00, '2019-03-16', 1, 5);
select * from ServiceSale;
--HOMEWORK 1 and 2
