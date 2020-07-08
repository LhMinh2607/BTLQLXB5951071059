use BusManager

--0 Lấy ra Số xe buýt và Tên HTX của nó
SELECT BUS.MaTuyen, HTX.TenHTX
FROM HTX, BUS
WHERE HTX.MaHTX=BUS.MaHTX

--  Xuat ra danh sach cac  htx 
select*
from HTX

-- Xuất ra NV có lương>5tr và giới tính là nữ
select *
from STAFF
WHERE Luong>9000000 and GioiTinh=N'Nữ'

 --  Liệt kê số xe buýt có ghé trạm dừng ĐH GTVT
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
select *
from bus
where MaHTX in (
	select mahtx
	from htx
	where TenHTX LIKE N'%Quyết Thắng')

-- Xuat ra cac loai  luong khong trung nhau 
select distinct Luong AS "Các mức lương của nhân viên xe buýt"
from staff

-- Xuat ra nhung nhan vien thuoc xe 141 va 8
select *
from staff
where MaTuyen=N'141' OR MaTuyen=N'08'

--  xuat nhung nhan vien co ho la nguyen
select  *
from staff
where HoTen LIKE N'Nguyễn%'

--Xuất ra doanh thu trong ngày theo từng xe
SELECT BUS.MaTuyen AS "Mã tuyến", (So_Ve_Ban_Ra_Trong_Ngay*DonGiaVe) AS "Doanh thu"
FROM BUS, STAFF, TICKET_PACK
WHERE BUS.MaTuyen=STAFF.MaTuyen AND TICKET_PACK.MaNV=STAFF.MaNV
ORDER BY "Mã tuyến"

--Xuất ra doanh thu trong ngày của xe số 141
SELECT SUM((So_Ve_Ban_Ra_Trong_Ngay*DonGiaVe)) AS "Doanh thu"
FROM BUS, STAFF, TICKET_PACK
WHERE BUS.MaTuyen=STAFF.MaTuyen AND TICKET_PACK.MaNV=STAFF.MaNV AND BUS.MaTuyen='141'

--Xuất ra số xe có tuyến bắt đầu lúc 5:00 sáng
SELECT MaTuyen
FROM BUS
WHERE KhoiHanh='5:00'

--Xuất ra thông tin tài xế lớn tuổi nhất
SELECT *
FROM STAFF
WHERE NgaySinh =(SELECT MIN(cast(NgaySinh as smalldatetime))
									FROM STAFF
									WHERE ChucVu=N'Tài xế')

--Xuất ra thông tin tài xế trẻ tuổi nhất
SELECT *
FROM STAFF
WHERE NgaySinh =(SELECT MAX(cast(NgaySinh as smalldatetime))
									FROM STAFF
									WHERE ChucVu=N'Tài xế')

--Xuất ra thông tin tiếp viên trẻ tuổi nhất
SELECT *
FROM STAFF
WHERE NgaySinh =(SELECT MAX(cast(NgaySinh as smalldatetime))
									FROM STAFF
									WHERE ChucVu=N'Tiếp viên')

--Xuất ra thông tin Tiếp viên lớn tuổi nhất
SELECT *
FROM STAFF
WHERE NgaySinh =(SELECT MIN(cast(NgaySinh as smalldatetime))
									FROM STAFF
									WHERE ChucVu=N'Tiếp viên')

--Xuất ra thông tin nhân viên lớn tuổi nhất
SELECT *
FROM STAFF
WHERE NgaySinh =(SELECT MIN(cast(NgaySinh as smalldatetime))
									FROM STAFF)

--Xuất ra thông tin nhân viên nhỏ tuổi nhất
SELECT *
FROM STAFF
WHERE NgaySinh =(SELECT MAX(cast(NgaySinh as smalldatetime))
									FROM STAFF)
--Xuất ra số xe có ít chuyến nhất
SELECT Distinct BUS.MaTuyen, TenTuyen, SoChuyen
FROM BUS, CROSS_STATION
WHERE BUS.MaTuyen=CROSS_STATION.MaTuyen AND SoChuyen = (SELECT MIN(SoChuyen)
														FROM BUS)

--Xuất ra số xe có nhiều chuyến nhất
SELECT Distinct MaTuyen, TenTuyen, SoChuyen
FROM BUS
WHERE SoChuyen = (SELECT MAX(SoChuyen)
				FROM BUS)