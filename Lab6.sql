
---cau1
CREATE FUNCTION fn_LayThongTinSanPhamTheoHang(@tenhang NVARCHAR(20))
RETURNS TABLE
AS
RETURN
(
    SELECT sp.masp, sp.tensp, sp.soluong, sp.mausac, sp.giaban, sp.donvitinh, sp.mota, hsx.tenhang
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    WHERE hsx.tenhang = @tenhang
)
--kt
SELECT * FROM fn_LayThongTinSanPhamTheoHang('Samsung')
---cau2
CREATE FUNCTION fn_DanhSachSanPhamTheoNgayNhap(@ngayx NVARCHAR(10), @ngayy NVARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT sp.tensp, hsx.tenhang, n.soluongN, n.dongiaN
    FROM Sanpham sp
    INNER JOIN Hangsx hsx ON sp.mahangsx = hsx.mahangsx
    INNER JOIN Nhap n ON sp.masp = n.masp
    WHERE n.ngaynhap BETWEEN @ngayx AND @ngayy
)
kt
SELECT * FROM fn_DanhSachSanPhamTheoNgayNhap('2019-03-05', '2020-06-18')
---cau3
CREATE FUNCTION fn_GetProductByManufacturer(@manufacturer NVARCHAR(50), @option INT)
RETURNS TABLE
AS
RETURN
    SELECT sp.masp, sp.tensp, sp.soluong
    FROM Sanpham sp
    INNER JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE hs.tenhang = @manufacturer AND (@option = 0 AND sp.soluong = 0 OR @option = 1 AND sp.soluong > 0)
--kt
SELECT *FROM fn_GetProductByManufacturer('Samsung', 1)
--cau4
CREATE FUNCTION fn_DanhSachNhanVienTheoPhong(@tenPhong NVARCHAR(50))
RETURNS TABLE
AS
RETURN 
(
    SELECT * FROM Nhanvien
    WHERE phong = @tenPhong
)
--kt
SELECT * FROM fn_DanhSachNhanVienTheoPhong('Kế toán')
--cau5
CREATE FUNCTION dbo.fn_DanhSachHangSXTheoDiaChi
    (@dia_chi NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT mahangsx,Tenhang,Diachi
    FROM Hangsx
    WHERE Diachi LIKE '%' + @dia_chi + '%';
--kt
SELECT*FROM fn_DanhSachHangSXTheoDiaChi (N'KOREA')
--cau6
CREATE FUNCTION DANH_SACH_SAN_PHAM_XUAT_TRONG_KHOANG_THOI_GIAN(@nam_x INT, @nam_y INT)
RETURNS TABLE
AS
RETURN
SELECT SANPHAM.masp, SANPHAM.tensp,HANGSX.Tenhang, Xuat.Ngayxuat
FROM Sanpham
JOIN HANGSX ON SANPHAM.mahangsx = HANGSX.Mahangsx
JOIN Xuat SANPHAM.Masx = HANGSX.Masx
WHERE YEAR(Xuat.NgayXuat)
BETWEEN @nam_x AND @nam_y
GO
--kt
SELECT * FROM DANH_SACH_SAN_PHAM_XUAT_TRONG_KHOANG_THOI_GIAN(N'2019', N'2021')
--cau7
CREATE FUNCTION DANHSACHSANPHAM1 (@MAHANGSX NCHAR(10), @LUACHON INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT SP.MASP, SP.TENSP, SP.MAUSAC, SP.GIABAN, SP.DONVITINH,
        CASE 
            WHEN @LUACHON = 0 THEN BN.NGAYNHAP
            WHEN @LUACHON = 1 THEN BX.NGAYXUAT
        END AS 'NGAYNHAPXUAT'
    FROM SANPHAM SP
    LEFT JOIN BANGNHAP BN ON SP.MASP = BN.MASP
    LEFT JOIN BANGXUAT BX ON SP.MASP = BX.MASP
    WHERE SP.MAHANGSX = @MAHANGSX AND (@LUACHON = 0 OR @LUACHON = 1)
)
--kt
select * from DANHSACHSANPHAM1(N'H01',1)
--cau8
CREATE FUNCTION danhsachnhanvien1(@date DATE)
RETURNS TABLE
AS
RETURN (
    SELECT NHANVIEN.MANV, NHANVIEN.TENNV, BANGNHAP.SOLUONGN, BANGNHAP.DONGIAN, BANGNHAP.NGAYNHAP
    FROM NHANVIEN
    JOIN BANGNHAP ON NHANVIEN.MANV = BANGNHAP.MANV
    WHERE BANGNHAP.NGAYNHAP = @date
)
--kt
select * from danhsachnhanvien1('2019-02-05')
--cau9
CREATE FUNCTION danhsachsanpham2
(
    @min_price MONEY,
    @max_price MONEY,
    @company_name NVARCHAR(20)
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        SANPHAM.MASP, 
        SANPHAM.TENSP, 
        SANPHAM.GIABAN
    FROM 
        SANPHAM
        INNER JOIN HANGSX ON SANPHAM.MAHANGSX = HANGSX.MAHANGSX
    WHERE 
        HANGSX.TENHANG = @company_name 
        AND SANPHAM.GIABAN BETWEEN @min_price AND @max_price
);
SELECT *
FROM danhsachsanpham2('8000000', '19000000', N'SAMSUNG');
--cau10
CREATE FUNCTION danhsachcacsanphamvahangsanxuat()
RETURNS TABLE
AS
RETURN (
  SELECT SANPHAM.TENSP, HANGSX.TENHANG
  FROM SANPHAM
  JOIN HANGSX ON SANPHAM.MAHANGSX = HANGSX.MAHANGSX
)
--kt
SELECT * FROM danhsachcacsanphamvahangsanxuat()