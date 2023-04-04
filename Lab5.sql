create function cau_1(@tensp nvarchar(10))
returns nvarchar(20)
as
begin
declare @ten nvarchar(20)
set @ten= (select tenhang from hangsx join sanpham on hangsx.mahangsx=sanpham.mahangsx where @tensp=masp)
return @ten
end
go
print dbo.cau_1('SP02')

-- cau 2--
create function cau_2(@x int, @y int)
returns int
as
begin
declare @tong int
select @tong= sum(nhap.soluongN*nhap.dongiaN)
from nhap
where year(ngaynhap) between @x and @y
return @tong
end
go
print dbo.cau_2(2018,2020)