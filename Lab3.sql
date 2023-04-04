--1. Thống kê xem mỗi hãng sản xuất có bao nhiêu loại sản phẩm
select mahangsx, count(*)from Hangsx group by mahangsx
--2. Thống kê xem tổng tiền nhập của mỗi sản phẩm trong năm 2018
select Masp, sum(soluongN*dongiaN) AS 'Tổng tiền Nhập' from Nhap
where year(Ngaynhap)=2018
group by Masp
--3. Hãy thống kê các sản phẩm có tổng số lượng xuất năm 2018 là lớn hơn 10.000 sản phẩm của hãng samsung
select Masp, count(*)AS 'Tổng số lượng' from Nhap , Hangsx
where year(Ngaynhap)=2018 and Hangsx.tenhang='Samsung'
group by Masp
having sum(soluongN*dongiaN)>10000 
--4. Thống kê số lượng nhân viên Nam của mỗi phòng ban
select Gioitinh, count(*)AS 'Tổng số lượng'from Nhanvien group by Gioitinh
having (Gioitinh = 'Nam')
--5. Thống kê tổng số lượng nhập của mỗi hãng sản xuất năm 2018
select soluongN, sum(soluongN)AS'Tổng số lượng nhập'from Nhap 
where year(Ngaynhap)=2018
group by soluongN
--6. Hãy thống kê xem tổng lượng tiền xuất của mỗi nhân viên trong năm 2018 là bao nhiêu
select Sohdx, Nhanvien.Manv, soluongX
from Xuat
JOIN Nhanvien ON Xuat.Manv = Nhanvien.Manv
where YEAR(Ngayxuat) = 2018
group by Sohdx, Nhanvien.Manv, soluongX
--7. Hãy đưa ra tổng tiền nhập của mỗi nhân viên trong tháng 8-có tổng giá trị lớn hơn 100.000
select Sohdn, Nhanvien.Manv, soluongN, dongiaN, Ngaynhap, tiennhap=soluongN*dongiaN
from Nhap INNER JOIN Nhanvien ON Nhap.Manv = Nhanvien.Manv
where YEAR(Ngaynhap) = 2018 AND MONTH(Ngaynhap) = 8 AND dongiaN>100000
group by Sohdn, Nhanvien.Manv, soluongN, dongiaN, Ngaynhap
--8. ĐƯA RA DANH SÁCH CÁC SẢN PHẨM ĐÃ NHẬP NHỮNG CHƯA XUẤT BAO GIỜ
SELECT SP.Masp, SP.tensp
FROM SANPHAM SP
LEFT JOIN Nhap N ON SP.MASP = N.Masp
LEFT JOIN Xuat X ON SP.MASP = X.Masp
WHERE N.soluongN IS NOT NULL AND X.Masp IS NULL
GROUP BY SP.Masp, SP.tensp
--9.  ĐƯA RA DANH SÁCH CÁC SẨN PHẨM ĐÃ NHẬP NĂM 2018 VÀ XUẤT NĂM 2018
select Nhap.Masp, Ngaynhap, Ngayxuat, dongiaN
from Nhap INNER JOIN Xuat ON Nhap.Masp = Xuat.Masp
where YEAR(Ngaynhap) = 2018 AND YEAR(Ngayxuat) = 2018
--10. ĐƯA RA DANH SÁCH CÁC NHÂN VIÊN VỪA NHẬP VỪA XUẤT
select Manv, Tennv from Nhanvien
where EXISTS(select *from Nhap INNER JOIN Xuat ON Nhap.Manv = Xuat.Manv AND Nhap.Manv = Nhanvien.Manv)
--11.  ĐƯA RA DANH SÁCH CÁC NHÂN VIÊN KHÔNG THAM GIA VIỆC NHẬP XUẤT
select Manv, Tennv from Nhanvien
where NOT EXISTS(select *from Nhap INNER JOIN Xuat ON Nhap.Manv = Xuat.Manv AND Nhap.Manv = Nhanvien.Manv)