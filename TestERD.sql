use master
if exists(select*from sysdatabases where name='TestERD') drop database TestERD
GO
create database TestERD
GO
use TestERD

CREATE TABLE NganHang
(
  MaNH CHAR(10) NOT NULL,
  TenNH NVARCHAR(15) NOT NULL,
  PRIMARY KEY (MaNH)
);

CREATE TABLE ChiNhanh
(
  MaCN CHAR(10) NOT NULL,
  TenCN NVARCHAR(15) NOT NULL,
  MaNH CHAR(10) NOT NULL,
  constraint CHINHANH_MACN_PK PRIMARY KEY (MaCN)
  
);

CREATE TABLE TruATM
(
  MaATM CHAR(10) NOT NULL,
  DiaDiem NVARCHAR(10) NOT NULL,
  TinhTrang NVARCHAR(10) NOT NULL,
  MaCN CHAR(10) NOT NULL,
  constraint TRUATM_MAATM_PK PRIMARY KEY (MaATM)
  
);

CREATE TABLE TaiKhoan
(
  MaTK CHAR(10) NOT NULL,
  TenTK NVARCHAR(20) NOT NULL,
  HoTen NVARCHAR(30) NOT NULL,
  MaNH CHAR(10) NOT NULL,
  constraint TAIKHOAN_MATK_HOTEN_PK PRIMARY KEY (MaTK, HoTen)
  
);

CREATE TABLE KhachHang
(
  HoTen NVARCHAR(30) NOT NULL,
  DiaChi NVARCHAR(40) NOT NULL,
  constraint KHACHHANG_HOTEN_PK PRIMARY KEY (HoTen)
);

CREATE TABLE TheATM
(
  MaThe CHAR(10) NOT NULL,
  TienGDGHTrenNgay FLOAT NOT NULL,
  LoaiThe NVARCHAR(10) NOT NULL,
  HoVaTen NVARCHAR(30) NOT NULL,
  ThoiHan DATE NOT NULL,
  MaTK CHAR(10) NOT NULL,
  HoTen NVARCHAR(30) NOT NULL,
  constraint THEATM_MATHE_PK PRIMARY KEY (MaThe, HoVaTen)
  
);

CREATE TABLE RutTien
(
  MaGD CHAR(10) NOT NULL,
  NgayGD DATE NOT NULL,
  TongTienGDTrenNgay FLOAT NOT NULL,
  SoTienGiaoDich FLOAT NOT NULL,
  MaThe CHAR(10) NOT NULL,
  HoVaTen NVARCHAR(30) NOT NULL,
  MaATM CHAR(10) NOT NULL,
  constraint RUTTIEN_MAGD_PK PRIMARY KEY (MaGD),
  constraint RUTTIEN_MATHE_HOTEN_MAATM UNIQUE (MaThe, HoVaTen, MaATM)

);


alter table NganHang
add constraint NH_MANH_FK FOREIGN KEY (MaNH) REFERENCES NganHang(MaNH)

alter table ChiNhanh
add constraint CHINHANH_MANH_FK FOREIGN KEY (MaNH) REFERENCES NganHang(MaNH)

alter table TruATM
add constraint TRUATM_MACN_PK FOREIGN KEY (MaCN) REFERENCES ChiNhanh(MaCN)

alter table TaiKhoan
add constraint TAIKHOAN_HOTEN_FK FOREIGN KEY (HoTen) REFERENCES KhachHang(HoTen),
	constraint TAIKHOAN_MANH_FK FOREIGN KEY (MaNH) REFERENCES NganHang(MaNH)

alter table TheATM
add constraint THEATM_HOTEN_FK FOREIGN KEY (HoVaTen) REFERENCES KhachHang(HoTen),
	constraint THEATM_MATK_HOTEN_FK FOREIGN KEY (MaTK, HoTen) REFERENCES TaiKhoan(MaTK, HoTen)

alter table RutTien
add constraint RUTTIEN_MATHE_HOVATEN_FK FOREIGN KEY (MaThe, HoVaTen) REFERENCES TheATM(MaThe, HoVaTen),
	constraint RUTTIEN_MAATM_FK FOREIGN KEY (MaATM) REFERENCES TruATM(MaATM)


INSERT INTO NGANHANG (MaNH, TenNH) 
					 VALUES 
					 ('A01',		'Sacombank'),
					 ('A02',		'MB Bank'),
					 ('A03',	    'BIDV'),
					 ('A04',		'ACB'),
					 ('A05',	    'Agribank');


INSERT INTO CHINHANH (MaCN,TenCN,MaNH)
					VALUES
					 ('001',		 N'Chi nhánh 1',			'A02'),
					 ('002',		 N'Chi nhánh 2',			'A02'),
					 ('003',		 N'Chi nhánh 3',			'A02'),

					 ('004',		 N'Chi nhánh 1',			'A01'),
					 ('005',		 N'Chi nhánh 2',			'A01'),
					 ('006',		 N'Chi nhánh 3',			'A01'),

					 ('007',		 N'Chi nhánh 1',			'A04'),
					 ('008',		 N'Chi nhánh 2',			'A04'),

					 ('009',		 N'Chi nhánh 1',			'A03'),

					 ('010',		 N'Chi nhánh 1',			'A05')


INSERT INTO TruATM(MaATM,DiaDiem,TinhTrang,MaCN)
				 VALUES 
				  ('20314',			  'TP HCM',				N'Hoạt động',			'001'),
				  ('20315',			  'TP HCM',				N'Hoạt động',			'001'),
				  ('20316',			 N'Hà Nội',				N'Hoạt động',			'002'),
				  ('20317',			 N'Hà Nội',				N'Hoạt động',			'002'),
				  ('20318',			 N'Quảng Ngãi',			N'Hoạt động',			'003'),

				  ('36711',			 N'Thủ Dầu 1',			N'Hoạt động',			'004'),
				  ('36712',			 N'TP HCM',				N'Hoạt động',			'005'),
				  ('36713',			 N'TP HCM',				N'Hoạt động',			'005'),
				  ('36714',			 N'Huế',				N'Tạm ngưng',			'006'),

				  ('49107',			 N'Đà Lạt',				N'Hoạt động',			'007'),
				  ('49108',			 N'Vũng Tàu',			N'Hoạt động',			'008'),
				  ('49109',			 N'Vũng Tàu',			N'Tạm ngưng',			'008'),

				  ('57810',			 N'Tiền Giang',			N'Tạm ngưng',			'009'),
				  ('57811',			 N'Hà Nội',				N'Tạm ngưng',			'009'),

				  ('78643',			 N'TP HCM',				N'Hoạt động',			'010')
			

INSERT INTO KhachHang(HoTen,DiaChi)
					VALUES 
				   (N'Nguyễn Quốc Cường',				N'23 Hóc Môn, TP HCM'),
				   (N'Lê Quốc Hùng',					N'313 Bến Nghé, TP HCM'),
				   (N'Đào Kim Nguyễn Thuỵ Nam',			N'6A Bình Sơn, Quãng Ngãi'),

				   (N'Lâm Tấn Hải',						N'132 Bình Dương, Thủ Dầu 1'),
				   (N'Tào Mạnh Đức',					N'35D Phong Điền, Huế'),
				   (N'Nguyễn Vương Hoàng Long',			N'3 Bình Tân, TP HCM'),
				   (N'Nguyễn Quang Tuyên',				N'81B Gò Vấp, TP HCM'),

				   (N'Diệp Thu Hải',					N'146 Đam Rông, Đà Lạt'),
				   (N'Nguyễn Thành Nam',				N'73A Tân Thành, Vũng Tàu'),
				   (N'Trần Minh Cường',					N'19 Long Điền, Vũng Tàu'),

				   (N'Đỗ Thị Ngọc Anh',					N'7 Châu Thành, Tiền Giang'),
				   (N'Bùi Thanh Liêm',					N'313 Ba Vì, Hà Nội'),

				   (N'Lê Quang Liêm',					N'132 Củ Chi, TP HCM'),
				   (N'Nguyễn Hoài Nam',					N'40 Bình Chánh, TPHCM')


INSERT INTO TaiKhoan(MaTK,TenTK,HoTen,MaNH)
					VALUES
					('Ba467Y',		'hunglequoc123',			 N'Lê Quốc Hùng',				'A01'),
					('g1428H',		'hunglq132',				 N'Lê Quốc Hùng',				'A01'),
					('Pf9102',		'hlq6617',					 N'Lê Quốc Hùng',				'A01'),
					('A12d4Z',		'cuongtoantin',				 N'Nguyễn Quốc Cường',			'A01'),
					('H32fZ8',		'dkngthuynam',				 N'Đào Kim Nguyễn Thuỵ Nam',	'A01'),

				   ('ABF1423',		'tanhailam1989',			 N'Lâm Tấn Hải',				'A02'),
				   ('CDL0192',		'tmduc314',				  	 N'Tào Mạnh Đức',				'A02'),
				   ('OIPQ192',		'longnguyen2005',			 N'Nguyễn Vương Hoàng Long',	'A02'),
				   ('MYTA086',		'nqthentZ',					 N'Nguyễn Quang Tuyên',			'A02'),

				  ('1239827A',		'thuhaid',					 N'Diệp Thu Hải',				'A03'),
				  ('0924381M',		'ntnvlog1994',				 N'Nguyễn Thành Nam',			'A03'),
				  ('3102386O',		'nguyenthnam3110',			 N'Nguyễn Thành Nam',			'A03'),
				  ('6724833J',		'tcuong142',				 N'Trần Minh Cường',			'A03'),

				  ('aderw132',		'liembui1979',				 N'Bùi Thanh Liêm',				'A04'),
				  ('lqw9hi3j',		'ngocanhdothi31091993',		 N'Đỗ Thị Ngọc Anh',			'A04'),

				  ('1a4D0H6m',		'liemleVSstockfish',		 N'Lê Quang Liêm',				'A05'),
				  ('6P1k6G3l',		'bokunopico1003',			 N'Nguyễn Hoài Nam',			'A05')
				

set dateformat dmy
INSERT INTO TheATM( MaThe, HoVaTen , LoaiThe , ThoiHan , TienGDGHTrenNgay , HoTen, MaTK   )
				 VALUES 
			(N'3127438291',		N'Lê Quốc Hùng',					N'Tín dụng',		'31/08/2034',		200000,		N'Lê Quốc Hùng',			'Ba467Y'),
			(N'2910821928',		N'Lê Quốc Hùng',					N'Tín dụng',		'06/12/2026',		150000,		N'Lê Quốc Hùng',			'g1428H'),
			(N'8162309885',		N'Lê Quốc Hùng',					N'Ghi nợ',			'01/04/2029',		50000,		N'Lê Quốc Hùng',			'Pf9102'),
			(N'2143628099',		N'Nguyễn Quốc Cường',				N'Tín dụng',		'06/07/2030',		130000,		N'Nguyễn Quốc Cường',		'A12d4Z'),
			(N'7277918034',		N'Đào Kim Nguyễn Thuỵ Nam',			N'Tín dụng',		'13/10/2026',		250000,		N'Đào Kim Nguyễn Thuỵ Nam',	'H32fZ8'),

			(N'0192314954',		N'Lâm Tấn Hải',						N'Tín dụng',		'12/03/2028',		230000,		N'Lâm Tấn Hải',				'ABF1423'),
			(N'1006273488',		N'Tào Mạnh Đức',					N'Tín dụng',		'11/11/2024',		160000,		N'Tào Mạnh Đức',			'CDL0192'),
			(N'2536148951',		N'Nguyễn Quang Tuyên',				N'Tín dụng',		'25/02/2034',		120000,		N'Nguyễn Quang Tuyên',		'MYTA086'),

			(N'7749785690',		N'Nguyễn Thành Nam',				N'Tín dụng',		'02/03/2027',		148000,		N'Nguyễn Thành Nam',		'0924381M'),
			(N'3126433991',		N'Nguyễn Thành Nam',				N'Ghi nợ',			'03/12/2028',		70000,		N'Nguyễn Thành Nam',		'3102386O'),

			(N'4866915032',		N'Bùi Thanh Liêm',					N'Tín dụng',		'21/01/2030',		130000,		N'Bùi Thanh Liêm',			'aderw132'),
			(N'5231098344',		N'Đỗ Thị Ngọc Anh',					N'Ghi nợ',			'26/05/2028',		50000,		N'Đỗ Thị Ngọc Anh',			'lqw9hi3j'),

			(N'9018207314',		N'Lê Quang Liêm',					N'Tín dụng',		'18/02/2034',		250000,		N'Lê Quang Liêm',			'1a4D0H6m'	)
	
			
set dateformat dmy				  
INSERT INTO RutTien(MaGD,NgayGD,SoTienGiaoDich,TongTienGDTrenNgay,MaATM,MaThe,HoVaTen)
				  VALUES 
			('FT48664225',		'16/02/2024',		 15000,			15000,		'20318',			'7277918034',					N'Đào Kim Nguyễn Thuỵ Nam'),
			('NP01934862',		'12/09/2023',		 2000,			2000,		'20314',			'3127438291',					N'Lê Quốc Hùng'),

			('2043778146',		'18/10/2023',		 100000,		100000,		'36714',			'1006273488',					N'Tào Mạnh Đức'),
			('3748682119',		'03/03/2024',		 15000,			15000,		'36713',			'2536148951',					N'Nguyễn Quang Tuyên'),

			('019428225H',		'11/07/2023',		 25000,			25000,		'49108',			'7749785690',					N'Nguyễn Thành Nam'),
			
			('AZCB148622',		'23/01/2024',		 3000,			3000,		'78643',			'9018207314',					N'Lê Quang Liêm')
				










