create database Assesment05Db
use Assesment05Db

create schema bank
create table bank.Customer
(
	CId int primary key identity(1000,1),
	CName nvarchar(50) not null,
	CEmail nvarchar(50) not null unique,
	Contact nvarchar(50) not null unique,
	CPwd as right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2) persisted 
)
insert into bank.Customer(CName,CEmail,Contact) values ('Sam','sam@gmail.com','8767876549')
insert into bank.Customer(CName,CEmail,Contact) values ('Ravi','ravi@gmail.com','9876543210')
insert into bank.Customer(CName,CEmail,Contact) values ('Rajesh','rajesh@gmail.com','8794563210')
insert into bank.Customer(CName,CEmail,Contact) values ('Amith','amith@gmail.com','9786541230')
insert into bank.Customer(CName,CEmail,Contact) values ('Rohit','rohit@gmail.com','7896541230')

select * from bank.Customer
----------------------------------------------------------------------
create table bank.MailInfo
(	
	MailTo nvarchar(50),
	MailDate date,
	MailMessage nvarchar(50)
)
---------------------------------------------------------------------
create trigger InsertIntoCust
on bank.Customer
after insert
as
begin
declare @id int
declare @name nvarchar(50)
declare @mail nvarchar(50)
declare @contact nvarchar(50)
declare @pwd nvarchar(50)

declare @msg nvarchar(50)

select @id=Cid,@name=CName,@mail=CEmail,@contact=Contact,@pwd=(right(CName,2)+cast(CId as nvarchar(10))+left(Contact,2)) from inserted
select @msg='you NetBanking password is : '+@pwd+'it is valid up to 2 days only. Update it!!!!!!!'

insert into MailInfo values (@mail,GETDATE(),@msg)

if(@@ROWCOUNT>=1)
begin
print 'After trigger value inserted'
end
end

insert into bank.Customer(CName,CEmail,Contact) values ('Ram','ram@gmail.com','9875683210')
select * from bank.Customer
select * from bank.MailInfo