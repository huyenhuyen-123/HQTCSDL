create view view1 as
SELECT TOP(10) tenSP, giaBan
FROM SanPham
ORDER BY giaBan DESC;

create view view2 as
select Tensp from Sanpham,Hangsx
where Sanpham.mahangsx = Hangsx.Mahangsx
AND tenhang='Samsung'

create view view3 as
select*from Nhanvien where (Gioitinh='Nữ') AND (Phong='Kế toán');

create view view4 as
select sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong,tenhang
from nhap, sanpham, nhanvien, Hangsx
where year(ngaynhap)= 2017 and Hangsx.tenhang='Samsung'

create view view5 as
SELECT TOP 1 Sohdn, Ngaynhap, DongiaN
FROM Nhap
ORDER BY DongiaN DESC

create view view6 as
SELECT TOP 10 Sanpham.Tensp, SUM(Nhap.SoluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp 
WHERE YEAR(Nhap.Ngaynhap) = 2019 
GROUP BY Sanpham.Tensp 
ORDER BY TongSoLuongN DESC

create view view7 as
SELECT Sanpham.Masp, Sanpham.Tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.Mahangsx = Hangsx.Mahangsx
INNER JOIN Nhap ON Sanpham.Masp = Nhap.Masp
INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
WHERE Hangsx.Tenhang = 'Samsung' AND Nhanvien.Manv = 'NV01';

create view view8 as
SELECT Sohdn, Masp, SoluongN, Ngaynhap
FROM Nhap
WHERE Masp = 'SP02' AND Manv = 'NV02'

create view view9 as
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.Manv = Xuat.Manv
WHERE Xuat.Masp = 'SP02' AND Xuat.Ngayxuat = '2020-03-02'

create view view10 as
select*from Nhanvien;

create view view11 as
SELECT SUM(SoluongN * DongiaN) AS TongTien
FROM Nhap
JOIN Sanpham ON Nhap.Masp=Sanpham.Masp
JOIN Hangsx ON Sanpham.Mahangsx=Hangsx.Mahangsx
WHERE Hangsx.Tenhang= 'Samsung' AND YEAR(Ngaynhap) = 2018

create view view12 as
select Masp, sum(soluongN*dongiaN) AS 'Tổng tiền Nhập' from Nhap
where year(Ngaynhap)=2018
group by Masp

create view view13 as
select Masp, count(*)AS 'Tổng số lượng' from Nhap , Hangsx
where year(Ngaynhap)=2018 and Hangsx.tenhang='Samsung'
group by Masp
having sum(soluongN*dongiaN)>10000 

create view view14 as
select Gioitinh, count(*)AS 'Tổng số lượng'from Nhanvien group by Gioitinh
having (Gioitinh = 'Nam')

create view view15 as
select soluongN, sum(soluongN)AS'Tổng số lượng nhập'from Nhap 
where year(Ngaynhap)=2018
group by soluongN