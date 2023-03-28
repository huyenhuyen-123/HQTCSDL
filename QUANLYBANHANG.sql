use master
Create database QLBHANG
use QLBHANG

Create table Sanpham
(
masp nchar(10) primary key,
mahangsx nchar(10) not null,
tensp nvarchar(20) not null,
soluong int not null,
mausac nvarchar(20) not null,
giaban money not null,
donvitinh nchar(10) not null,
mota nvarchar(max) not null
)

Create table Hangsx
(
Mahangsx nchar(10) primary key,
Tenhang nvarchar(20) not null,
Diachi nvarchar(30) not null,
Sodt nvarchar(20) not null,
email nvarchar(30) not null,
)

Create table Nhanvien
(
Manv nchar(10) primary key,
Tennv nvarchar(20) not null,
Gioitinh nchar(10) not null,
Diachi nvarchar(30) not null,
Sodt nvarchar(20) not null,
email nvarchar(30) not null,
Phong nvarchar(30) not null,
)


Create table Nhap
(
Sohdn nchar(10) primary key,
Masp nchar(10) not null,
Manv nchar(10) not null,
Ngaynhap date not null,
soluongN int not null,
dongiaN money not null,
)

Create table Xuat
(
Sohdx nchar(10) not null,
Masp nchar(10) not null,
Manv nchar(10) not null,
Ngayxuat date not null,
soluongX int not null,
CONSTRAINT pk_Xuat primary key(Sohdx,Manv)
)

Alter table Sanpham
Add
constraint fk_1 foreign key(mahangsx) references Hangsx(mahangsx)
on delete cascade
on update cascade
Alter table Nhap
Add
constraint fk_2 foreign key(masp) references Sanpham(masp)
on delete cascade
on update cascade
Alter table Nhap
Add
constraint fk_3 foreign key(manv) references Nhanvien(manv)
on delete cascade
on update cascade
Alter table Xuat
Add
constraint fk_4 foreign key(masp) references Sanpham(masp)
on delete cascade
on update cascade
Alter table Xuat
Add
constraint fk_5 foreign key(manv) references Nhanvien(manv)
on delete cascade
on update cascade

INSERT INTO Hangsx
VALUES 
('H01',N'Samsung',N'Korea','011-08271717',N'ss@gmail.com.kr'),
('H02',N'OPPO',N'China','081-08626262',N'oppo@gmail.com.cn'),
('H03',N'Vindore',N'Việt Nam','084-098262626',N'vf@gmail.com.vn');
INSERT INTO Nhanvien VALUES
('NV01',N'Nguyễn Thị Thu',N'Nữ',N'Hà Nội', '0982626521',N'thu@gmail.com',N'Kế toán'),
('NV02',N'Lê Văn Nam',N'Nam',N'Bắc Ninh', '0972525252',N'nam@gmail.com',N'Vật tư'),
('NV03',N'Trần Hòa Bình',N'Nữ',N'Hà Nội', '0328388388',N'hb@gmail.com',N'Kế toán');
INSERT INTO Sanpham VALUES
('SP01', 'H02',N'F1 Plus', '100',N'Xám', '7000000',N'Chiếc',N'Hàng cận cao cấp'),
('SP02', 'H01',N'Galaxy Note11', '50',N'Đỏ', '19000000',N'Chiếc',N'Hàng cao cấp'),
('SP03', 'H02',N'F3 Lite', '200',N'Nâu', '3000000',N'Chiếc',N'Hàng phổ thông'),
('SP04', 'H03',N'Vjoy3', '200',N'Xám', '1500000',N'Chiếc',N'Hàng phổ thông'),
('SP05', 'H01',N'Galaxy', '50',N'Nâu', '8000000',N'Chiếc',N'Hàng cận cao cấp');
INSERT INTO Nhap VALUES
('N01', 'SP02', 'NV01', '02-05-2019', 10, 17000000),
('N02', 'SP01','NV02','04-07-2020',30,6000000),
('N03', 'SP04','NV02','05-17-2020',20,1200000),
('N04', 'SP01','NV03','03-22-2020',10,6200000),
('N05', 'SP05','NV01','07-07-2020',20,7000000);
INSERT INTO Xuat VALUES
('X01', 'SP03', 'NV02', '06-14-2020', 5),
('X02', 'SP01', 'NV03', '03-05-2019', 3),
('X03', 'SP02', 'NV01', '12-12-2020', 1),
('X04', 'SP03', 'NV02', '06-02-2020', 2),
('X05', 'SP05', 'NV01', '05-18-2020', 1);

