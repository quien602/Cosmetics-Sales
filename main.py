# Importing flask module in the project is mandatory
# An object of Flask class is our WSGI application.
from flask import Flask, render_template, request, url_for, redirect, jsonify
from flask_sqlalchemy import SQLAlchemy
import subprocess

from flask import Flask, render_template, request, redirect, url_for, flash
import pandas as pd

app = Flask(__name__)
app.secret_key = 'hehe'  # Thay đổi chuỗi này thành một giá trị bí mật



from werkzeug.utils import secure_filename
import os





# Định nghĩa thư mục lưu trữ hình ảnh
app.secret_key = 'hehe'  # Thay đổi chuỗi này thành một giá trị bí mật

# Định nghĩa thư mục lưu trữ hình ảnh
UPLOAD_FOLDER = './tmp'  # Thư mục lưu trữ hình ảnh trong thư mục gốc của ứng dụng

# Đảm bảo thư mục lưu trữ tồn tại
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Cấu hình ứng dụng
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

from flask_mail import Mail, Message

# Định nghĩa các phần mở rộng tệp tin hợp lệ
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

def allowed_file(filename):
    # Kiểm tra phần mở rộng tệp tin hợp lệ
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Khởi tạo ứng dụng Flask
app = Flask(__name__,
            static_url_path='', 
            static_folder='static',
            template_folder='templates')

# Cấu hình kết nối đến SQL Server
user = "sa"
pin = "123"
host = "localhost"
db_name = "QLBH"
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{user}:{pin}@{host}:3307/{db_name}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Cấu hình Flask-Mail
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'hoanuyen03@gmail.com'
app.config['MAIL_PASSWORD'] = 'hoanguyen03'
app.config['MAIL_DEFAULT_SENDER'] = 'innifreevn@gmail.com'

mail = Mail(app)

# Khởi tạo SQLAlchemy
db = SQLAlchemy(app)

from flask import flash


# Định nghĩa mô hình Khách Hàng
class KhachHang(db.Model):
    __tablename__ = 'KhachHang'
    
    MaKH = db.Column(db.String, primary_key=True)
    HoTenKH = db.Column(db.String, nullable=False)
    NgaySinhKH = db.Column(db.Date, nullable=False)
    GioiTinhKH = db.Column(db.String, nullable=False)
    SDT_KH = db.Column(db.String, nullable=False)
    Email_KH = db.Column(db.String, nullable=False)
    DiaChi_KH = db.Column(db.String, nullable=True)

# Route cho trang chính
#@app.route('/customers')
#def index():
#    return render_template('QuanLyKhachHang.html')  # Thay đổi tên tệp ở đây

# Route thêm khách hàng
# Trang danh sách khách hàng
@app.route('/customers')
def customers():
    customers = KhachHang.query.all()  # Lấy danh sách khách hàng từ bảng KhachHang
    return render_template('QuanLyKhachHang.html', customers=customers)

# Thêm khách hàng
@app.route('/add', methods=['POST'])
def add_customer():
    new_customer = KhachHang(
        MaKH=request.form['MaKH'],
        HoTenKH=request.form['HoTenKH'],
        NgaySinhKH=request.form['NgaySinhKH'],
        GioiTinhKH=request.form['GioiTinhKH'],
        SDT_KH=request.form['SDT_KH'],
        Email_KH=request.form['Email_KH'],
        DiaChi_KH=request.form['DiaChi_KH']
    )
    db.session.add(new_customer)
    db.session.commit()
    return redirect(url_for('customers'))

# Cập nhật khách hàng
@app.route('/update', methods=['POST'])
def update_customer():
    customer = KhachHang.query.get(request.form['MaKH'])
    customer.HoTenKH = request.form['HoTenKH']
    customer.NgaySinhKH = request.form['NgaySinhKH']
    customer.GioiTinhKH = request.form['GioiTinhKH']
    customer.SDT_KH = request.form['SDT_KH']
    customer.Email_KH = request.form['Email_KH']
    customer.DiaChi_KH = request.form['DiaChi_KH']
    db.session.commit()
    return redirect(url_for('customers'))

# Xóa khách hàng
@app.route('/delete/<string:MaKH>', methods=['GET'])
def delete_customer(MaKH):
    customer = KhachHang.query.get(MaKH)
    db.session.delete(customer)
    db.session.commit()
    return redirect(url_for('customers'))

class LoaiSanPham(db.Model):
    __tablename__ = 'LoaiSanPham'
    
    MaLoaiSP = db.Column(db.String, primary_key=True)
    TenLoaiSP = db.Column(db.String, nullable=False)

# Route cho trang chính
@app.route('/products', methods=['GET', 'POST'])
def products():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        products = LoaiSanPham.query.filter(LoaiSanPham.TenLoaiSP.like(f'%{search_query}%')).all()  # Tìm kiếm theo tên loại sản phẩm
    else:
        products = LoaiSanPham.query.all()  # Lấy danh sách sản phẩm nếu không có tìm kiếm
    return render_template('QuanLyLoaiSP.html', products=products)

# Thêm loại sản phẩm
@app.route('/add_product', methods=['POST'])
def add_product():
    new_product = LoaiSanPham(
        MaLoaiSP=request.form['MaLoaiSP'],
        TenLoaiSP=request.form['TenLoaiSP']
    )
    db.session.add(new_product)
    db.session.commit()
    return redirect(url_for('products'))

# Cập nhật loại sản phẩm
@app.route('/update_product', methods=['POST'])
def update_product():
    product = LoaiSanPham.query.get(request.form['MaLoaiSP'])
    product.TenLoaiSP = request.form['TenLoaiSP']
    db.session.commit()
    return redirect(url_for('products'))

# Xóa loại sản phẩm
@app.route('/delete_product/<string:MaLoaiSP>', methods=['GET'])
def delete_product(MaLoaiSP):
    product = LoaiSanPham.query.get(MaLoaiSP)
    db.session.delete(product)
    db.session.commit()
    return redirect(url_for('products'))

class NhanVien(db.Model):
    __tablename__ = 'NhanVien'
    
    MaNV = db.Column(db.String, primary_key=True)
    HoTenNV = db.Column(db.String, nullable=False)
    NgaySinhNV = db.Column(db.Date, nullable=False)
    GioiTinhNV = db.Column(db.String, nullable=False)
    SDT_NV = db.Column(db.String, nullable=False)
    Email_NV = db.Column(db.String, nullable=False)

# Route cho trang chính
@app.route('/employees', methods=['GET', 'POST'])
def employees():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        employees = NhanVien.query.filter(NhanVien.HoTenNV.like(f'%{search_query}%')).all()  # Tìm kiếm theo họ tên nhân viên
    else:
        employees = NhanVien.query.all()  # Lấy danh sách nhân viên nếu không có tìm kiếm
    return render_template('QuanLyNhanVien.html', employees=employees)

# Thêm nhân viên
@app.route('/add_employee', methods=['POST'])
def add_employee():
    new_employee = NhanVien(
        MaNV=request.form['MaNV'],
        HoTenNV=request.form['HoTenNV'],
        NgaySinhNV=request.form['NgaySinhNV'],
        GioiTinhNV=request.form['GioiTinhNV'],
        SDT_NV=request.form['SDT_NV'],
        Email_NV=request.form['Email_NV']
    )
    db.session.add(new_employee)
    db.session.commit()
    return redirect(url_for('employees'))

# Cập nhật thông tin nhân viên

@app.route('/update_employee', methods=['POST'])
def update_employee():
    employee = NhanVien.query.get(request.form['MaNV'])
    if employee:
        employee.HoTenNV = request.form['HoTenNV']
        employee.NgaySinhNV = request.form['NgaySinhNV']
        employee.GioiTinhNV = request.form['GioiTinhNV']
        employee.SDT_NV = request.form['SDT_NV']
        employee.Email_NV = request.form['Email_NV']
        db.session.commit()
        flash('Cập nhật thông tin nhân viên thành công!', 'success')
    else:
        flash('Không tìm thấy nhân viên để cập nhật.', 'error')
    return redirect(url_for('employees'))

# Xóa nhân viên
@app.route('/delete_employee/<string:MaNV>', methods=['GET'])
def delete_employee(MaNV):
    employee = NhanVien.query.get(MaNV)
    db.session.delete(employee)
    db.session.commit()
    return redirect(url_for('employees'))

class Kho(db.Model):
    __tablename__ = 'Kho'
    
    MaKho = db.Column(db.String, primary_key=True)
    TenKho = db.Column(db.String, nullable=False)
    DiaChi = db.Column(db.String, nullable=False)
    # Route cho trang chính
@app.route('/warehouses', methods=['GET', 'POST'])
def warehouses():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        warehouses = Kho.query.filter(Kho.TenKho.like(f'%{search_query}%')).all()  # Tìm kiếm theo tên kho
    else:
        warehouses = Kho.query.all()  # Lấy danh sách kho nếu không có tìm kiếm
    return render_template('QuanLyKho.html', warehouses=warehouses)
# Thêm kho
@app.route('/add_warehouse', methods=['POST'])
def add_warehouse():
    new_warehouse = Kho(
        MaKho=request.form['MaKho'],
        TenKho=request.form['TenKho'],
        DiaChi=request.form['DiaChi']
    )
    db.session.add(new_warehouse)
    db.session.commit()
    return redirect(url_for('warehouses'))

# Cập nhật thông tin kho
@app.route('/update_warehouse', methods=['POST'])
def update_warehouse():
    warehouse = Kho.query.get(request.form['MaKho'])
    if warehouse:
        warehouse.TenKho = request.form['TenKho']
        warehouse.DiaChi = request.form['DiaChi']
        db.session.commit()
        flash('Cập nhật thông tin kho thành công!', 'success')
    else:
        flash('Không tìm thấy kho để cập nhật.', 'error')
    return redirect(url_for('warehouses'))

# Xóa kho
@app.route('/delete_warehouse/<string:MaKho>', methods=['GET'])
def delete_warehouse(MaKho):
    warehouse = Kho.query.get(MaKho)
    if warehouse:
        db.session.delete(warehouse)
        db.session.commit()
        if Kho.query.get(MaKho) is None:  # Kiểm tra lại sau khi xoá
            return 'Kho đã được xoá thành công.', 200
        else:
            return 'Lỗi khi xoá kho.', 500
    else:
        return 'Không tìm thấy kho với mã này.', 404


class SanPham(db.Model):
    __tablename__ = 'SanPham'
    
    MaSP = db.Column(db.String, primary_key=True)
    TenSP = db.Column(db.String, nullable=False)
    GiaBan = db.Column(db.Float, nullable=False)
    SoLuong = db.Column(db.Integer, nullable=False)
    MaLoaiSP = db.Column(db.String, nullable=False)
    MaKho = db.Column(db.String, nullable=False)
    HinhAnh = db.Column(db.String, nullable=False)

@app.route('/sanpham', methods=['GET', 'POST'])
def sanpham():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        sanpham_list = SanPham.query.filter(SanPham.TenSP.like(f'%{search_query}%')).all()  # Tìm kiếm theo tên sản phẩm
    else:
        sanpham_list = SanPham.query.all()  # Lấy danh sách sản phẩm nếu không có tìm kiếm

    print(sanpham_list)  # Debug: In ra danh sách sản phẩm
    loai_san_pham = LoaiSanPham.query.all()  # Lấy danh sách loại sản phẩm
    kho = Kho.query.all()  # Lấy danh sách kho
    return render_template('QuanLySanPham.html', sanpham=sanpham_list, loai_san_pham=loai_san_pham, kho=kho)

@app.route('/add_sanpham', methods=['POST'])
def add_sanpham():
    try:
        # Lấy dữ liệu từ form
        MaSP = request.form.get('MaSP')
        TenSP = request.form.get('TenSP')
        GiaBan = request.form.get('GiaBan')
        SoLuong = request.form.get('SoLuong')
        MaLoaiSP = request.form.get('MaLoaiSP')
        MaKho = request.form.get('MaKho')

        # Kiểm tra xem các trường cần thiết có được cung cấp không
        if not all([MaSP, TenSP, GiaBan, SoLuong, MaLoaiSP, MaKho]):
            flash('Missing required fields')
            return redirect(request.url)

        # Xử lý file upload
        file = request.files.get('HinhAnh')
        if file and allowed_file(file.filename):
            # Lưu file vào thư mục UPLOAD_FOLDER
            filename = secure_filename(file.filename)
            file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(file_path)

            # Trả về thông báo thành công và thông tin hình ảnh
            flash('File uploaded successfully!')
            return jsonify({
                'success': True,
                'message': 'File uploaded successfully',
                'image_url': url_for('static', filename=f'{UPLOAD_FOLDER}/{filename}')
            })

        else:
            flash('No file uploaded or file type is not allowed.')
            return redirect(request.url)

    except Exception as e:
        # Xử lý lỗi
        flash(str(e))
        return redirect(request.url)

# Cập nhật thông tin sản phẩm
@app.route('/update_sanpham', methods=['POST'])
def update_sanpham():
    product = SanPham.query.get(request.form['MaSP'])
    if product:
        product.TenSP = request.form['TenSP']
        product.GiaBan = request.form['GiaBan']
        product.SoLuong = request.form['SoLuong']
        product.MaLoaiSP = request.form['MaLoaiSP']
        product.MaKho = request.form['MaKho']
        product.HinhAnh = request.form['HinhAnh']
        db.session.commit()
        flash('Cập nhật thông tin sản phẩm thành công!', 'success')
    else:
        flash('Không tìm thấy sản phẩm để cập nhật.', 'error')
    return redirect(url_for('sanpham'))

# Xóa sản phẩm
@app.route('/delete_sanpham/<maSP>', methods=['DELETE'])
def delete_sanpham(maSP):
    product = SanPham.query.filter_by(MaSP=maSP).first()  # Giả sử SanPham là model cho bảng sản phẩm
    if product:
        db.session.delete(product)
        db.session.commit()
        return '', 204  # Trả về mã trạng thái 204 No Content
    return '', 404  # Trả về mã trạng thái 404 Not Found nếu không tìm thấy sản phẩm


class PhieuNhap(db.Model):
    __tablename__ = 'PhieuNhap'
    
    MaPN = db.Column(db.String, primary_key=True)
    MaNV = db.Column(db.String, nullable=False)
    TenPhieuNhap = db.Column(db.String, nullable=False)
    NgayLap = db.Column(db.Date, nullable=False)
    TongTienNhap = db.Column(db.Float, nullable=False)

# Route cho trang chính phiếu nhập
@app.route('/phieunhap', methods=['GET', 'POST'])
def phieunhap():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        phieu_nhap_list = PhieuNhap.query.filter(PhieuNhap.TenPhieuNhap.like(f'%{search_query}%')).all()  # Tìm kiếm theo tên phiếu nhập
    else:
        phieu_nhap_list = PhieuNhap.query.all()  # Lấy danh sách phiếu nhập nếu không có tìm kiếm
    return render_template('QuanLyPhieuNhap.html', phieu_nhap_list=phieu_nhap_list)

# Thêm phiếu nhập
@app.route('/add_phieunhap', methods=['POST'])
def add_phieunhap():
    new_phieunhap = PhieuNhap(
        MaPN=request.form['MaPN'],
        MaNV=request.form['MaNV'],
        TenPhieuNhap=request.form['TenPhieuNhap'],
        NgayLap=request.form['NgayLap'],  # Đảm bảo định dạng ngày đúng
        TongTienNhap=float(request.form['TongTienNhap'])
    )
    db.session.add(new_phieunhap)
    db.session.commit()
    flash('Thêm phiếu nhập thành công!', 'success')
    return redirect(url_for('phieunhap'))

# Cập nhật thông tin phiếu nhập
@app.route('/update_phieunhap', methods=['POST'])
def update_phieunhap():
    phieu = PhieuNhap.query.get(request.form['MaPN'])
    if phieu:
        phieu.MaNV = request.form['MaNV']
        phieu.TenPhieuNhap = request.form['TenPhieuNhap']
        phieu.NgayLap = request.form['NgayLap']  # Đảm bảo định dạng ngày đúng
        phieu.TongTienNhap = float(request.form['TongTienNhap'])
        db.session.commit()
        flash('Cập nhật thông tin phiếu nhập thành công!', 'success')
    else:
        flash('Không tìm thấy phiếu nhập để cập nhật.', 'error')
    return redirect(url_for('phieunhap'))

# Xóa phiếu nhập
@app.route('/delete_phieunhap/<string:MaPN>', methods=['GET'])
def delete_phieunhap(MaPN):
    phieu = PhieuNhap.query.get(MaPN)
    if phieu:
        db.session.delete(phieu)
        db.session.commit()
        flash('Phiếu nhập đã được xoá thành công!', 'success')
    else:
        flash('Không tìm thấy phiếu nhập với mã này.', 'error')
    return redirect(url_for('phieunhap'))

class PhieuXuat(db.Model):
    __tablename__ = 'PhieuXuat'
    
    MaPX = db.Column(db.String, primary_key=True)
    MaNV = db.Column(db.String, nullable=False)
    TenPX = db.Column(db.String, nullable=False)
    NgayLap = db.Column(db.Date, nullable=False)
    TongTienXuat = db.Column(db.Float, nullable=False)

# Route cho trang chính phiếu xuất
@app.route('/phieuxuat', methods=['GET', 'POST'])
def phieuxuat():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        phieu_xuat_list = PhieuXuat.query.filter(PhieuXuat.TenPX.like(f'%{search_query}%')).all()  # Tìm kiếm theo tên phiếu xuất
    else:
        phieu_xuat_list = PhieuXuat.query.all()  # Lấy danh sách phiếu xuất nếu không có tìm kiếm
    return render_template('QuanLyPhieuXuat.html', phieu_xuat_list=phieu_xuat_list)

# Thêm phiếu xuất
@app.route('/add_phieuxuat', methods=['POST'])
def add_phieuxuat():
    new_phieuxuat = PhieuXuat(
        MaPX=request.form['MaPX'],
        MaNV=request.form['MaNV'],
        TenPX=request.form['TenPX'],
        NgayLap=request.form['NgayLap'],  # Đảm bảo định dạng ngày đúng
        TongTienXuat=float(request.form['TongTienXuat'])
    )
    db.session.add(new_phieuxuat)
    db.session.commit()
    flash('Thêm phiếu xuất thành công!', 'success')
    return redirect(url_for('phieuxuat'))

# Cập nhật thông tin phiếu xuất
@app.route('/update_phieuxuat', methods=['POST'])
def update_phieuxuat():
    phieu = PhieuXuat.query.get(request.form['MaPX'])
    if phieu:
        phieu.MaNV = request.form['MaNV']
        phieu.TenPX = request.form['TenPX']
        phieu.NgayLap = request.form['NgayLap']  # Đảm bảo định dạng ngày đúng
        phieu.TongTienXuat = float(request.form['TongTienXuat'])
        db.session.commit()
        flash('Cập nhật thông tin phiếu xuất thành công!', 'success')
    else:
        flash('Không tìm thấy phiếu xuất để cập nhật.', 'error')
    return redirect(url_for('phieuxuat'))

# Xóa phiếu xuất
@app.route('/delete_phieuxuat/<string:MaPX>', methods=['GET'])
def delete_phieuxuat(MaPX):
    phieu = PhieuXuat.query.get(MaPX)
    if phieu:
        db.session.delete(phieu)
        db.session.commit()
        flash('Phiếu xuất đã được xoá thành công!', 'success')
    else:
        flash('Không tìm thấy phiếu xuất với mã này.', 'error')
    return redirect(url_for('phieuxuat'))

class TaiKhoan(db.Model):
    __tablename__ = 'TaiKhoan'

    MaTK = db.Column(db.String(10), primary_key=True)
    TenDN = db.Column(db.String(50), nullable=False)
    MatKhau = db.Column(db.String(255), nullable=False)
    HoTen = db.Column(db.String(100), nullable=False)
    Email = db.Column(db.String(100), nullable=False)
    PhanQuyen = db.Column(db.String(50), nullable=False)
    # Route cho trang chính tài khoản
@app.route('/taikhoan', methods=['GET', 'POST'])
def taikhoan():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm
    if search_query:
        tai_khoan_list = TaiKhoan.query.filter(TaiKhoan.HoTen.like(f'%{search_query}%')).all()  # Tìm kiếm theo họ tên
    else:
        tai_khoan_list = TaiKhoan.query.all()  # Lấy danh sách tài khoản nếu không có tìm kiếm
    return render_template('QuanLyTaiKhoan.html', tai_khoan_list=tai_khoan_list)

# Thêm tài khoản
@app.route('/add_taikhoan', methods=['POST'])
def add_taikhoan():
    new_taikhoan = TaiKhoan(
        MaTK=request.form['MaTK'],
        TenDN=request.form['TenDN'],
        MatKhau=request.form['MatKhau'],
        HoTen=request.form['HoTen'],
        Email=request.form['Email'],
        PhanQuyen=request.form['PhanQuyen']  # Đảm bảo lấy phân quyền từ dropdown
    )
    db.session.add(new_taikhoan)
    db.session.commit()
    flash('Thêm tài khoản thành công!', 'success')
    return redirect(url_for('taikhoan'))

# Cập nhật thông tin tài khoản
@app.route('/update_taikhoan', methods=['POST'])
def update_taikhoan():
    tai_khoan = TaiKhoan.query.get(request.form['MaTK'])
    if tai_khoan:
        tai_khoan.TenDN = request.form['TenDN']
        tai_khoan.MatKhau = request.form['MatKhau']
        tai_khoan.HoTen = request.form['HoTen']
        tai_khoan.Email = request.form['Email']
        tai_khoan.PhanQuyen = request.form['PhanQuyen']  # Cập nhật phân quyền
        db.session.commit()
        flash('Cập nhật thông tin tài khoản thành công!', 'success')
    else:
        flash('Không tìm thấy tài khoản để cập nhật.', 'error')
    return redirect(url_for('taikhoan'))

# Xóa tài khoản

@app.route('/delete_taikhoan/<string:MaTK>', methods=['DELETE'])
def delete_taikhoan(MaTK):
    tai_khoan = TaiKhoan.query.get(MaTK)
    if tai_khoan:
        db.session.delete(tai_khoan)
        db.session.commit()
        flash('Tài khoản đã được xoá thành công!', 'success')
    else:
        flash('Không tìm thấy tài khoản với mã này.', 'error')
    
    return '', 204  # Trả về mã trạng thái 204 No Content
# Mô hình Hóa Đơn
class HoaDon(db.Model):
    __tablename__ = 'HoaDon'  # Đặt tên bảng chính xác
    MaHD = db.Column(db.String, primary_key=True)
    HoTenKH = db.Column(db.String)
    DiaDiemGH = db.Column(db.String)
    SDTNguoiDH = db.Column(db.String)
    NgayDH = db.Column(db.Date)
    PhuongThucThanhToan = db.Column(db.String)
    TinhTrangDDH = db.Column(db.String)
    TongTien = db.Column(db.Float)

# Mô hình Chi Tiết Hóa Đơn
class CTHoaDon(db.Model):
    __tablename__ = 'CTHoaDon'  # Đặt tên bảng chính xác
    id = db.Column(db.Integer, primary_key=True)
    MaHD = db.Column(db.String, db.ForeignKey('HoaDon.MaHD'))
    TenSP = db.Column(db.String)
    SoLuong = db.Column(db.Integer)
    DonGia = db.Column(db.Float)

@app.route('/hoadon', methods=['GET', 'POST'])
def hoadon():
    search_query = request.form.get('search', '')  # Lấy từ khóa tìm kiếm nếu có
    if search_query:
        hoa_don_list = HoaDon.query.filter(HoaDon.HoTenKH.like(f'%{search_query}%')).all()  # Tìm kiếm theo họ tên khách hàng
    else:
        hoa_don_list = HoaDon.query.all()  # Lấy danh sách hóa đơn nếu không có tìm kiếm
    return render_template('QLHD.html', hoa_don_list=hoa_don_list)

@app.route('/add_hoadon', methods=['POST'])
def add_hoadon():
    new_hoadon = HoaDon(
        MaHD=request.form['MaHD'],
        HoTenKH=request.form['HoTenKH'],
        DiaDiemGH=request.form['DiaDiemGH'],
        SDTNguoiDH=request.form['SDTNguoiDH'],
        NgayDH=request.form['NgayDH'],
        PhuongThucThanhToan=request.form['PhuongThucThanhToan'],
        TinhTrangDDH=request.form['TinhTrangDDH'],
        TongTien=request.form['TongTien']
    )
    db.session.add(new_hoadon)
    db.session.commit()
    flash('Thêm hóa đơn thành công!', 'success')
    return redirect(url_for('hoadon'))

@app.route('/update_hoadon', methods=['POST'])
def update_hoadon():
    hoa_don = HoaDon.query.get(request.form['MaHD'])
    if hoa_don:
        hoa_don.HoTenKH = request.form['HoTenKH']
        hoa_don.DiaDiemGH = request.form['DiaDiemGH']
        hoa_don.SDTNguoiDH = request.form['SDTNguoiDH']
        hoa_don.NgayDH = request.form['NgayDH']
        hoa_don.PhuongThucThanhToan = request.form['PhuongThucThanhToan']
        hoa_don.TinhTrangDDH = request.form['TinhTrangDDH']
        hoa_don.TongTien = request.form['TongTien']
        db.session.commit()
        flash('Cập nhật thông tin hóa đơn thành công!', 'success')
    else:
        flash('Không tìm thấy hóa đơn để cập nhật.', 'error')
    return redirect(url_for('hoadon'))

@app.route('/delete_hoadon/<string:MaHD>', methods=['DELETE'])
def delete_hoadon(MaHD):
    hoa_don = HoaDon.query.get(MaHD)
    if hoa_don:
        db.session.delete(hoa_don)
        db.session.commit()
        flash('Hóa đơn đã được xoá thành công!', 'success')
    else:
        flash('Không tìm thấy hóa đơn với mã này.', 'error')
    
    return '', 204  # Trả về mã trạng thái 204 No Content

@app.route('/api/cthoadon/<string:maHD>', methods=['GET'])
def get_ct_hoa_don(maHD):
    details = CTHoaDon.query.filter_by(MaHD=maHD).all()
    products = [{'tenSanPham': detail.TenSP, 'soLuong': detail.SoLuong, 'donGia': detail.DonGia} for detail in details]
    return jsonify(products)

class BaoCaoTonKho(db.Model):
    __tablename__ = 'BaoCaoTonKho'
    MaSP = db.Column(db.String(50), primary_key=True)
    TenSP = db.Column(db.String(100))
    SoLuongBan = db.Column(db.Integer)
    DoanhThu = db.Column(db.Float)


@app.route('/tonkho')
def tonkho():
    return render_template('BaoCaoDoanhThu.html')  # Trả về tệp HTML

@app.route('/fetch_data', methods=['GET'])
def fetch_data():
    results = BaoCaoTonKho.query.all()
    data = [{'MaSP': item.MaSP, 'TenSP': item.TenSP, 'SoLuongBan': item.SoLuongBan, 'DoanhThu': item.DoanhThu} for item in results]
    return jsonify(data)

class BCTK(db.Model):
    __tablename__ = 'BCTK'  # Đổi tên bảng thành BCTK
    MaSP = db.Column(db.String(50), primary_key=True)
    TenSP = db.Column(db.String(100))
    SoLuongDauKy = db.Column(db.Integer)  # Số lượng đầu kỳ
    SoLuongNhap = db.Column(db.Integer)    # Số lượng nhập
    SoLuongXuat = db.Column(db.Integer)    # Số lượng xuất
    TonKhoCuoiKi = db.Column(db.Integer)   # Tồn kho cuối kỳ
    TongGiaTienTonKho = db.Column(db.Float) # Tổng giá tiền tồn kho

@app.route('/tk')
def tk():
    return render_template('BaoCaoTonKho.html')  # Trả về tệp HTML cho báo cáo tồn kho

@app.route('/fetch_data_bctk', methods=['GET'])
def fetch_data_bctk():
    results = BCTK.query.all()
    data = [
        {
            'MaSP': item.MaSP,
            'TenSP': item.TenSP,
            'SoLuongDauKy': item.SoLuongDauKy,
            'SoLuongNhap': item.SoLuongNhap,
            'SoLuongXuat': item.SoLuongXuat,
            'TonKhoCuoiKi': item.TonKhoCuoiKi,
            'TongGiaTienTonKho': item.TongGiaTienTonKho
        }
        for item in results
    ]
    return jsonify(data)
# Route cho trang chính

# Flask constructor takes the name of 
# current module (__name__) as argument.

# The route() function of the Flask class is a decorator, 
# which tells the application which URL should call 
# the associated function.
@app.route('/dangnhap')
def dangnhap():
    return render_template('DangNhap.html')

@app.route('/dangky')
def dangky():
    return render_template('DangKy.html')


@app.route('/trangchu')
def trangchu():
    return render_template('TrangChu.html')

@app.route('/')
def GDKH():
    return render_template('GDKH.html')

@app.route('/giohang')
def giohang():
    return render_template('GioHang.html')

@app.route('/chitietsp')
def chitietsp():
    return render_template('ChiTietSP.html')


@app.route('/thanhtoan')
def thanhtoan():
    return render_template('ThanhToan.html')

@app.route('/LienHe')
def LienHe():
    return render_template('LienHe.html')

@app.route('/GDNV')
def GDNV():
    return render_template('GDNV.html')

@app.route("/DMSP")
def DMSP():
    category = request.args.get("category", "Tất cả")
    
    # Danh sách sản phẩm và dữ liệu ngay trong template
    return render_template("SanPham.html", current_category=category)

@app.route('/success')
def success():
    # Trả về trang "ThanhCong.html"
    return render_template('ThanhCong.html')


@app.route('/submit-order', methods=['POST'])
def submit_order():
    order = request.json

    # Tạo email
    msg = Message(
        subject='Đơn hàng mới đã được nhận',
        recipients=['hoanuyen03@gmail.com'],
        body=f'Thông tin đơn hàng:\nMã sản phẩm: {order["productId"]}\nSố lượng: {order["quantity"]}\nEmail khách hàng: {order["customerEmail"]}'
    )

    try:
        mail.send(msg)
        return jsonify({'message': 'Đơn hàng đã được gửi và email đã được gửi!'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/hehe')
def hehe():
    return render_template('hehe.html')

# main driver function
if __name__ == '__main__':
    app.secret_key = 'super secret key'  # Thiết lập secret key
  


    # run() method of Flask class runs the application 
    # on the local development server.
    app.run(port=3307, debug=True)

@app.route('/test_connection')
def test_connection():
    try:
        # Thực hiện truy vấn đơn giản để kiểm tra kết nối
        db.session.execute('SELECT 1')
        return jsonify({'status': 'success', 'message': 'Kết nối thành công!'})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)})

