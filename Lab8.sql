use master
go
Create login huyen_huyen
	With password=N'123456',
	check_expiration=off,
	check_policy=off
go

use QLQA
go
create user huyen_huyen
	for login huyen_huyen
go

use QLBHANG
go
--1. Viết thủ tục thêm mới nhân viên bao gồm các tham số: manv, tennv, gioitinh, diachi, sodt, email, phong và 1 biển Flag, Nếu Flag=0 thì nhập mới, ngược lại thì cập nhật thông tin nhân viên theo mã. 
--Hãy kiểm tra:- gioitinh nhập vào có phải là Nam hoặc Nữ không, nếu không trả về mã lỗi 1. - Ngược lại nếu thỏa mãn thì cho phép nhập và trả về mã lỗi 0..
CREATE PROCEDURE sp_ThemMoiNhanVien
    @manv nchar(10),
    @tennv nvarchar(20),
    @gioitinh nchar(10),
    @diachi nvarchar(30),
    @sodt nvarchar(20),
    @email nvarchar(30),
    @phong nvarchar(30),
    @Flag int
AS
BEGIN
    SET NOCOUNT ON;
    IF (@gioitinh <> N'Nam' AND @gioitinh <> N'Nữ')
    BEGIN
        SELECT 1 AS 'Lỗi' 
        RETURN
    END
    IF (@Flag = 0)
    BEGIN
        INSERT INTO Nhanvien (Manv, Tennv, Gioitinh, Diachi, Sodt, Email, Phong)
        VALUES (@manv, @tennv, @gioitinh, @diachi, @sodt, @email, @phong)

        SELECT 0 AS 'Lỗi'
        RETURN
    END
    ELSE 
    BEGIN
        UPDATE Nhanvien
        SET Tennv = @tennv,
            Gioitinh = @gioitinh,
            Diachi = @diachi,
            Sodt = @sodt,
            Email = @email,
            Phong = @phong
        WHERE Manv = @manv
        IF (@@ROWCOUNT > 0)
        BEGIN
            SELECT 0 AS 'Lỗi' 
            RETURN
        END
        ELSE
        BEGIN
            SELECT 2 AS 'Lỗi' 
            RETURN
        END
    END
END
--Lệnh thực thi
EXEC sp_ThemMoiNhanVien 'NV001', N'Nguyễn Văn A', N'Nam', N'TPHCM', N'0987654321', N'nguyenvana@gmail.com', N'Phòng kế toán',0

--2. Viết thủ tục thêm mới sản phẩm với các tham biến masp, tenhang, tensp, soluong, mausac, giaban, donvitinh, mota và 1 biến Flag. Nếu Flag=0 thì thêm mới sản phẩm, ngược lại cập nhật sản phẩm. 
--Hãy kiểm tra:- Nếu tenhang không có trong bảng hangsx thì trả về mã lỗi 1 - Nếu soluong <0 thì trả về mã lỗi 2 - Ngược lại trả về mã lỗi 0.
CREATE PROCEDURE sp_ThemMoiSanPham
    @masp nchar(10),
    @tenhang nvarchar(20),
    @tensp nvarchar(20),
    @soluong int,
    @mausac nvarchar(20),
    @giaban money,
    @donvitinh nchar(10),
    @mota nvarchar(max),
    @Flag bit
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @mahangsx nchar(10)
    SELECT @mahangsx = Mahangsx FROM Hangsx WHERE Tenhang = @tenhang
    IF @mahangsx IS NULL
    BEGIN
        SELECT 1 AS Lỗi
        RETURN
    END

    IF @soluong < 0
    BEGIN
        SELECT 2 AS Lỗi
        RETURN
    END

    IF @Flag = 0
    BEGIN
        INSERT INTO Sanpham (masp, mahangsx, tensp, soluong, mausac, giaban, donvitinh, mota)
        VALUES (@masp, @mahangsx, @tensp, @soluong, @mausac, @giaban, @donvitinh, @mota)
    END
    ELSE
    BEGIN
        UPDATE Sanpham
        SET mahangsx = @mahangsx,
            tensp = @tensp,
            soluong = @soluong,
            mausac = @mausac,
            giaban = @giaban,
            donvitinh = @donvitinh,
            mota = @mota
        WHERE masp = @masp
    END
    SELECT 0 AS Lỗi
END
--Lệnh thực thi
EXECUTE sp_ThemMoiSanPham ('SP06',N'Galaxyy', '50',N'Nâu', '8000000',N'Chiếc',N'Hàng cận cao cấp',0);
--3. Viết thủ tục xóa dữ liệu bảng nhanvien với tham biến là many. Nếu many chưa có thì trả về 1, ngược lại xóa nhanvien với nhanvien bị xóa là many và trả về 0. (Lưu ý: xóa nhanvien thì phải xóa các bảng Nhạp, Xuat mà nhân viên này tham gia). 
CREATE PROCEDURE usp_XoaNhanVien
    @manv nchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE Manv = @manv)
    BEGIN
        RETURN 1; 
    END

    DELETE FROM Nhap WHERE Manv = @manv;
    DELETE FROM Xuat WHERE Manv = @manv;


    DELETE FROM Nhanvien WHERE Manv = @manv;

    RETURN 0; 
END;
--Lệnh thực thi
EXEC usp_XoaNhanVien 'NV001';
--4. Viết thủ tục xóa dữ liệu bảng sanpham với tham biến là masp. Nếu masp chưa có thì trả về 1, ngược lại xóa sanpham với sanpham bị xóa là masp và trả về 0. (Lưu ý: xóa sanpham thì phải xóa các bảng Nhap, Xuat mà sanpham này cung ứng). 
CREATE PROCEDURE usp_XoaSanPham
    @masp nchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        RETURN 1; 
    END

    DELETE FROM Nhap WHERE Masp = @masp;
    DELETE FROM Xuat WHERE Masp = @masp;


    DELETE FROM Sanpham WHERE Masp = @masp;

    RETURN 0; 
END;
--Lệnh thực thi
EXEC usp_XoaSanPham'SP01';
--5. Tạo thủ tục nhập liệu cho bảng Hangsx, với các tham biến truyền vào mahangsx, tenhang, diachi, sodt, email. Hãy kiểm tra xem tenhang đã tồn tại trước đó hay chưa, nếu rồi trả về mã lỗi 1? Nếu có rồi thì không cho nhập và trả về mã lỗi 0.
CREATE PROCEDURE nl_Hangsx
@Mahangsx varchar(10),
@Tenhang nvarchar(20),
@Diachi nvarchar(30),
@Sodt nvarchar(20),
@email nvarchar(30)
AS BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT * FROM Hangsx WHERE Tenhang = @Tenhang)
    BEGIN
		PRINT'1'
        RETURN 
   END
	ELSE
	BEGIN
		PRINT'Không nhập mã lỗi 0'
	END
END
--Lệnh thực thi
EXEC nl_Hangsx 'HS001', 'Samsung', 'Địa chỉ 123', '0987654321', 'samsung@gmail.com'
--6. Viết thủ tục nhập dữ liệu cho bảng Nhap với các tham biến sohdn, masp, many, ngaynhap, soluongN, dongiaN. Kiểm tra xem masp có tồn tại trong bảng Sanpham hay không, nếu không trả về 1? many có tồn tại trong bảng nhanvien hay không nếu không trả về 2? ngược lại thì hãy kiểm tra: Nếu sohdn đã tồn tại thì cập nhật bảng Nhập theo sohdn, ngược lại thêm mới bảng Nhạp và trả về mã lỗi 0.
CREATE PROCEDURE nl_NhapHang
	@sohdn varchar(10),
	@masp varchar(10),
	@many varchar(10),
	@ngaynhap date,
	@soluongN int,
	@dongiaN money
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
	BEGIN
		PRINT 'Mã lỗi 1: Mã sản phẩm không tồn tại trong bảng Sanpham'
		RETURN 1
	END

	IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @many)
	BEGIN
		PRINT 'Mã lỗi 2: Mã nhân viên không tồn tại trong bảng Nhanvien'
		RETURN 2
	END
	
	IF EXISTS (SELECT * FROM Nhap WHERE sohdn = @sohdn)
	BEGIN
		UPDATE Nhap 
		SET masp = @masp, many = @many, ngaynhap = @ngaynhap, soluongN = @soluongN, dongiaN = @dongiaN
		WHERE sohdn = @sohdn
	END
	ELSE
	BEGIN
		INSERT INTO Nhap(sohdn, masp, many, ngaynhap, soluongN, dongiaN)
		VALUES(@sohdn, @masp, @many, @ngaynhap, @soluongN, @dongiaN)
	END
	
	PRINT 'Mã lỗi 0: Thêm/Cập nhật dữ liệu thành công'
	RETURN 0
END
--Lệnh thực thi
EXEC nl_NhapHang 'HD001', 'SP001', 'NV001', '2023-04-18', 10, 5000.0;
--7. Viết thủ tục nhập dữ liệu cho bảng xuat với các tham biến sohdx, masp, many, ngayxuat, soluongX. Kiểm tra xem masp có tồn tại trong bảng Sanpham hay không nếu không trả về 1? many có tồn tại trong bảng nhanvien hay không nếu không trả về 2? soluongX<= Soluong nếu không trả về 3? ngược lại thì hãy kiểm tra: Nếu sohdx đã tồn tại thì cập nhật bảng Xuất theo sohdx, ngược lại thêm mới bảng Xuat và trả về mã lỗi 0
CREATE PROCEDURE nl_Xuat
    @sohdx varchar(10),
    @masp varchar(10),
    @many varchar(10),
    @ngayxuat date,
    @soluongX int
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        PRINT '1' 
        RETURN
    END
    
    IF NOT EXISTS (SELECT * FROM nhanvien WHERE many = @many)
    BEGIN
        PRINT '2' 
        RETURN
    END

    DECLARE @soluongton int
    SELECT @soluongton = soluong FROM Sanpham WHERE masp = @masp
    IF @soluongX > @soluongton
    BEGIN
        PRINT '3' 
        RETURN
    END
  
    IF EXISTS (SELECT * FROM Xuat WHERE sohdx = @sohdx)
    BEGIN
     
        UPDATE Xuat SET masp = @masp, many = @many, ngayxuat = @ngayxuat, soluongX = @soluongX WHERE sohdx = @sohdx
    END
    ELSE
    BEGIN

        INSERT INTO Xuat(sohdx, masp, many, ngayxuat, soluongX) VALUES (@sohdx, @masp, @many, @ngayxuat, @soluongX)
    END
    
    PRINT '0' 
END
--Lệnh thực thi
EXEC nl_Xuat 'HDX001', 'SP001', 'NV001', '2023-04-18', 10
