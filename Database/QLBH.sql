CREATE DATABASE QLBH 
use QLBH 
CREATE TABLE Quyen (
  MaQuyen NVARCHAR(10) NOT NULL PRIMARY KEY,
  TenQuyen NVARCHAR(50) NOT NULL
);

CREATE TABLE TaiKhoan (
  MaTK NVARCHAR(10) NOT NULL PRIMARY KEY,
  TenDN NVARCHAR(50) NOT NULL,
  MatKhau NVARCHAR(255) NOT NULL,
  HoTen NVARCHAR(100) NOT NULL,
  Email NVARCHAR(100) NOT NULL,
  PhanQuyen NVARCHAR(50) NOT NULL
);

CREATE TABLE CTQuyen (
  MaQuyen NVARCHAR(10),
  MaTK NVARCHAR(10),
  PRIMARY KEY (MaQuyen, MaTK),
  FOREIGN KEY (MaQuyen) REFERENCES Quyen(MaQuyen),
  FOREIGN KEY (MaTK) REFERENCES TaiKhoan(MaTK)
);

CREATE TABLE LoaiSanPham (
  MaLoaiSP NVARCHAR(10) NOT NULL PRIMARY KEY,
  TenLoaiSP NVARCHAR(25) NOT NULL
);

CREATE TABLE Kho (
  MaKho NVARCHAR(10) NOT NULL PRIMARY KEY,
  TenKho NVARCHAR(100) NOT NULL,
  DiaChi NVARCHAR(255)
);

CREATE TABLE NhanVien (
  MaNV NVARCHAR(10) NOT NULL PRIMARY KEY,
  HoTenNV NVARCHAR(100) NOT NULL,
  NgaySinhNV DATE NOT NULL,
  GioiTinhNV NVARCHAR(10),
  SDT_NV NVARCHAR(15),
  Email_NV NVARCHAR(100)
);

CREATE TABLE KhachHang (
  MaKH NVARCHAR(10) NOT NULL PRIMARY KEY,
  HoTenKH NVARCHAR(100) NOT NULL,
  NgaySinhKH DATE NOT NULL,
  GioiTinhKH NVARCHAR(10),
  SDT_KH NVARCHAR(15),
  Email_KH NVARCHAR(100),
  DiaChi_KH NVARCHAR(100)
);

CREATE TABLE SanPham (
  MaSP NVARCHAR(10) NOT NULL PRIMARY KEY,
  TenSP NVARCHAR(100) NOT NULL,
  GiaBan DECIMAL(18, 2) NOT NULL,
  SoLuong INT NOT NULL,
  HinhAnh NVARCHAR(255),
  MoTa NVARCHAR(255),
  DungLuong NVARCHAR(50),
  HSD DATE,
  MaLoaiSP NVARCHAR(10),
  MaKho NVARCHAR(10),
  FOREIGN KEY (MaLoaiSP) REFERENCES LoaiSanPham(MaLoaiSP),
  FOREIGN KEY (MaKho) REFERENCES Kho(MaKho)
);

CREATE TABLE HoaDon (
  MaHD NVARCHAR(10) NOT NULL PRIMARY KEY,
  HoTenKH NVARCHAR(100) NOT NULL,
  DiaDiemGH NVARCHAR(255),
  SDTNguoiDH NVARCHAR(15),
  NgayDH DATE NOT NULL,
  PhuongThucThanhToan NVARCHAR(50),
  TinhTrangDDH NVARCHAR(20),
  MaKH NVARCHAR(10),
  MaNV NVARCHAR(10),
  FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE CTHoaDon (
  MaHD NVARCHAR(10),
  MaSP NVARCHAR(10),
  SoLuongDat INT NOT NULL,
  DonGia DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (MaHD, MaSP),
  FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
  FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);



CREATE TABLE PhieuNhap (
  MaPN NVARCHAR(10) NOT NULL PRIMARY KEY,
  MaNV NVARCHAR(10),
  TenPhieuNhap NVARCHAR(100),
  NgayLap DATE NOT NULL,
  TongTienNhap DECIMAL(18, 2) NOT NULL,
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE PhieuXuat (
  MaPX NVARCHAR(10) NOT NULL PRIMARY KEY,
  MaNV NVARCHAR(10),
  TenPX NVARCHAR(100),
  NgayLap DATE NOT NULL,
  TongTienXuat DECIMAL(18, 2) NOT NULL,
  FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE CTPhieuNhap (
  MaPN NVARCHAR(10),
  MaSP NVARCHAR(10),
  SoLuongNhap INT NOT NULL,
  DonGiaNhap DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (MaPN, MaSP),
  FOREIGN KEY (MaPN) REFERENCES PhieuNhap(MaPN),
  FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

CREATE TABLE CTPhieuXuat (
  MaPX NVARCHAR(10),
  MaSP NVARCHAR(10),
  SoLuongXuat INT NOT NULL,
  DonGiaXuat DECIMAL(18, 2) NOT NULL,
  PRIMARY KEY (MaPX, MaSP),
  FOREIGN KEY (MaPX) REFERENCES PhieuXuat(MaPX),
  FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

-- D? li?u cho b?ng KhachHang
INSERT INTO KhachHang (MaKH, HoTenKH, NgaySinhKH, GioiTinhKH, SDT_KH, Email_KH, DiaChi_KH) VALUES 
('KH001', N'Trần Minh Khôi', '1990-01-01', N'Nam', '0901234567', 'tranminhkhoi@gmail.com', N'123 Lê Văn Sỹ, Quận 3, TP.HCM'),
('KH002', N'Nguyễn Ngọc Bích', '1992-02-02', N'Nữ', '0912345678', 'nguyenngocbich@gmail.com', N'456 Nguyễn Thị Minh Khai, Quận 1, TP.HCM'),
('KH003', N'Lê Thành Đạt', '1988-03-03', N'Nam', '0923456789', 'lethanhdat@gmail.com', N'789 Trần Hưng Đạo, Quận 5, TP.HCM'),
('KH004', N'Phạm Hải Yến', '1995-04-04', N'Nữ', '0934567890', 'phamhaiyen@gmail.com', N'321 Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM'),
('KH005', N'Trần Bảo Ngọc', '1991-05-05', N'Nam', '0945678901', 'tranbaongoc@gmail.com', N'654 Nguyễn Huệ, Quận 1, TP.HCM'),
('KH006', N'Ngô Diễm My', '1993-06-06', N'Nữ', '0956789012', 'ngodienmy@gmail.com', N'987 Lê Thánh Tôn, Quận 1, TP.HCM'),
('KH007', N'Vũ Quang Huy', '1987-07-07', N'Nam', '0967890123', 'vuquanghuy@gmail.com', N'159 Phan Đăng Lưu, Quận Bình Thạnh, TP.HCM'),
('KH008', N'Đỗ Minh Tâm', '1994-08-08', N'Nữ', '0978901234', 'domintam@gmail.com', N'753 Trương Định, Quận 1, TP.HCM'),
('KH009', N'Nguyễn Văn An', '1996-09-09', N'Nam', '0989012345', 'nguyenvanan@gmail.com', N'246 Đường số 3, Phường Bình An, Quận 2, TP.HCM'),
('KH010', N'Lê Thị Phương', '1992-10-10', N'Nữ', '0990123456', 'lephuong@gmail.com', N'135 Nguyễn Thị Thập, Quận 7, TP.HCM'),
('KH011', N'Trương Minh Tuấn', '1985-11-11', N'Nam', '0902345678', 'truongminhtuan@gmail.com', N'246 Lê Văn Việt, Quận 9, TP.HCM'),
('KH012', N'Nguyễn Thị Hằng', '1990-12-12', N'Nữ', '0913456789', 'nguyenthihang@gmail.com', N'357 Lê Đức Thọ, Quận Gò Vấp, TP.HCM'),
('KH013', N'Lâm Thế Vinh', '1989-01-13', N'Nam', '0924567890', 'lamthevinh@gmail.com', N'468 Nguyễn Văn Cừ, Quận 5, TP.HCM'),
('KH014', N'Bùi Thị Như', '1996-02-14', N'Nữ', '0935678901', 'buithinhu@gmail.com', N'579 Trần Não, Quận 2, TP.HCM'),
('KH015', N'Phan Văn Hòa', '1993-03-15', N'Nam', '0946789012', 'phanvanhoa@gmail.com', N'680 Thống Nhất, Quận Gò Vấp, TP.HCM'),
('KH016', N'Đinh Thị Mai', '1988-04-16', N'Nữ', '0957890123', 'dinhmaii@gmail.com', N'791 Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM'),
('KH017', N'Nguyễn Văn Tài', '1991-05-17', N'Nam', '0968901234', 'nguyenvantai@gmail.com', N'802 Lê Văn Khương, Quận 12, TP.HCM'),
('KH018', N'Trần Thị Thanh', '1994-06-18', N'Nữ', '0979012345', 'tranthithanh@gmail.com', N'913 Nguyễn Văn Trỗi, Quận Phú Nhuận, TP.HCM'),
('KH019', N'Lê Văn Phúc', '1986-07-19', N'Nam', '0980123456', 'levanphuc@gmail.com', N'123 A Trần Hưng Đạo, Quận 1, TP.HCM'),
('KH020', N'Ngô Thị Xuân', '1995-08-20', N'Nữ', '0901234568', 'ngothixuan@gmail.com', N'456 B Lê Văn Sỹ, Quận 3, TP.HCM'),
('KH021', N'Vũ Văn Kiên', '1990-09-21', N'Nam', '0912345679', 'vuvankien@gmail.com', N'789 C Nguyễn Thị Minh Khai, Quận 1, TP.HCM'),
('KH022', N'Phạm Thị Giang', '1992-10-22', N'Nữ', '0923456780', 'phamgiang@gmail.com', N'321 D Trương Định, Quận 1, TP.HCM'),
('KH023', N'Bùi Văn Khải', '1987-11-23', N'Nam', '0934567891', 'buivankhai@gmail.com', N'654 E Nguyễn Huệ, Quận 1, TP.HCM'),
('KH024', N'Trần Thị Lý', '1993-12-24', N'Nữ', '0945678902', 'tranly@gmail.com', N'987 F Lê Thánh Tôn, Quận 1, TP.HCM'),
('KH025', N'Lê Văn Hùng', '1991-01-25', N'Nam', '0956789013', 'levanhung@gmail.com', N'159 G Nguyễn Thị Thập, Quận 7, TP.HCM'),
('KH026', N'Nguyễn Thị Mến', '1989-02-26', N'Nữ', '0967890124', 'nguyenthimen@gmail.com', N'753 H Lê Văn Việt, Quận 9, TP.HCM'),
('KH027', N'Đỗ Văn Cường', '1990-03-27', N'Nam', '0978901235', 'dovancuong@gmail.com', N'246 I Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM'),
('KH028', N'Nguyễn Thị Lộc', '1994-04-28', N'Nữ', '0989012346', 'nguyenthiloc@gmail.com', N'135 J Thống Nhất, Quận Gò Vấp, TP.HCM'),
('KH029', N'Lê Văn Tài', '1988-05-29', N'Nam', '0902345679', 'levantai@gmail.com', N'468 K Trần Não, Quận 2, TP.HCM'),
('KH030', N'Trần Thị Hòa', '1992-06-30', N'Nữ', '0913456780', 'tranhoa@gmail.com', N'579 L Nguyễn Văn Cừ, Quận 5, TP.HCM'),
('KH031', N'Vũ Minh Tuấn', '1993-07-31', N'Nam', '0924567891', 'vumintu@gmail.com', N'680 M Lê Đức Thọ, Quận Gò Vấp, TP.HCM'),
('KH032', N'Ngô Thị Bích', '1986-08-01', N'Nữ', '0935678903', 'ngobich@gmail.com', N'791 N Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM'),
('KH033', N'Nguyễn Văn Sơn', '1991-09-02', N'Nam', '0946789014', 'nguyenson@gmail.com', N'802 O Nguyễn Thị Minh Khai, Quận 1, TP.HCM'),
('KH034', N'Trương Thị Lệ', '1995-10-03', N'Nữ', '0957890125', 'truongle@gmail.com', N'913 P Thống Nhất, Quận Gò Vấp, TP.HCM'),
('KH035', N'Lâm Văn Hòa', '1989-11-04', N'Nam', '0968901236', 'lamho@gmail.com', N'123 Q Trương Định, Quận 1, TP.HCM'),
('KH036', N'Bùi Thị Nhi', '1993-12-05', N'Nữ', '0979012347', 'buinhi@gmail.com', N'456 R Lê Văn Khương, Quận 12, TP.HCM'),
('KH037', N'Phan Văn Bình', '1991-01-06', N'Nam', '0980123457', 'phanbinh@gmail.com', N'789 S Nguyễn Thị Thập, Quận 7, TP.HCM'),
('KH038', N'Trần Thị Đào', '1992-02-07', N'Nữ', '0901234569', 'trandao@gmail.com', N'135 T Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM'),
('KH039', N'Lê Văn Quyết', '1988-03-08', N'Nam', '0912345670', 'levanquyet@gmail.com', N'246 U Lê Văn Sỹ, Quận 3, TP.HCM'),
('KH040', N'Nguyễn Thị Hoa', '1990-04-09', N'Nữ', '0923456781', 'nguyenhoa@gmail.com', N'357 V Nguyễn Huệ, Quận 1, TP.HCM'),
('KH041', N'Đinh Văn Phát', '1994-05-10', N'Nam', '0934567892', 'dinhphat@gmail.com', N'468 W Trần Hưng Đạo, Quận 5, TP.HCM'),
('KH042', N'Vũ Thị Phương', '1986-06-11', N'Nữ', '0945678904', 'vuphuong@gmail.com', N'579 X Nguyễn Thị Minh Khai, Quận 1, TP.HCM'),
('KH043', N'Nguyễn Văn Hùng', '1991-07-12', N'Nam', '0956789015', 'nguyenhung@gmail.com', N'680 Y Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM'),
('KH044', N'Trần Thị Nhung', '1993-08-13', N'Nữ', '0967890126', 'trannhung@gmail.com', N'791 Z Lê Văn Khương, Quận 12, TP.HCM'),
('KH045', N'Lê Văn Thành', '1989-09-14', N'Nam', '0978901237', 'levanthanh@gmail.com', N'123 AA Nguyễn Thị Thập, Quận 7, TP.HCM'),
('KH046', N'Ngô Thị Kim', '1992-10-15', N'Nữ', '0989012348', 'ngokim@gmail.com', N'456 BB Trương Định, Quận 1, TP.HCM'),
('KH047', N'Phạm Văn Khoa', '1991-11-16', N'Nam', '0902345680', 'phamkhoa@gmail.com', N'789 CC Lê Văn Sỹ, Quận 3, TP.HCM'),
('KH048', N'Trương Thị Bích', '1995-12-17', N'Nữ', '0913456791', 'truongbich@gmail.com', N'135 DD Nguyễn Huệ, Quận 1, TP.HCM'),
('KH049', N'Vũ Văn Thành', '1990-01-18', N'Nam', '0924567892', 'vuthanh@gmail.com', N'468 EE Lê Thánh Tôn, Quận 1, TP.HCM'),
('KH050', N'Nguyễn Thị Hà', '1988-02-19', N'Nữ', '0935678905', 'nguyenha@gmail.com', N'579 FF Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM');

select * from LoaiSanPham


-- D? li?u cho b?ng LoaiSanPham
INSERT INTO LoaiSanPham (MaLoaiSP, TenLoaiSP) VALUES
('LSP01', N'Kem chống nắng'),
('LSP02', N'Kem dưỡng'),
('LSP03', N'Sữa rửa mặt'),
('LSP04', N'Tẩy trang'),
('LSP05', N'Mặt nạ giấy');

INSERT INTO SanPham (MaSP, TenSP, GiaBan, SoLuong, HinhAnh, MoTa, DungLuong, HSD, MaLoaiSP, MaKho) VALUES
('SP001', 'Kem Chống Nắng Innisfree Tone Up No Sebum SPF50+/PA++++', 300000, 100, '/img/kcn.png', 'Chống nắng cho da dầu', '50ml', '2026-01-01', 'LSP01', 'Kho01'),
('SP002', 'Kem Chống Nắng Innisfree Highlight No Sebum SPF50+/PA++++', 450000, 100, '/img/kcn2.png', 'Chống nắng làm sáng da', '50ml', '2026-03-01', 'LSP01', 'Kho02'),
('SP003', 'Kem Chống Nắng Innisfree Intensive Long-Lasting Sunscreen', 400000, 100, '/img/kcnvang.png', 'Chống nắng lâu trôi', '50ml', '2026-05-01', 'LSP01', 'Kho03'),
('SP004', 'Kem Chống Nắng Innisfree da nhạy cảm Long-Lasting Sunscreen', 300000, 100, '/img/kcn3.png', 'Chống nắng cho da nhạy cảm', '50ml', '2026-07-01', 'LSP01', 'Kho01'),
('SP005', 'Kem Dưỡng Da Hoa Anh Đào Innisfree Jeju Cherry Blossom Tone Up', 300000, 100, '/img/Screen Shot 2024-07-03 at 05.28.41.png', 'Dưỡng ẩm và làm sáng da', '50ml', '2026-09-01', 'LSP02', 'Kho02'),
('SP006', 'Kem Dưỡng Innisfree Trà Xanh Green Tea Balancing Cream EX 50mL', 270000, 100, '/img/Screen Shot 2024-07-03 at 05.18.22.png', 'Dưỡng ẩm cho da', '50ml', '2026-11-01', 'LSP02', 'Kho03'),
('SP007', 'Sữa rửa mặt Innisfree Green Tea Foam Cleanser', 210000, 100, '/img/Screen Shot 2024-07-03 at 05.32.14.png', 'Rửa mặt làm sạch sâu', '150ml', '2026-12-01', 'LSP03', 'Kho01'),
('SP008', 'Sữa Rửa Mặt Innisfree Jeju Pomegranate Foam', 240000, 100, '/img/Screen Shot 2024-07-03 at 05.36.38.png', 'Rửa mặt chiết xuất lựu', '150ml', '2027-01-01', 'LSP03', 'Kho02'),
('SP009', 'Tẩy Trang Innisfree Green Tea Cleansing Water', 280000, 100, '/img/Screen Shot 2024-07-03 at 06.05.30.png', 'Tẩy trang chiết xuất trà xanh', '300ml', '2027-02-01', 'LSP04', 'Kho03'),
('SP010', 'Nước tẩy trang Innisfree Sea Salt Cleansing Water', 350000, 100, '/img/Screen Shot 2024-07-03 at 06.11.32.png', 'Tẩy trang chiết xuất muối biển', '300ml', '2027-03-01', 'LSP04', 'Kho01'),
('SP011', 'Mặt Nạ Giấy Innisfree Green Tea Balancing', 35000, 200, '/img/kcn.png', 'Mặt nạ dưỡng ẩm chiết xuất trà xanh', '1 miếng', '2025-12-01', 'LSP05', 'Kho02'),
('SP012', 'Mặt Nạ Giấy Innisfree Jeju Volcanic Pore', 40000, 150, '/img/kcn2.png', 'Mặt nạ làm sạch sâu lỗ chân lông', '1 miếng', '2025-11-01', 'LSP05', 'Kho03'),
('SP013', 'Mặt Nạ Giấy Innisfree My Real Squeeze Mask - Rose', 30000, 200, '/img/kcnvang.png', 'Mặt nạ làm sáng da chiết xuất hoa hồng', '1 miếng', '2025-10-01', 'LSP05', 'Kho01'),
('SP014', 'Mặt Nạ Giấy Innisfree My Real Squeeze Mask - Aloe', 30000, 200, '/img/kcn3.png', 'Mặt nạ làm dịu da chiết xuất lô hội', '1 miếng', '2025-09-01', 'LSP05', 'Kho02'),
('SP015', 'Kem Chống Nắng Innisfree Daily Mild Sunscreen', 320000, 100, '/img/Screen Shot 2024-07-03 at 05.28.41.png', 'Chống nắng nhẹ dịu cho da', '50ml', '2026-02-01', 'LSP01', 'Kho03'),
('SP016', 'Kem Dưỡng Da Innisfree Orchid Enriched Cream', 400000, 120, '/img/Screen Shot 2024-07-03 at 05.18.22.png', 'Dưỡng ẩm chống lão hóa', '50ml', '2026-08-01', 'LSP02', 'Kho01'),
('SP017', 'Sữa Rửa Mặt Innisfree Bija Trouble Facial Foam', 250000, 90, '/img/Screen Shot 2024-07-03 at 05.32.14.png', 'Rửa mặt cho da mụn', '150ml', '2027-01-01', 'LSP03', 'Kho02'),
('SP018', 'Sữa Rửa Mặt Innisfree Volcanic Pore Cleansing Foam', 230000, 110, '/img/Screen Shot 2024-07-03 at 05.36.38.png', 'Rửa mặt làm sạch sâu từ tro núi lửa', '150ml', '2027-02-01', 'LSP03', 'Kho03'),
('SP019', 'Tẩy Trang Innisfree Apple Seed Lip & Eye Remover', 290000, 100, '/img/Screen Shot 2024-07-03 at 06.05.30.png', 'Tẩy trang dịu nhẹ vùng mắt môi', '100ml', '2027-03-01', 'LSP04', 'Kho01'),
('SP020', 'Tẩy Trang Innisfree Olive Real Cleansing Oil', 380000, 80, '/img/Screen Shot 2024-07-03 at 06.11.32.png', 'Tẩy trang dạng dầu chiết xuất olive', '200ml', '2027-04-01', 'LSP04', 'Kho02'),
('SP021', 'Mặt Nạ Giấy Innisfree Tea Tree', 35000, 180, '/img/kcn.png', 'Mặt nạ trị mụn chiết xuất tràm trà', '1 miếng', '2025-12-01', 'LSP05', 'Kho02'),
('SP022', 'Mặt Nạ Giấy Innisfree Green Tea Hydrating', 40000, 160, '/img/kcn2.png', 'Mặt nạ cung cấp độ ẩm chiết xuất trà xanh', '1 miếng', '2025-11-01', 'LSP05', 'Kho03'),
('SP023', 'Mặt Nạ Giấy Innisfree My Real Squeeze Mask - Pomegranate', 30000, 190, '/img/kcnvang.png', 'Mặt nạ làm sáng da chiết xuất lựu', '1 miếng', '2025-10-01', 'LSP05', 'Kho01'),
('SP024', 'Mặt Nạ Giấy Innisfree My Real Squeeze Mask - Green Tea', 30000, 200, '/img/kcn3.png', 'Mặt nạ làm dịu da chiết xuất trà xanh', '1 miếng', '2025-09-01', 'LSP05', 'Kho02'),
('SP025', 'Kem Chống Nắng Innisfree Eco Safety Perfect Sun Block', 320000, 120, '/img/Screen Shot 2024-07-03 at 05.28.41.png', 'Chống nắng hoàn hảo cho da nhạy cảm', '50ml', '2026-02-01', 'LSP01', 'Kho03'),
('SP026', 'Kem Dưỡng Da Innisfree Green Tea Seed Cream', 400000, 110, '/img/Screen Shot 2024-07-03 at 05.18.22.png', 'Dưỡng ẩm sâu và làm sáng da', '50ml', '2026-08-01', 'LSP02', 'Kho01'),
('SP027', 'Sữa Rửa Mặt Innisfree Green Barley Gommage', 250000, 95, '/img/Screen Shot 2024-07-03 at 05.32.14.png', 'Rửa mặt tẩy tế bào chết nhẹ nhàng', '150ml', '2027-01-01', 'LSP03', 'Kho02'),
('SP028', 'Sữa Rửa Mặt Innisfree Rice Cleansing Foam', 230000, 105, '/img/Screen Shot 2024-07-03 at 05.36.38.png', 'Rửa mặt làm sạch và sáng da', '150ml', '2027-02-01', 'LSP03', 'Kho03'),
('SP029', 'Tẩy Trang Innisfree Jeju Cherry Blossom Jelly Cream', 290000, 90, '/img/Screen Shot 2024-07-03 at 06.05.30.png', 'Tẩy trang dịu nhẹ chiết xuất hoa anh đào', '100ml', '2027-03-01', 'LSP04', 'Kho01'),
('SP030', 'Tẩy Trang Innisfree Green Tea Cleansing Foam', 380000, 85, '/img/Screen Shot 2024-07-03 at 06.11.32.png', 'Tẩy trang dạng kem chiết xuất trà xanh', '200ml', '2027-04-01', 'LSP04', 'Kho02'),
('SP031', 'Mặt Nạ Giấy Innisfree Aloe Vera', 35000, 170, '/img/kcn.png', 'Mặt nạ làm dịu da chiết xuất lô hội', '1 miếng', '2025-12-01', 'LSP05', 'Kho03'),
('SP032', 'Mặt Nạ Giấy Innisfree Coconut', 40000, 140, '/img/kcn2.png', 'Mặt nạ cung cấp độ ẩm chiết xuất dừa', '1 miếng', '2025-11-01', 'LSP05', 'Kho01'),
('SP033', 'Mặt Nạ Giấy Innisfree Avocado', 30000, 210, '/img/kcnvang.png', 'Mặt nạ cung cấp dưỡng chất chiết xuất bơ', '1 miếng', '2025-10-01', 'LSP05', 'Kho02'),
('SP034', 'Mặt Nạ Giấy Innisfree Honey', 30000, 220, '/img/kcn3.png', 'Mặt nạ làm sáng da chiết xuất mật ong', '1 miếng', '2025-09-01', 'LSP05', 'Kho01'),
('SP035', 'Kem Chống Nắng Innisfree Perfect UV Protection Cream', 320000, 130, '/img/Screen Shot 2024-07-03 at 05.28.41.png', 'Chống nắng hoàn hảo cho mọi loại da', '50ml', '2026-02-01', 'LSP01', 'Kho03'),
('SP036', 'Kem Dưỡng Da Innisfree Olive Real Cream', 400000, 130, '/img/Screen Shot 2024-07-03 at 05.18.22.png', 'Kem dưỡng ẩm chiết xuất olive', '50ml', '2026-08-01', 'LSP02', 'Kho01'),
('SP037', 'Sữa Rửa Mặt Innisfree Green Tea Foam Cleanser', 250000, 100, '/img/Screen Shot 2024-07-03 at 05.32.14.png', 'Rửa mặt làm sạch và dịu nhẹ', '150ml', '2027-01-01', 'LSP03', 'Kho02'),
('SP038', 'Sữa Rửa Mặt Innisfree Moisture Gel Cleanser', 230000, 120, '/img/Screen Shot 2024-07-03 at 05.36.38.png', 'Rửa mặt cung cấp độ ẩm', '150ml', '2027-02-01', 'LSP03', 'Kho03'),
('SP039', 'Tẩy Trang Innisfree Green Tea Cleansing Oil', 290000, 95, '/img/Screen Shot 2024-07-03 at 06.05.30.png', 'Tẩy trang chiết xuất trà xanh', '100ml', '2027-03-01', 'LSP04', 'Kho01'),
('SP040', 'Tẩy Trang Innisfree Coconut Cleansing Oil', 380000, 75, '/img/Screen Shot 2024-07-03 at 06.11.32.png', 'Tẩy trang chiết xuất dừa', '200ml', '2027-04-01', 'LSP04', 'Kho02'),
('SP041', 'Mặt Nạ Giấy Innisfree Green Tea Moisture', 35000, 160, '/img/kcn.png', 'Mặt nạ cung cấp độ ẩm chiết xuất trà xanh', '1 miếng', '2025-12-01', 'LSP05', 'Kho02'),
('SP042', 'Mặt Nạ Giấy Innisfree Rose Moisture', 40000, 150, '/img/kcn2.png', 'Mặt nạ dưỡng ẩm chiết xuất hoa hồng', '1 miếng', '2025-11-01', 'LSP05', 'Kho03'),
('SP043', 'Mặt Nạ Giấy Innisfree Charcoal', 30000, 190, '/img/kcnvang.png', 'Mặt nạ làm sạch sâu chiết xuất than hoạt tính', '1 miếng', '2025-10-01', 'LSP05', 'Kho01'),
('SP044', 'Mặt Nạ Giấy Innisfree Lavender', 30000, 200, '/img/kcn3.png', 'Mặt nạ thư giãn chiết xuất oải hương', '1 miếng', '2025-09-01', 'LSP05', 'Kho02'),
('SP045', 'Kem Chống Nắng Innisfree Mineral UV Protection Cream', 320000, 95, '/img/Screen Shot 2024-07-03 at 05.28.41.png', 'Chống nắng khoáng chất cho da nhạy cảm', '50ml', '2026-02-01', 'LSP01', 'Kho03'),
('SP046', 'Kem Dưỡng Da Innisfree Jeju Orchid Enriched Cream', 400000, 110, '/img/Screen Shot 2024-07-03 at 05.18.22.png', 'Kem dưỡng ẩm chiết xuất hoa phong lan', '50ml', '2026-08-01', 'LSP02', 'Kho01'),
('SP047', 'Sữa Rửa Mặt Innisfree Bija Trouble Facial Foam', 250000, 85, '/img/Screen Shot 2024-07-03 at 05.32.14.png', 'Rửa mặt làm sạch cho da dầu', '150ml', '2027-01-01', 'LSP03', 'Kho02'),
('SP048', 'Sữa Rửa Mặt Innisfree Cucumber Cleansing Foam', 230000, 110, '/img/Screen Shot 2024-07-03 at 05.36.38.png', 'Rửa mặt chiết xuất dưa chuột', '150ml', '2027-02-01', 'LSP03', 'Kho03'),
('SP049', 'Tẩy Trang Innisfree Rice Water Cleansing Oil', 290000, 100, '/img/Screen Shot 2024-07-03 at 06.05.30.png', 'Tẩy trang chiết xuất nước gạo', '100ml', '2027-03-01', 'LSP04', 'Kho01'),
('SP050', 'Tẩy Trang Innisfree Tea Tree Cleansing Oil', 380000, 80, '/img/Screen Shot 2024-07-03 at 06.11.32.png', 'Tẩy trang chiết xuất tràm trà', '200ml', '2027-04-01', 'LSP04', 'Kho02');

UPDATE SanPham 
SET SoLuong = 200 
WHERE MaSP IN ('SP008', 'SP018', 'SP020');

select * from SanPham sp 
selc

INSERT INTO NhanVien (MaNV, HoTenNV, NgaySinhNV, GioiTinhNV, SDT_NV, Email_NV) VALUES
('NV001', N'Trần Minh Tuấn', '1990-01-15', N'Nam', '0912345678', 'tuantran90@gmail.com'),
('NV002', N'Nguyễn Thị Hằng', '1988-02-20', N'Nữ', '0912345679', 'hangnguyen88@gmail.com'),
('NV003', N'Phạm Văn Hải', '1992-03-10', N'Nam', '0912345680', 'haipham92@gmail.com'),
('NV004', N'Lê Thị Mai', '1995-04-25', N'Nữ', '0912345681', 'maille95@gmail.com'),
('NV005', N'Nguyễn Văn Dũng', '1985-05-30', N'Nam', '0912345682', 'dungnguyen85@gmail.com'),
('NV006', N'Trần Thị Lan', '1991-06-15', N'Nữ', '0912345683', 'lantran91@gmail.com'),
('NV007', N'Phạm Minh Quân', '1987-07-20', N'Nam', '0912345684', 'quanpham87@gmail.com'),
('NV008', N'Lê Văn Khoa', '1989-08-10', N'Nam', '0912345685', 'khoale89@gmail.com'),
('NV009', N'Trần Thị Yến', '1993-09-12', N'Nữ', '0912345686', 'yentran93@gmail.com'),
('NV010', N'Nguyễn Văn Bình', '1994-10-30', N'Nam', '0912345687', 'binhnguyen94@gmail.com'),
('NV011', N'Vũ Thị Bích', '1986-11-15', N'Nữ', '0912345688', 'bichvu86@gmail.com'),
('NV012', N'Nguyễn Văn Tài', '1990-12-01', N'Nam', '0912345689', 'tainv90@gmail.com'),
('NV013', N'Trần Văn Khánh', '1992-01-22', N'Nam', '0912345690', 'khanhtran92@gmail.com'),
('NV014', N'Nguyễn Thị Ngọc', '1988-02-18', N'Nữ', '0912345691', 'ngocnguyen88@gmail.com'),
('NV015', N'Lê Văn Đạt', '1995-03-05', N'Nam', '0912345692', 'datle95@gmail.com'),
('NV016', N'Nguyễn Thị Hương', '1991-04-26', N'Nữ', '0912345693', 'huongnguyen91@gmail.com'),
('NV017', N'Trần Văn Phúc', '1987-05-14', N'Nam', '0912345694', 'phuctran87@gmail.com'),
('NV018', N'Nguyễn Thị Duyên', '1993-06-30', N'Nữ', '0912345695', 'duyennguyen93@gmail.com'),
('NV019', N'Phạm Văn Lâm', '1989-07-19', N'Nam', '0912345696', 'lampham89@gmail.com'),
('NV020', N'Lê Thị Kim', '1994-08-23', N'Nữ', '0912345697', 'kimle94@gmail.com'),
('NV021', N'Trần Văn Tùng', '1990-09-01', N'Nam', '0912345698', 'tungtran90@gmail.com'),
('NV022', N'Nguyễn Thị Kiều', '1988-10-12', N'Nữ', '0912345699', 'kieunguyen88@gmail.com'),
('NV023', N'Phạm Văn Nam', '1992-11-05', N'Nam', '0912345700', 'nampham92@gmail.com'),
('NV024', N'Vũ Thị Tuyết', '1993-12-20', N'Nữ', '0912345701', 'tuyetvu93@gmail.com'),
('NV025', N'Lê Văn Sơn', '1986-01-30', N'Nam', '0912345702', 'sonle86@gmail.com'),
('NV026', N'Nguyễn Thị Phượng', '1994-02-15', N'Nữ', '0912345703', 'phuongnguyen94@gmail.com'),
('NV027', N'Trần Văn Cường', '1991-03-11', N'Nam', '0912345704', 'cuongtran91@gmail.com'),
('NV028', N'Nguyễn Thị Xuân', '1989-04-07', N'Nữ', '0912345705', 'xuannguyen89@gmail.com'),
('NV029', N'Lê Văn Vinh', '1995-05-20', N'Nam', '0912345706', 'vinhle95@gmail.com'),
('NV030', N'Phạm Thị Thảo', '1992-06-25', N'Nữ', '0912345707', 'thaopham92@gmail.com'),
('NV031', N'Trần Văn Bảo', '1987-07-30', N'Nam', '0912345708', 'baotran87@gmail.com'),
('NV032', N'Nguyễn Thị Kiệt', '1993-08-18', N'Nữ', '0912345709', 'kietnguyen93@gmail.com'),
('NV033', N'Lê Văn Sáng', '1990-09-22', N'Nam', '0912345710', 'sangle90@gmail.com'),
('NV034', N'Nguyễn Thị Nhung', '1988-10-10', N'Nữ', '0912345711', 'nhungnguyen88@gmail.com'),
('NV035', N'Trần Văn Trung', '1991-11-23', N'Nam', '0912345712', 'trungtran91@gmail.com'),
('NV036', N'Nguyễn Thị Hòa', '1994-12-11', N'Nữ', '0912345713', 'hoanguyen94@gmail.com'),
('NV037', N'Lê Văn Thi', '1986-01-02', N'Nam', '0912345714', 'thile86@gmail.com'),
('NV038', N'Vũ Thị Lệ', '1989-02-28', N'Nữ', '0912345715', 'levu89@gmail.com'),
('NV039', N'Trần Văn Phát', '1992-03-14', N'Nam', '0912345716', 'phattran92@gmail.com'),
('NV040', N'Nguyễn Thị Nguyệt', '1993-04-15', N'Nữ', '0912345717', 'nguyetnguyen93@gmail.com'),
('NV041', N'Lê Văn Thiên', '1987-05-17', N'Nam', '0912345718', 'thienle87@gmail.com'),
('NV042', N'Nguyễn Thị Tình', '1991-06-12', N'Nữ', '0912345719', 'tinhnguyen91@gmail.com'),
('NV043', N'Trần Văn Lộc', '1990-07-20', N'Nam', '0912345720', 'loctran90@gmail.com'),
('NV044', N'Phạm Thị Hằng', '1988-08-25', N'Nữ', '0912345721', 'hangpham88@gmail.com'),
('NV045', N'Nguyễn Văn Hưng', '1995-09-30', N'Nam', '0912345722', 'hungnguyen95@gmail.com'),
('NV046', N'Vũ Thị Trâm', '1992-10-15', N'Nữ', '0912345723', 'tramvu92@gmail.com'),
('NV047', N'Lê Văn Khải', '1989-11-11', N'Nam', '0912345724', 'khaile89@gmail.com'),
('NV048', N'Nguyễn Thị Hạnh', '1994-12-05', N'Nữ', '0912345725', 'hanhnguyen94@gmail.com'),
('NV049', N'Trần Văn Khoa', '1991-01-10', N'Nam', '0912345726', 'khoatran91@gmail.com'),
('NV050', N'Phạm Thị Ly', '1993-02-15', N'Nữ', '0912345727', 'lypham93@gmail.com');

INSERT INTO Kho (MaKho, TenKho, DiaChi) VALUES
(N'Kho01', N'Kho Quận 1', N'123 Nguyễn Thái Học, Phường Bến Thành, Quận 1, Hồ Chí Minh'),
(N'Kho02', N'Kho Quận 3', N'456 Lê Văn Sỹ, Phường 13, Quận 3, Hồ Chí Minh'),
(N'Kho03', N'Kho Quận 10', N'789 Trần Hưng Đạo, Phường 12, Quận 10, Hồ Chí Minh'),
(N'Kho04', N'Kho Quận 5', N'101 Đường Nguyễn Văn Cừ, Phường 1, Quận 5, Hồ Chí Minh'),
(N'Kho05', N'Kho Quận 4', N'112 Đường 3/2, Phường 4, Quận 10, Hồ Chí Minh'),
(N'Kho06', N'Kho Quận 6', N'145 Đường Nguyễn Thị Minh Khai, Phường 6, Quận 3, Hồ Chí Minh'),
(N'Kho07', N'Kho Dĩ An', N'145 Đại Lộ Bình Dương, Phường Bình Hoà, Thị xã Dĩ An, Bình Dương'),
(N'Kho08', N'Kho Thuận An', N'158 Đường Mỹ Phước - Tân Vạn, Phường Tân Bình, Thị xã Thuận An, Bình Dương'),
(N'Kho09', N'Kho Biên Hòa', N'169 Nguyễn Ái Quốc, Phường Tân Hiệp, Biên Hòa, Đồng Nai'),
(N'Kho10', N'Kho Long Thành', N'180 Đường Quốc Lộ 51, Xã Long Thành, Huyện Long Thành, Đồng Nai');

INSERT INTO PhieuNhap (MaPN, MaNV, TenPhieuNhap, NgayLap, TongTienNhap) VALUES
('PN01', 'NV001', 'NHAPHANG0124', '2024-01-20', 30000000),
('PN02', 'NV002', 'NHAPHANG0224', '2024-02-20', 45000000),
('PN03', 'NV003', 'NHAPHANG0324', '2024-03-20', 60000000),
('PN04', 'NV004', 'NHAPHANG0424', '2024-04-20', 35000000),
('PN05', 'NV005', 'NHAPHANG0524', '2024-05-20', 42000000),
('PN06', 'NV001', 'NHAPHANG0624', '2024-06-20', 55000000),
('PN07', 'NV002', 'NHAPHANG0724', '2024-07-20', 47000000),
('PN08', 'NV003', 'NHAPHANG0824', '2024-08-20', 38000000),
('PN09', 'NV004', 'NHAPHANG0924', '2024-09-20', 49000000),
('PN10', 'NV005', 'NHAPHANG1024', '2024-10-20', 32000000),
('PN11', 'NV001', 'NHAPHANG1124', '2024-11-20', 41000000),
('PN12', 'NV002', 'NHAPHANG1224', '2024-12-20', 28000000),
('PN13', 'NV003', 'NHAPHANG1324', '2024-01-01', 60000000),
('PN14', 'NV004', 'NHAPHANG1424', '2024-01-02', 33000000),
('PN15', 'NV005', 'NHAPHANG1524', '2024-01-03', 50000000),
('PN16', 'NV001', 'NHAPHANG1624', '2024-01-04', 61000000),
('PN17', 'NV002', 'NHAPHANG1724', '2024-01-05', 42000000),
('PN18', 'NV003', 'NHAPHANG1824', '2024-01-06', 39000000),
('PN19', 'NV004', 'NHAPHANG1924', '2024-01-07', 47000000),
('PN20', 'NV005', 'NHAPHANG2024', '2024-01-08', 55000000);

INSERT INTO CTPhieuNhap (MaPN, MaSP, SoLuongNhap, DonGiaNhap) VALUES
('PN01', 'SP001', 100, 150000),
('PN01', 'SP002', 50, 200000),
('PN01', 'SP003', 70, 120000),
('PN02', 'SP001', 80, 160000),
('PN02', 'SP004', 60, 180000),
('PN03', 'SP002', 90, 170000),
('PN03', 'SP003', 40, 140000),
('PN04', 'SP001', 110, 155000),
('PN04', 'SP005', 30, 220000),
('PN05', 'SP002', 75, 165000),
('PN05', 'SP003', 50, 130000),
('PN06', 'SP004', 100, 195000),
('PN06', 'SP001', 55, 145000),
('PN07', 'SP002', 85, 175000),
('PN08', 'SP003', 60, 125000),
('PN09', 'SP005', 90, 210000),
('PN10', 'SP001', 40, 150000),
('PN11', 'SP004', 70, 200000),
('PN12', 'SP002', 95, 160000),
('PN13', 'SP003', 80, 140000),
('PN14', 'SP005', 65, 220000);

INSERT INTO PhieuXuat (MaPX, MaNV, TenPX, NgayLap, TongTienXuat) VALUES
('PX01', 'NV001', 'PHIEUXUATDH007', '2024-01-20', 29000000),
('PX02', 'NV002', 'PHIEUXUATDH008', '2024-02-20', 42000000),
('PX03', 'NV003', 'PHIEUXUATDH009', '2024-03-20', 58000000),
('PX04', 'NV004', 'PHIEUXUATDH010', '2024-04-20', 34000000),
('PX05', 'NV005', 'PHIEUXUATDH011', '2024-05-20', 46000000),
('PX06', 'NV001', 'PHIEUXUATDH012', '2024-06-20', 54000000),
('PX07', 'NV002', 'PHIEUXUATDH013', '2024-07-20', 48000000),
('PX08', 'NV003', 'PHIEUXUATDH014', '2024-08-20', 37000000),
('PX09', 'NV004', 'PHIEUXUATDH015', '2024-09-20', 49000000),
('PX10', 'NV005', 'PHIEUXUATDH016', '2024-10-20', 31000000),
('PX11', 'NV001', 'PHIEUXUATDH017', '2024-11-20', 40000000),
('PX12', 'NV002', 'PHIEUXUATDH018', '2024-12-20', 29000000),
('PX13', 'NV003', 'PHIEUXUATDH019', '2024-01-01', 58000000),
('PX14', 'NV004', 'PHIEUXUATDH020', '2024-01-02', 33000000),
('PX15', 'NV005', 'PHIEUXUATDH021', '2024-01-03', 51000000),
('PX16', 'NV001', 'PHIEUXUATDH022', '2024-01-04', 63000000),
('PX17', 'NV002', 'PHIEUXUATDH023', '2024-01-05', 43000000),
('PX18', 'NV003', 'PHIEUXUATDH024', '2024-01-06', 39000000),
('PX19', 'NV004', 'PHIEUXUATDH025', '2024-01-07', 48000000),
('PX20', 'NV005', 'PHIEUXUATDH026', '2024-01-08', 56000000);

INSERT INTO Quyen (MaQuyen, TenQuyen) VALUES
('Q1', N'Admin'),
('Q2', N'Quản Lý'),
('Q3', N'NV Bán Hàng'),
('Q4', N'NV Kho'),
('Q5', N'Khách hàng');

INSERT INTO TaiKhoan (MaTK, TenDN, MatKhau, HoTen, Email, PhanQuyen) VALUES
('TK1', 'hoanguyen03', '123456', N'Lê Nguyễn Hoàng Uyên', 'hoanuyen03@gmail.com', N'Khách hàng'),
('TK2', 'kieumy22', 'Kieumy@2022', N'Nguyễn Thị Kim Mỹ', 'kieumy22@gmail.com', N'Admin'),
('TK3', 'nguyenthanh01', 'Ngt1234@!', N'Nguyễn Thành', 'nguyenthanh01@gmail.com', N'Quản Lý'),
('TK4', 'trinhthanh02', 'Trinh@5678', N'Trịnh Thành', 'trinhthanh02@gmail.com', N'NV Bán Hàng'),
('TK5', 'thanhdat03', 'Dat@91011', N'Thành Đạt', 'thanhdat03@gmail.com', N'NV Kho'),
('TK6', 'quynhchi04', 'Quynh@1213', N'Quỳnh Chí', 'quynhchi04@gmail.com', N'Khách hàng'),
('TK7', 'minhhoang05', 'Minh@1415', N'Minh Hoàng', 'minhhoang05@gmail.com', N'NV Bán Hàng'),
('TK8', 'thuyvan06', 'Thuy@1617', N'Thủy Vân', 'thuyvan06@gmail.com', N'Khách hàng'),
('TK9', 'tuananh07', 'Tuan@1819', N'Tuấn Anh', 'tuananh07@gmail.com', N'Khách hàng'),
('TK10', 'kimanh08', 'Kim@2021', N'Kim Anh', 'kimanh08@gmail.com', N'NV Kho'),
('TK11', 'hoanglan09', 'Hoang@2223', N'Hoàng Lan', 'hoanglan09@gmail.com', N'Khách hàng'),
('TK12', 'thanhbinh10', 'Binh@2425', N'Thành Bình', 'thanhbinh10@gmail.com', N'Khách hàng'),
('TK13', 'huonggiang11', 'Huong@2627', N'Hương Giang', 'huonggiang11@gmail.com', N'Quản Lý'),
('TK14', 'vietanh12', 'Viet@2829', N'Việt Anh', 'vietanh12@gmail.com', N'NV Bán Hàng'),
('TK15', 'nhutquang13', 'Nhut@3031', N'Nhật Quang', 'nhutquang13@gmail.com', N'Khách hàng'),
('TK16', 'vananh14', 'Van@3233', N'Vân Anh', 'vananh14@gmail.com', N'Khách hàng'),
('TK17', 'haiduong15', 'Hai@3435', N'Hải Dương', 'haiduong15@gmail.com', N'NV Kho'),
('TK18', 'tuanminh16', 'Minh@3637', N'Tuấn Minh', 'tuanminh16@gmail.com', N'Khách hàng'),
('TK19', 'hoangcuong17', 'Cuong@3839', N'Hoàng Cường', 'hoangcuong17@gmail.com', N'Khách hàng'),
('TK20', 'kimcuong18', 'Cuong@4041', N'Kim Cường', 'kimcuong18@gmail.com', N'Khách hàng');

INSERT INTO CTQuyen (MaQuyen, MaTK) VALUES
('Q5', 'TK1'),
('Q1', 'TK2'),
('Q3', 'TK3'),
('Q4', 'TK4'),
('Q5', 'TK5'),
('Q1', 'TK6'),
('Q2', 'TK7'),
('Q3', 'TK8'),
('Q4', 'TK9'),
('Q5', 'TK10'),
('Q1', 'TK11'),
('Q2', 'TK12'),
('Q3', 'TK13'),
('Q4', 'TK14'),
('Q5', 'TK15'),
('Q1', 'TK16'),
('Q2', 'TK17'),
('Q3', 'TK18'),
('Q4', 'TK19'),
('Q5', 'TK20');

INSERT INTO HoaDon (MaHD, HoTenKH, DiaDiemGH, SDTNguoiDH, NgayDH, PhuongThucThanhToan, TinhTrangDDH, TongTien) VALUES
('HD001', N'Trần Minh Khôi', N'123 Lê Văn Sỹ, Quận 3, TP.HCM', '0901234567', '2024-12-20', 'COD', N'Chờ thanh toán', 810000),
('HD002', N'Nguyễn Ngọc Bích', N'456 Nguyễn Thị Minh Khai, Quận 1, TP.HCM', '0912345678', '2024-12-19', 'Ngân hàng', N'Đã thanh toán', 1200000),
('HD003', N'Lê Thành Đạt', N'789 Trần Hưng Đạo, Quận 5, TP.HCM', '0923456789', '2024-12-18', 'Ví điện tử', N'Đã thanh toán', 400000),
('HD004', N'Phạm Hải Yến', N'321 Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM', '0934567890', '2024-12-17', 'Ngân hàng', N'Đã thanh toán', 840000),
('HD005', N'Trần Bảo Ngọc', N'654 Nguyễn Huệ, Quận 1, TP.HCM', '0945678901', '2024-12-16', 'COD', N'Chờ thanh toán', 480000),
('HD006', N'Ngô Diễm My', N'987 Lê Thánh Tôn, Quận 1, TP.HCM', '0956789012', '2024-12-15', 'Ví điện tử', N'Đã thanh toán', 580000),
('HD007', N'Vũ Quang Huy', N'159 Phan Đăng Lưu, Quận Bình Thạnh, TP.HCM', '0967890123', '2024-12-14', 'COD', N'Chờ thanh toán', 700000),
('HD008', N'Đỗ Minh Tâm', N'753 Trương Định, Quận 1, TP.HCM', '0978901234', '2024-12-13', 'Ngân hàng', N'Đã thanh toán', 850000),
('HD009', N'Nguyễn Văn An', N'246 Đường số 3, Phường Bình An, Quận 2, TP.HCM', '0989012345', '2024-12-12', 'Ví điện tử', N'Đã thanh toán', 600000),
('HD010', N'Lê Thị Phương', N'135 Nguyễn Thị Thập, Quận 7, TP.HCM', '0990123456', '2024-12-11', 'COD', N'Chờ thanh toán', 840000),
('HD011', N'Trương Minh Tuấn', N'246 Lê Văn Việt, Quận 9, TP.HCM', '0902345678', '2024-12-10', 'Ngân hàng', N'Đã thanh toán', 210000),
('HD012', N'Nguyễn Thị Hằng', N'357 Lê Đức Thọ, Quận Gò Vấp, TP.HCM', '0913456789', '2024-12-09', 'Ví điện tử', N'Đã thanh toán', 240000),
('HD013', N'Lâm Thế Vinh', N'468 Nguyễn Văn Cừ, Quận 5, TP.HCM', '0924567890', '2024-12-08', 'Ngân hàng', N'Đã thanh toán', 630000),
('HD014', N'Bùi Thị Như', N'579 Trần Não, Quận 2, TP.HCM', '0935678901', '2024-12-07', 'COD', N'Chờ thanh toán', 450000),
('HD015', N'Phan Văn Hoàng', N'159 Phạm Ngũ Lão, Quận 1, TP.HCM', '0946789123', '2024-12-06', 'COD', N'Đã thanh toán', 320000),
('HD016', N'Nguyễn Thị Hoa', N'753 Võ Văn Ngân, Quận Thủ Đức, TP.HCM', '0957891234', '2024-12-05', 'Ví điện tử', N'Đã thanh toán', 780000),
('HD017', N'Phạm Văn Tùng', N'864 Lý Thường Kiệt, Quận Tân Bình, TP.HCM', '0968902345', '2024-12-04', 'Ngân hàng', N'Đã thanh toán', 560000),
('HD018', N'Lê Văn Tuấn', N'753 Trường Sa, Quận Phú Nhuận, TP.HCM', '0979013456', '2024-12-03', 'COD', N'Chờ thanh toán', 480000),
('HD019', N'Ngô Quang Hải', N'258 Cách Mạng Tháng Tám, Quận 10, TP.HCM', '0980123456', '2024-12-02', 'Ví điện tử', N'Đã thanh toán', 650000),
('HD020', N'Võ Thị Mai', N'369 Hai Bà Trưng, Quận 3, TP.HCM', '0991234567', '2024-12-01', 'Ngân hàng', N'Đã thanh toán', 900000);

INSERT INTO CTHoaDon (MaHD, MaSP, TenSP, SoLuongDat, DonGia) VALUES
('HD001', 'SP001', N'Kem Chống Nắng Innisfree Tone Up No Sebum SPF50+/PA++++', 2, 300000),
('HD001', 'SP007', N'Sữa rửa mặt Innisfree Green Tea Foam Cleanser', 1, 210000),
('HD002', 'SP002', N'Kem Chống Nắng Innisfree Highlight No Sebum SPF50+/PA++++', 2, 450000),
('HD002', 'SP005', N'Kem Dưỡng Da Hoa Anh Đào Innisfree Jeju Cherry Blossom Tone Up', 1, 300000),
('HD003', 'SP003', N'Kem Chống Nắng Innisfree Intensive Long-Lasting Sunscreen', 1, 400000),
('HD004', 'SP004', N'Kem Chống Nắng Innisfree da nhạy cảm Long-Lasting Sunscreen', 1, 300000),
('HD004', 'SP006', N'Kem Dưỡng Innisfree Trà Xanh Green Tea Balancing Cream EX 50mL', 2, 270000),
('HD005', 'SP008', N'Sữa Rửa Mặt Innisfree Jeju Pomegranate Foam', 2, 240000),
('HD006', 'SP009', N'Tẩy Trang Innisfree Green Tea Cleansing Water', 1, 280000),
('HD006', 'SP001', N'Kem Chống Nắng Innisfree Tone Up No Sebum SPF50+/PA++++', 1, 300000),
('HD007', 'SP010', N'Nước tẩy trang Innisfree Sea Salt Cleansing Water', 2, 350000),
('HD008', 'SP002', N'Kem Chống Nắng Innisfree Highlight No Sebum SPF50+/PA++++', 1, 450000),
('HD008', 'SP003', N'Kem Chống Nắng Innisfree Intensive Long-Lasting Sunscreen', 1, 400000),
('HD009', 'SP004', N'Kem Chống Nắng Innisfree da nhạy cảm Long-Lasting Sunscreen', 2, 300000),
('HD010', 'SP005', N'Kem Dưỡng Da Hoa Anh Đào Innisfree Jeju Cherry Blossom Tone Up', 1, 300000),
('HD010', 'SP006', N'Kem Dưỡng Innisfree Trà Xanh Green Tea Balancing Cream EX 50mL', 2, 270000),
('HD011', 'SP007', N'Sữa rửa mặt Innisfree Green Tea Foam Cleanser', 1, 210000),
('HD012', 'SP008', N'Sữa Rửa Mặt Innisfree Jeju Pomegranate Foam', 1, 240000),
('HD013', 'SP009', N'Tẩy Trang Innisfree Green Tea Cleansing Water', 1, 280000),
('HD013', 'SP010', N'Nước tẩy trang Innisfree Sea Salt Cleansing Water', 1, 350000);

CREATE VIEW BaoCaoTonKho AS
SELECT 
    p.MaSP,
    p.TenSP,
    COALESCE(SUM(ct.SoLuongDat * 10), 0) AS SoLuongBan,  -- Dùng COALESCE để thay thế NULL bằng 0
    COALESCE(SUM(ct.SoLuongDat * ct.DonGia * 10 ), 0) AS DoanhThu  -- Tương tự cho doanh thu
FROM 
    SanPham p  -- Giả sử đây là bảng sản phẩm
LEFT JOIN 
    CTHoaDon ct ON p.MaSP = ct.MaSP
GROUP BY 
    p.MaSP, p.TenSP;
   
   CREATE VIEW BCTK AS
SELECT 
    sp.MaSP,
    sp.TenSP,
    sp.SoLuong AS SoLuongDauKy,
    COALESCE(SUM(cpn.SoLuongNhap), 0) AS SoLuongNhap,
    COALESCE(SUM(cpx.SoLuongXuat), 0) AS SoLuongXuat,
    (sp.SoLuong + COALESCE(SUM(cpn.SoLuongNhap), 0) - COALESCE(SUM(cpx.SoLuongXuat), 0)) AS TonKhoCuoiKi,
    ((sp.SoLuong + COALESCE(SUM(cpn.SoLuongNhap), 0) - COALESCE(SUM(cpx.SoLuongXuat), 0)) * sp.GiaBan) AS TongGiaTienTonKho
FROM 
    SanPham sp
LEFT JOIN 
    CTPhieuNhap cpn ON sp.MaSP = cpn.MaSP
LEFT JOIN 
    CTPhieuXuat cpx ON sp.MaSP = cpx.MaSP
GROUP BY 
    sp.MaSP, sp.TenSP, sp.SoLuong, sp.GiaBan;
    
   select * from BCTK