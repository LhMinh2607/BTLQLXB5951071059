USE BusManager
GO

--TRIGGER

--1.1. Kiểm tra input của Staff (Nhân viên)
CREATE TRIGGER tr_StaffInput
ON STAFF
	FOR INSERT
		AS
			BEGIN
				IF((SELECT GioiTinh FROM inserted) NOT IN (N'Nam', N'Nữ'))
					BEGIN
						PRINT N'Giới tính không hợp lệ.'
						ROLLBACK TRAN
						END
				IF((SELECT Chucvu FROM inserted) NOT IN (N'Tài xế', N'Tiếp Viên'))
					BEGIN
						PRINT N'Chức vụ không hợp lệ.'
						ROLLBACK TRAN
						END
				IF((SELECT So_Ve_Ban_Ra_Trong_Ngay FROM inserted) < 0)
					BEGIN
						PRINT N'Số vé phải lớn hơn hoặc bằng 0.'
						ROLLBACK TRAN
						END
				IF((SELECT Luong FROM inserted)<6900000)
					BEGIN
						PRINT N'Lương phải lớn hơn hoặc bằng 6.900.000'
						ROLLBACK TRAN
						END
				IF((SELECT DATEDIFF(YEAR, NgaySinh, getDate()) FROM inserted)<18)
					BEGIN
						PRINT N'Tuổi phải lớn hơn hoặc bằng 18'
						ROLLBACK TRAN
						END
			END
	
DROP TRIGGER tr_StaffInput
--Test Trigger Input của Nhân viên
INSERT INTO STAFF VALUES ('08A420','08',N'Nguyễn Nguyên Nguyện','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Cis',N'Tiếp Viên',0)
INSERT INTO STAFF VALUES ('08A420','08',N'Nguyễn Nguyên Nguyện','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Lơ xe',0)
INSERT INTO STAFF VALUES ('08A420','08',N'Nguyễn Nguyên Nguyện','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',-10)
INSERT INTO STAFF VALUES ('08A420','08',N'Nguyễn Nguyên Nguyện','9/6/1970',300000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',0)
INSERT INTO STAFF VALUES ('08A420','08',N'Nguyễn Nguyên Nguyện','9/6/2005',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',0)

--1.2. Kiểm tra sửa của Staff (Nhân viên)
CREATE TRIGGER tr_StaffUpdate
ON STAFF
	FOR UPDATE
		AS
			BEGIN
				IF((SELECT GioiTinh FROM inserted) NOT IN (N'Nam', N'Nữ'))
					BEGIN
						PRINT N'Giới tính không hợp lệ.'
						ROLLBACK TRAN
						END
				IF((SELECT Chucvu FROM inserted) NOT IN (N'Tài xế', N'Tiếp Viên'))
					BEGIN
						PRINT N'Chức vụ không hợp lệ.'
						ROLLBACK TRAN
						END
				IF((SELECT So_Ve_Ban_Ra_Trong_Ngay FROM inserted) < 0)
					BEGIN
						PRINT N'Số vé phải lớn hơn hoặc bằng 0.'
						ROLLBACK TRAN
						END
				IF((SELECT Luong FROM inserted)<6900000)
					BEGIN
						PRINT N'Lương phải lớn hơn hoặc bằng 6.900.000'
						ROLLBACK TRAN
						END
				IF((SELECT DATEDIFF(YEAR, NgaySinh, getDate()) FROM inserted)<18)
					BEGIN
						PRINT N'Tuổi phải lớn hơn hoặc bằng 18'
						ROLLBACK TRAN
						END
			END
DROP TRIGGER tr_StaffUpdate
--Test Trigger tr_StaffUpdate
INSERT INTO STAFF VALUES ('08A421','08',N'Nguyễn Thử Nghiệm','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',0)
UPDATE STAFF SET MaTuyen='08',HoTen=N'Nguyễn Nguyên Nguyện', NgaySinh='9/6/1970', Luong=11000000, DiaChi=N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM', GioiTinh= N'Cis', Chucvu=N'Tiếp Viên',So_ve_ban_ra_trong_ngay=0 WHERE MaNV='08A421'
UPDATE STAFF SET MaTuyen='08',HoTen=N'Nguyễn Nguyên Nguyện', NgaySinh='9/6/1970', Luong=11000000, DiaChi=N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM', GioiTinh= N'Nam', Chucvu=N'Lơ xe',So_ve_ban_ra_trong_ngay=0  WHERE MaNV='08A421'
UPDATE STAFF SET MaTuyen='08',HoTen=N'Nguyễn Nguyên Nguyện', NgaySinh='9/6/1970', Luong=11000000, DiaChi=N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM', GioiTinh= N'Nam', Chucvu=N'Tiếp Viên',So_ve_ban_ra_trong_ngay=-10  WHERE MaNV='08A421'
UPDATE STAFF SET MaTuyen='08',HoTen=N'Nguyễn Nguyên Nguyện', NgaySinh='9/6/1970', Luong=110000, DiaChi=N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM', GioiTinh= N'Nam', Chucvu=N'Tiếp Viên',So_ve_ban_ra_trong_ngay=0  WHERE MaNV='08A421'
UPDATE STAFF SET MaTuyen='08',HoTen=N'Nguyễn Nguyên Nguyện', NgaySinh='9/6/2005', Luong=11000000, DiaChi=N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM', GioiTinh= N'Nam', Chucvu=N'Tiếp Viên',So_ve_ban_ra_trong_ngay=0 WHERE MaNV='08A421'


--1.3 Trigger xóa staff
CREATE TRIGGER tr_StaffRemove
ON STAFF
	INSTEAD OF DELETE
		AS
			BEGIN
				DELETE TICKET_PACK WHERE MaNV=(SELECT MaNV FROM deleted)
				DELETE STAFF WHERE MaNV=(SELECT MaNV FROM deleted)
			END
DROP TRIGGER tr_StaffRemove
INSERT INTO STAFF VALUES ('69','08',N'Nguyễn Ngôn','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',0)
DELETE STAFF WHERE MaNV='69'


--2.1. Kiểm tra nhập của BUS (Xe buýt)
CREATE TRIGGER tr_BusInput
ON BUS
	FOR INSERT
		AS
			BEGIN
				IF((SELECT SoChoNgoi FROM inserted)<20)
					BEGIN
						PRINT N'Số chỗ ngồi phải lớn hơn hoặc bằng 20.'
						ROLLBACK TRAN
						END
				IF((SELECT SoChuyen FROM inserted)<20)
					BEGIN
						PRINT N'Số chuyến phải lớn hơn hoặc bằng 20.'
						ROLLBACK TRAN
						END
				IF((SELECT ThoiGian_MotChuyen FROM inserted)<20)
					BEGIN
						PRINT N'Thời gian 1 chuyến phải lớn hơn hoặc bằng 20 phút.'
						ROLLBACK TRAN
						END
				IF((SELECT CAST(KhoiHanh AS Time) FROM inserted)>(SELECT CAST(KetThuc AS Time) FROM inserted))
					BEGIN
						PRINT N'Thời gian khởi hành phải nhỏ hơn thời gian kết thúc.'
						ROLLBACK TRAN
						END
			END

--DROP TRIGGER tr_BusInput
--TEST TRIGGER NHẬP XE BUÝT
INSERT INTO BUS VALUES ('420','0301410987',N'Bến xe buýt Weeds',90,80,348,'14:40','2:30')
INSERT INTO BUS VALUES ('420','0301410987',N'Bến xe buýt Weeds',19,80,348,'4:40','20:30')
INSERT INTO BUS VALUES ('420','0301410987',N'Bến xe buýt Weeds',90,19,348,'4:40','20:30')
INSERT INTO BUS VALUES ('420','0301410987',N'Bến xe buýt Weeds',90,80,19,'4:40','20:30')


--2.2. Kiểm tra sửa của BUS (Xe buýt)
CREATE TRIGGER tr_BusUpdate
ON BUS
	FOR UPDATE
		AS
			BEGIN
				IF((SELECT SoChoNgoi FROM inserted)<20)
					BEGIN
						PRINT N'Số chỗ ngồi phải lớn hơn hoặc bằng 20.'
						ROLLBACK TRAN
						END
				IF((SELECT SoChuyen FROM inserted)<20)
					BEGIN
						PRINT N'Số chuyến phải lớn hơn hoặc bằng 20.'
						ROLLBACK TRAN
						END
				IF((SELECT ThoiGian_MotChuyen FROM inserted)<20)
					BEGIN
						PRINT N'Thời gian 1 chuyến phải lớn hơn hoặc bằng 20.'
						ROLLBACK TRAN
						END
				IF((SELECT CAST(KhoiHanh AS Time) FROM inserted)>(SELECT CAST(KetThuc AS Time) FROM inserted))
					BEGIN
						PRINT N'Thời gian khởi hành phải nhỏ hơn thời gian kết thúc.'
						ROLLBACK TRAN
						END
			END

DROP TRIGGER tr_BusUpdate
INSERT INTO BUS VALUES ('421','0301410987',N'Bến xe buýt Weeds+1',90,80,29,'4:40','20:30')

--TEST TRIGGER CẬP NHẬT XE BUS
UPDATE BUS SET MaHTX='0301410987', TenTuyen=N'Bến xe buýt Grass+1',ThoiGian_MotChuyen=90,SoChoNgoi=80,SoChuyen=348,KhoiHanh='14:40',KetThuc='2:30' WHERE MaTuyen='421'
UPDATE BUS SET MaHTX='0301410987', TenTuyen=N'Bến xe buýt Grass+1',ThoiGian_MotChuyen=19,SoChoNgoi=80,SoChuyen=348,KhoiHanh='2:30',KetThuc='14:40' WHERE MaTuyen='421'
UPDATE BUS SET MaHTX='0301410987', TenTuyen=N'Bến xe buýt Grass+1',ThoiGian_MotChuyen=90,SoChoNgoi=19,SoChuyen=348,KhoiHanh='2:30',KetThuc='14:40' WHERE MaTuyen='421'
UPDATE BUS SET MaHTX='0301410987', TenTuyen=N'Bến xe buýt Grass+1',ThoiGian_MotChuyen=90,SoChoNgoi=80,SoChuyen=19,KhoiHanh='2:30',KetThuc='14:40' WHERE MaTuyen='421'
--UPDATE BUS SET MaHTX='0301410987', TenTuyen=N'Bến xe buýt Grass+1',ThoiGian_MotChuyen=90,SoChoNgoi=80,SoChuyen=348,KhoiHanh='2:30',KetThuc='14:40' WHERE MaTuyen='421'


--2.3. Trigger xóa của BUS (Xe buýt)
CREATE TRIGGER tr_BusRemove
ON BUS
	INSTEAD OF DELETE
		AS
			BEGIN
				DELETE TICKET_PACK WHERE MaNV=(SELECT MaNV FROM STAFF INNER JOIN deleted ON STAFF.MaTuyen=deleted.MaTuyen)
				DELETE STAFF WHERE MaNV=(SELECT MaNV FROM STAFF INNER JOIN deleted ON STAFF.MaTuyen=deleted.MaTuyen)
				DELETE CROSS_STATION WHERE MaTuyen=(SELECT MaTuyen FROM deleted)
				DELETE BUS WHERE MaTuyen=(SELECT MaTuyen FROM deleted)
				PRINT N'Đã xóa xe buýt cùng với nhân viên và các quan hệ trạm của xe đó.'
			END

DROP TRIGGER tr_BusRemove

--Test Trigger Xóa Xe buýt
INSERT INTO STAFF VALUES ('421A69','421',N'Trần Thử Nghiệm','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',50)
INSERT INTO TICKET_PACK VALUES ('421HS01','421A69',3000,N'Học Sinh Sinh Viên', 50)
INSERT INTO TICKET_PACK VALUES ('421HS02','421A69',6000,N'Vé Thường', 50)
INSERT INTO CROSS_STATION VALUES (N'421','BX87',3,0)
INSERT INTO CROSS_STATION VALUES (N'421','QTD 177',3,1)
DELETE BUS WHERE MaTuyen='421'

--3.1. Trigger xóa HTX
CREATE TRIGGER tr_HTXRemove
ON HTX
	INSTEAD OF DELETE
		AS
			BEGIN
				DELETE TICKET_PACK WHERE MaNV=(SELECT MaNV FROM BUS INNER JOIN STAFF ON BUS.MaTuyen=STAFF.MaTuyen INNER JOIN deleted ON BUS.MaHTX=deleted.MaHTX)
				DELETE STAFF WHERE MaNV=(SELECT MaNV FROM BUS INNER JOIN STAFF ON BUS.MaTuyen=STAFF.MaTuyen INNER JOIN deleted ON BUS.MaHTX=deleted.MaHTX)
				DELETE CROSS_STATION WHERE MaTuyen=(SELECT MaTuyen FROM deleted INNER JOIN BUS ON deleted.MaHTX=BUS.MaHTX)
				DELETE BUS WHERE MaTuyen=(SELECT MaTuyen FROM deleted INNER JOIN BUS ON deleted.MaHTX=BUS.MaHTX)
				DELETE HTX WHERE MaHTX=(SELECT MaHTX FROM deleted)
				PRINT N'Đã xóa HTX, xe buýt cùng với nhân viên và các quan hệ trạm của xe đó.'
			END
DROP TRIGGER tr_HTXRemove
INSERT INTO HTX VALUES ('420420420',N'Hợp Tác Xã Vận Tải Xe Buýt Weeds',N'1129 Lạc Long Quân P.11 Q.Tân Bình TP.HCM')
INSERT INTO BUS VALUES ('42','420420420',N'Bến xe buýt Weeds+1',90,80,29,'4:40','20:30')
INSERT INTO STAFF VALUES ('42A69','42',N'Trần Thử Nghiệm','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',50)
INSERT INTO TICKET_PACK VALUES ('42HS01','42A69',3000,N'Học Sinh Sinh Viên', 50)
INSERT INTO TICKET_PACK VALUES ('42HS02','42A69',3000,N'Vé Thường', 50)
INSERT INTO CROSS_STATION VALUES (N'42','BX87',3,0)
INSERT INTO CROSS_STATION VALUES (N'42','QTD 177',3,1)
DELETE HTX WHERE MaHTX='420420420'


--4.1. Kiểm tra nhập của TICKET_PACK (Vé Xe buýt)
CREATE TRIGGER tr_TicketInput
ON TICKET_PACK
	AFTER INSERT
		AS
			BEGIN
				UPDATE STAFF SET So_Ve_Ban_Ra_Trong_Ngay+=INSERTED.SoVeBan
				FROM INSERTED
				WHERE INSERTED.MaNV=STAFF.MaNV
			END

DROP TRIGGER tr_TicketInput
INSERT INTO HTX VALUES ('420420420',N'Hợp Tác Xã Vận Tải Xe Buýt Weeds',N'1129 Lạc Long Quân P.11 Q.Tân Bình TP.HCM')
INSERT INTO BUS VALUES ('42','420420420',N'Bến xe buýt Weeds+1',90,80,29,'4:40','20:30')
INSERT INTO STAFF VALUES ('42A69','42',N'Trần Thử Nghiệm','9/6/1970',11000000,N'10 Lạc Long Quân P.10 Q.Tân Bình, TP.HCM',N'Nam',N'Tiếp Viên',0)
INSERT INTO TICKET_PACK VALUES ('42HS01','42A69',3000,N'Học Sinh Sinh Viên', 50)
INSERT INTO TICKET_PACK VALUES ('42PB02','42A69',7000,N'Vé Thường', 50)

--4.2. Kiểm tra XÓA của TICKET_PACK (Vé Xe buýt)
CREATE TRIGGER tr_TicketRemove
ON TICKET_PACK
	AFTER DELETE
		AS
			BEGIN
				UPDATE STAFF SET So_Ve_Ban_Ra_Trong_Ngay-=deleted.SoVeBan
				FROM DELETED
				WHERE deleted.MaNV=STAFF.MaNV
			END

DELETE TICKET_PACK WHERE MaTapVe='42HS01'

--4.3. Kiểm tra SỬA của TICKET_PACK (Vé Xe buýt)
CREATE TRIGGER tr_TicketUpdate
ON TICKET_PACK
	AFTER UPDATE
		AS
			BEGIN
				UPDATE STAFF SET So_Ve_Ban_Ra_Trong_Ngay=So_Ve_Ban_Ra_Trong_Ngay-deleted.SoVeBan+inserted.SoVeBan
				FROM DELETED, inserted
				WHERE deleted.MaNV=STAFF.MaNV AND inserted.MaNV=STAFF.MaNV
			END
DROP TRIGGER tr_TicketUpdate
UPDATE TICKET_PACK SET SoVeBan=175 WHERE MaTapVe='42PB02'

