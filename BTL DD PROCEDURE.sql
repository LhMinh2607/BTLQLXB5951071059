USE BusManager
GO
--Procedure
--1. Xuất ra số xe buýt đi qua trạm được chỉ định
CREATE PROCEDURE sp_TramDung(@TramDung nvarchar(50))
AS
	BEGIN
		select MaTuyen, TenTuyen 
		from bus
		where matuyen in(
			select matuyen
			from cross_station
			where matramdung in(
				select matramdung 
				from station
				where Tentramdung=@TramDung))
	END

EXECUTE sp_TramDung N'Đại Học GTVT'

--2. Xuất ra tổng doanh thu từng nhân viên
CREATE PROCEDURE sp_DoanhThuNV
AS
	BEGIN
		SELECT STAFF.HoTen AS N'Tên nhân viên', SUM((SoVeBan*DonGiaVe)) AS N'Doanh thu trong ngày (đồng)'
		FROM STAFF, TICKET_PACK
		WHERE TICKET_PACK.MaNV=STAFF.MaNV
		GROUP BY STAFF.HoTen
		ORDER BY SUM((SoVeBan*DonGiaVe))
	END

EXECUTE sp_DoanhThuNV

--3. Xuất ra tổng doanh thu từng số xe
CREATE PROCEDURE sp_DoanhThuTungSoXe
AS
	BEGIN
		SELECT BUS.MaTuyen AS N'Mã tuyến', SUM((SoVeBan*DonGiaVe)) AS N'Doanh thu trong ngày (đồng)'
		FROM BUS, STAFF, TICKET_PACK
		WHERE BUS.MaTuyen=STAFF.MaTuyen AND TICKET_PACK.MaNV=STAFF.MaNV
		GROUP BY BUS.MaTuyen
		ORDER BY SUM((SoVeBan*DonGiaVe))
	END

EXECUTE sp_DoanhThuTungSoXe

--4. Xuất ra tổng doanh thu từng HTX
CREATE PROCEDURE sp_DoanhThuHTX
AS
	BEGIN
		SELECT HTX.TenHTX AS N'Tên HTX', SUM((SoVeBan*DonGiaVe)) AS N'Doanh thu trong ngày (đồng)'
		FROM HTX, BUS, STAFF, TICKET_PACK
		WHERE HTX.MaHTX=BUS.MaHTX AND BUS.MaTuyen=STAFF.MaTuyen AND TICKET_PACK.MaNV=STAFF.MaNV
		GROUP BY HTX.TenHTX
		ORDER BY SUM((SoVeBan*DonGiaVe))
	END

EXECUTE sp_DoanhThuHTX

--5 Xuất ra số xe có nhiều chuyến nhất
CREATE PROCEDURE sp_SoXeNhieuChuyenNhat
AS
	BEGIN
		SELECT Distinct MaTuyen, TenTuyen, SoChuyen
		FROM BUS
		WHERE SoChuyen = (SELECT MAX(SoChuyen) FROM BUS)
	END

EXEC sp_SoXeNhieuChuyenNhat

--6 Xuất ra nhân viên có lương lớn hơn lương của ít nhất 1 nhân viên xe số được chỉ định
CREATE PROCEDURE sp_LuongLonHonItNhat1NhanVienXe(@MaTuyen nvarchar(5))
AS
	BEGIN
		select *
		from staff
		where Luong > ANY(
					select Luong
					from staff
					where MaTuyen=@MaTuyen
		)
	END
EXEC sp_LuongLonHonItNhat1NhanVienXe N'05'



--7 Xuất ra số xe có khởi hành với giờ quy định
CREATE PROCEDURE sp_XeKhoiHanhLuc(@Gio time)
AS
	BEGIN
		SELECT MaTuyen, TenTuyen, KhoiHanh
		FROM BUS
		WHERE KhoiHanh = @Gio
	END

EXEC sp_XeKhoiHanhLuc '5:00'

