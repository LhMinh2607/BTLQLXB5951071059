use BusManager

--0 Lấy ra HTX và số xe của nó
SELECT *
FROM HTX, BUS
WHERE HTX.MaHTX=BUS.MaHTX

--  Xuat ra danh sach cac  htx 
select*
from HTX
-- Xuất ra NV có lương>5tr và giới tính là nữ
select *
from STAFF
WHERE Luong>9000000 and GioiTinh=N'Nữ'

 --  Liet ke cac xe buyt ma co ghe qua ten tram dung la dai hoc giao thong van tai 
select MaTuyen, TenTuyen 
from bus
where matuyen in(
	select matuyen
	from cross_station
	where matramdung in(
	select matramdung 
	from station
	where Tentramdung=N'Đại Học GTVT'))


-- Xuat ra nhung xe buyt co ten htx la quyet thang 
select MaTuyen, TenTuyen
from bus
where MaHTX in (
	select mahtx
	from htx
	where TenHTX LIKE N'%Quyết Thắng')

-- Xuat ra cac loai  luong khong trung nhau 
select distinct luong
from staff

-- Xuat ra nhung nhan vien thuoc xe 141 va 8
select MaNV,HoTen
from staff
where MaTuyen=N'141' OR MaTuyen=N'08'

--  xuat nhung nhan vien co ho la nguyen
select  manv,HoTen
from staff
where HoTen LIKE N'Nguyễn%'