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
--1.Hiển thị thông tin các bảng dữ liệu trên
select*from Hangsx;
select*from Nhanvien;
select*from Sanpham;
select*from  Nhap;
select*from Xuat;
--2.Đưa ra thông tin masp, tensp, tenhang,soluong, mausac, giaban, donvitinh, mota của các sản phẩm theo chiều giảm dần
select*from Sanpham order by giaban DESC ;
--3.Đưa ra các sản phẩm có trong cửa hàng do cty SamSung sản xuất
select Tensp from Sanpham,Hangsx
where Sanpham.mahangsx = Hangsx.Mahangsx
AND tenhang='Samsung'
--4.Đưa ra thông tin các nhân viên nữ ở phòng kế toán
select*from Nhanvien where (Gioitinh='Nữ') AND (Phong='Kế toán');
--5. Đưa ra thông tin phiếu nhập gồm: sohdn, masp, tensp, tenhang, soluongN, dongiaN, tiennhap=soluongN*dongiaN, mausac, donvitinh, ngaynhap, tennv, phong. Sắp xếp theo chiều tăng dần của hóa đơn nhập.
SELECT Nhap.Sohdn, Sanpham.Masp, Sanpham.Tensp, Hangsx.Tenhang, Nhap.SoluongN, Nhap.DongiaN, Nhap.SoluongN*Nhap.DongiaN AS tiennhap, Sanpham.Mausac, Sanpham.Donvitinh, Nhap.Ngaynhap, Nhanvien.Tennv, Nhanvien.Phong
FROM Nhap
JOIN Sanpham ON Nhap.Masp = Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx= Hangsx.Mahangsx
JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
ORDER BY Nhap.Sohdn ASC;
--6. Đưa ra thông tin phiếu xuất gồm: sohdx, masp, tensp, tenhang, soluongX, giaban, tienxuatsoluongX*giaban, mausac, donvitinh, ngayxuat, tennv, phong trong tháng 10 năm 2018, sắp xếp theo chiều tăng dần của sohdx.
SELECT Xuat.SoHDX, Xuat.MaSP, SanPham.TenSP, HangSX.Tenhang, Xuat.SoLuongX,SanPham.GiaBan,Xuat.SoLuongX*SanPham.GiaBan AS TienXuat, SanPham.MauSac, SanPham.DonViTinh, Xuat.NgayXuat, NhanVien.TenNV, NhanVien.Phong
FROM Xuat
INNER JOIN SanPham ON Xuat.MaSP = SanPham.MaSP
INNER JOIN HangSX ON SanPham.MaHangSX = HangSX.MaHangSX
INNER JOIN NhanVien ON Xuat.MaNV = NhanVien.MaNV
ORDER BY Xuat.SoHDX ASC
--7. Đưa ra các thông tin về các hóa đơn mà hãng samsung đã nhập trong năm 2017, gồm: sohdn, masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong.
select sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong,tenhang
from nhap, sanpham, nhanvien, Hangsx
where year(ngaynhap)= 2017 and Hangsx.tenhang='Samsung'
--8. Đưa ra Top 10 hóa đơn xuất có số lượng xuất nhiều nhất trong năm 2018, sắp xếp theo chiều giảm dần của soluongX.

--9. Đưa ra thông tin 10 sản phẩm có giá bán cao nhất trong cửa hàng, theo chiều giảm dần giá bán.
SELECT TOP(10) tenSP, giaBan
FROM SanPham
ORDER BY giaBan DESC;
--10. Đưa ra các thông tin sản phẩm có gía bán từ 100.000 đến 500.000 của hãng samsung.
SELECT * FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
--11. Tính tổng tiền đã nhập trong năm 2018 của hãng samsung.
SELECT SUM(SoluongN * DongiaN) AS TongTien
FROM Nhap
JOIN Sanpham ON Nhap.Masp=Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
WHERE Hangsx.Tenhang= 'Samsung' AND YEAR(Ngaynhap) = 2018 
--12. Thống kê tổng tiền đã xuất trong ngày 2/9/2018
SELECT SUM(Xuat.SoluongX * Sanpham.Giaban) AS TongTien
FROM Xuat
INNER JOIN Sanpham ON Xuat.Masp = Sanpham.Masp
WHERE Xuat.Ngayxuat = '2018-09-02'
--13. Đưa ra sohdn, ngaynhap có tiền nhập phải trả cao nhất trong năm 2018
SELECT TOP 1 Sohdn, Ngaynhap, DongiaN
FROM Nhap
ORDER BY DongiaN DESC
--14. Đưa ra 10 mặt hàng có soluongN nhiều nhất trong năm 2019.
SELECT TOP 10 Sanpham.Tensp, SUM(Nhap.SoluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp 
WHERE YEAR(Nhap.Ngaynhap) = 2019 
GROUP BY Sanpham.Tensp 
ORDER BY TongSoLuongN DESC
--15. Đưa ra masp,tensp của các sản phẩm do công ty ‘Samsung’ sản xuất do nhân viên có mã ‘NV01’ nhập.
SELECT Sanpham.Masp, Sanpham.Tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp
INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND Nhanvien.Manv = 'NV01';
--16. Đưa ra sohdn,masp,soluongN,ngayN của mặt hàng có masp là ‘SP02’, được nhân viên ‘NV02′ xuất.
SELECT Sohdn, Masp, SoluongN, Ngaynhap
FROM Nhap
WHERE Masp = 'SP02' AND Manv = 'NV02'
--17. Đưa ra manv,tennv đã xuất mặt hàng có mã ‘SPO2′ ngày 03-02-2020.
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Xuat.Masp = 'SP02' AND Xuat.Ngayxuat = '2020-03-02'
