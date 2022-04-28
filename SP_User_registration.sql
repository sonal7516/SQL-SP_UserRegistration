use Stored_proc

alter table tbl_users drop column password

select * from tbl_users

 CREATE TABLE User_authentication
(A_Id int primary key identity(100,1),
Email varchar(100) unique,
Password varchar(50),
Tbl_UserId int foreign key references Tbl_Users(Tbl_UserId)
)

 CREATE TABLE User_Address
(Add_Id int primary key identity(200,1),
House_No int,
street varchar(100),
City varchar(100),
Pincode int,
Tbl_UserId int foreign key references Tbl_Users(Tbl_UserId)
)

select * from Tbl_Users
select * from User_authentication
select * from User_Address


Alter PROC User_Registration
@Fname varchar(100)=null,
@Lname varchar(100)=null,
@Email varchar(100)=null,
@Password varchar(50)=null,
@Mobile bigint=null,
@Gender varchar(20)=null,
@Isverified bit,
@House_no int=null,
@street varchar(100)=null,
@City varchar(100)=null,
@Pincode int=null
As
declare @UserId int;
declare @check int;
	BEGIN
	--here the check inserting data is dup or not--
		set @check=(select count(email) from Tbl_Users where Email=@Email);
		---email is unique  so we check dup by it---
		if @check=0
		----first insert in Tbl_users table
		begin
			insert into Tbl_Users
			(Fname,
			Lname,
			Email,
			Mobile,
			Gender,
			Isverified) 
			values(@Fname,
			@Lname,
			@Email,
			@Mobile,
			@Gender,
			@Isverified
			)
			set @UserId= SCOPE_IDENTITY()

			end

			else
			      begin
			       print'Email already exists'
			      end

           begin
--insert data in user_authentication table (foreign key: set @UserId= SCOPE_IDENTITY())--
		   insert into User_authentication
		    (Email,
			Password,
			Tbl_UserId) 
			values(@Email,
			@Password,
			@UserId)
			end
   --insert data in user_address table (foreign key: set @UserId= SCOPE_IDENTITY())--
   if @check=0
       begin
   			insert into User_Address
			(House_No,
			street,
			City,
			Pincode,
			Tbl_UserId) 
			values(@House_no,
			@street,
			@City,
			@PinCode,
			@UserId)
	    end
     else
	   begin
	 print'records are duplicate or invalid'
	   end
     End

User_Registration 'Amit','Singh','amit12@gmail.com','amit@123',76435132135,'Male',0,845,'galino.6','Noida',201301



  



			


