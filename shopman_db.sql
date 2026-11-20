-- ========================================================================
-- CƠ SỞ DỮ LIỆU: shopman_db
-- Hệ thống: ShopMan (PTTK_HTTT)
-- ========================================================================

CREATE DATABASE IF NOT EXISTS shopman_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopman_db;

-- ------------------------------------------------------------------------
-- XÓA BẢNG CŨ THEO THỨ TỰ PHỤ THUỘC (NẾU ĐÃ TỒN TẠI)
-- ------------------------------------------------------------------------
DROP TABLE IF EXISTS tblImportOrderDetail9;
DROP TABLE IF EXISTS tblImportOrder9;
DROP TABLE IF EXISTS tblSupplier9;
DROP TABLE IF EXISTS tblSalary9;
DROP TABLE IF EXISTS tblOrderDetail9;
DROP TABLE IF EXISTS tblOrder9;
DROP TABLE IF EXISTS tblProductVariant9;
DROP TABLE IF EXISTS tblProduct9;
DROP TABLE IF EXISTS tblManagerStaff9;
DROP TABLE IF EXISTS tblDeliveryStaff9;
DROP TABLE IF EXISTS tblSalesStaff9;
DROP TABLE IF EXISTS tblCustomer9;
DROP TABLE IF EXISTS tblUser9;

-- ========================================================================
-- 1. CÁC BẢNG LIÊN QUAN ĐẾN NGƯỜI DÙNG (USER & KẾ THỪA)
-- ========================================================================

-- Bảng người dùng chung
CREATE TABLE tblUser9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    dateOfBirth DATE NULL,
    address VARCHAR(255) NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    role VARCHAR(50) NOT NULL,
    note VARCHAR(500) NULL
) ENGINE=InnoDB;

-- Bảng khách hàng (Kế thừa tblUser9)
CREATE TABLE tblCustomer9 (
    tblUser9Id INT PRIMARY KEY,
    shippingAddress VARCHAR(255) NULL,
    CONSTRAINT fk_customer_user FOREIGN KEY (tblUser9Id) REFERENCES tblUser9(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Bảng nhân viên bán hàng (Kế thừa tblUser9)
CREATE TABLE tblSalesStaff9 (
    tblUser9Id INT PRIMARY KEY,
    CONSTRAINT fk_salesstaff_user FOREIGN KEY (tblUser9Id) REFERENCES tblUser9(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Bảng nhân viên giao hàng (Kế thừa tblUser9)
CREATE TABLE tblDeliveryStaff9 (
    tblUser9Id INT PRIMARY KEY,
    licensePlate VARCHAR(20) NOT NULL UNIQUE,
    baseSalary FLOAT NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_deliverystaff_user FOREIGN KEY (tblUser9Id) REFERENCES tblUser9(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Bảng nhân viên quản lý (Kế thừa tblUser9)
CREATE TABLE tblManagerStaff9 (
    tblUser9Id INT PRIMARY KEY,
    CONSTRAINT fk_managerstaff_user FOREIGN KEY (tblUser9Id) REFERENCES tblUser9(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ========================================================================
-- 2. CÁC BẢNG SẢN PHẨM & BIẾN THỂ SẢN PHẨM
-- ========================================================================

-- Bảng sản phẩm chung
CREATE TABLE tblProduct9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL
) ENGINE=InnoDB;

-- Bảng biến thể sản phẩm (Màu sắc, kích cỡ, SKU và giá bán)
CREATE TABLE tblProductVariant9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    SKUCode VARCHAR(100) NOT NULL UNIQUE,
    color VARCHAR(50) NULL,
    size VARCHAR(50) NULL,
    price FLOAT NOT NULL,
    stockQuantity INT NOT NULL DEFAULT 0,
    tblProduct9Id INT NOT NULL,
    CONSTRAINT fk_variant_product FOREIGN KEY (tblProduct9Id) REFERENCES tblProduct9(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ========================================================================
-- 3. CÁC BẢNG NHÀ CUNG CẤP & NHẬP HÀNG
-- ========================================================================

-- Bảng nhà cung cấp
CREATE TABLE tblSupplier9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL
) ENGINE=InnoDB;

-- Bảng đơn nhập hàng
CREATE TABLE tblImportOrder9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    importDate DATE NOT NULL,
    totalAmount FLOAT NOT NULL DEFAULT 0,
    note VARCHAR(500) NULL,
    tblSupplier9Id INT NOT NULL,
    tblManagerStaff9tblUser9Id INT NOT NULL,
    CONSTRAINT fk_import_supplier FOREIGN KEY (tblSupplier9Id) REFERENCES tblSupplier9(id),
    CONSTRAINT fk_import_manager FOREIGN KEY (tblManagerStaff9tblUser9Id) REFERENCES tblManagerStaff9(tblUser9Id)
) ENGINE=InnoDB;

-- Bảng chi tiết đơn nhập hàng (totalPrice được tự động tính bằng công thức)
CREATE TABLE tblImportOrderDetail9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    unitPrice FLOAT NOT NULL,
    -- (*) Thuộc tính công thức: totalPrice = quantity * unitPrice
    totalPrice FLOAT GENERATED ALWAYS AS (quantity * unitPrice) STORED,
    tblImportOrder9Id INT NOT NULL,
    tblProductVariant9Id INT NOT NULL,
    CONSTRAINT fk_importdetail_order FOREIGN KEY (tblImportOrder9Id) REFERENCES tblImportOrder9(id) ON DELETE CASCADE,
    CONSTRAINT fk_importdetail_variant FOREIGN KEY (tblProductVariant9Id) REFERENCES tblProductVariant9(id)
) ENGINE=InnoDB;

-- ========================================================================
-- 4. CÁC BẢNG ĐƠN ĐẶT HÀNG & LƯƠNG NHÂN VIÊN GIAO HÀNG
-- ========================================================================

-- Bảng đơn đặt hàng
CREATE TABLE tblOrder9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderDate DATE NOT NULL,
    totalAmount FLOAT NOT NULL DEFAULT 0,
    note VARCHAR(500) NULL,
    orderStatus VARCHAR(50) NOT NULL,
    shippingFee FLOAT NOT NULL DEFAULT 0,
    tblCustomer9tblUser9Id INT NOT NULL,
    tblSalesStaff9tblUser9Id INT NULL,
    tblDeliveryStaff9tblUser9Id INT NULL,
    CONSTRAINT fk_order_customer FOREIGN KEY (tblCustomer9tblUser9Id) REFERENCES tblCustomer9(tblUser9Id),
    CONSTRAINT fk_order_salesstaff FOREIGN KEY (tblSalesStaff9tblUser9Id) REFERENCES tblSalesStaff9(tblUser9Id),
    CONSTRAINT fk_order_deliverystaff FOREIGN KEY (tblDeliveryStaff9tblUser9Id) REFERENCES tblDeliveryStaff9(tblUser9Id)
) ENGINE=InnoDB;

-- Bảng chi tiết đơn đặt hàng (totalPrice được tự động tính bằng công thức)
CREATE TABLE tblOrderDetail9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    unitPrice FLOAT NOT NULL,
    -- (*) Thuộc tính công thức: totalPrice = quantity * unitPrice
    totalPrice FLOAT GENERATED ALWAYS AS (quantity * unitPrice) STORED,
    tblOrder9Id INT NOT NULL,
    tblProductVariant9Id INT NOT NULL,
    CONSTRAINT fk_orderdetail_order FOREIGN KEY (tblOrder9Id) REFERENCES tblOrder9(id) ON DELETE CASCADE,
    CONSTRAINT fk_orderdetail_variant FOREIGN KEY (tblProductVariant9Id) REFERENCES tblProductVariant9(id)
) ENGINE=InnoDB;

-- Bảng tính lương nhân viên giao hàng
CREATE TABLE tblSalary9 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    monthYear VARCHAR(20) NOT NULL,
    deliveredOrders INT NOT NULL DEFAULT 0,
    totalSalary FLOAT NOT NULL DEFAULT 0,
    paymentDate DATE NULL,
    tblDeliveryStaff9tblUser9Id INT NOT NULL,
    tblManagerStaff9tblUser9Id INT NOT NULL,
    CONSTRAINT fk_salary_deliverystaff FOREIGN KEY (tblDeliveryStaff9tblUser9Id) REFERENCES tblDeliveryStaff9(tblUser9Id),
    CONSTRAINT fk_salary_manager FOREIGN KEY (tblManagerStaff9tblUser9Id) REFERENCES tblManagerStaff9(tblUser9Id)
) ENGINE=InnoDB;

-- ========================================================================
-- 5. TRIGGER TỰ ĐỘNG TÍNH TỔNG TIỀN (totalAmount)
-- ========================================================================
DELIMITER $$

-- Tự động cộng tổng tiền tblOrder9 khi thêm/sửa/xóa chi tiết hóa đơn
CREATE TRIGGER trg_after_insert_orderdetail
AFTER INSERT ON tblOrderDetail9
FOR EACH ROW
BEGIN
    UPDATE tblOrder9
    SET totalAmount = (
        SELECT COALESCE(SUM(totalPrice), 0) FROM tblOrderDetail9 WHERE tblOrder9Id = NEW.tblOrder9Id
    ) + shippingFee
    WHERE id = NEW.tblOrder9Id;
END$$

CREATE TRIGGER trg_after_update_orderdetail
AFTER UPDATE ON tblOrderDetail9
FOR EACH ROW
BEGIN
    UPDATE tblOrder9
    SET totalAmount = (
        SELECT COALESCE(SUM(totalPrice), 0) FROM tblOrderDetail9 WHERE tblOrder9Id = NEW.tblOrder9Id
    ) + shippingFee
    WHERE id = NEW.tblOrder9Id;
END$$

CREATE TRIGGER trg_after_delete_orderdetail
AFTER DELETE ON tblOrderDetail9
FOR EACH ROW
BEGIN
    UPDATE tblOrder9
    SET totalAmount = (
        SELECT COALESCE(SUM(totalPrice), 0) FROM tblOrderDetail9 WHERE tblOrder9Id = OLD.tblOrder9Id
    ) + shippingFee
    WHERE id = OLD.tblOrder9Id;
END$$

-- Tự động cộng tổng tiền tblImportOrder9 khi thêm/sửa chi tiết đơn nhập
CREATE TRIGGER trg_after_insert_importdetail
AFTER INSERT ON tblImportOrderDetail9
FOR EACH ROW
BEGIN
    UPDATE tblImportOrder9
    SET totalAmount = (
        SELECT COALESCE(SUM(totalPrice), 0) FROM tblImportOrderDetail9 WHERE tblImportOrder9Id = NEW.tblImportOrder9Id
    )
    WHERE id = NEW.tblImportOrder9Id;
END$$

DELIMITER ;

-- ========================================================================
-- 6. DỮ LIỆU MẪU (INSERT KHỚP 100% ẢNH GIAO DIỆN MODULE 1 & MODULE 2)
-- ========================================================================

-- 6.1. Dữ liệu bảng tblUser9
INSERT INTO tblUser9 (id, name, username, password, dateOfBirth, address, email, phone, role, note) VALUES
(1, 'Nguyễn Văn A', 'nguyenvana', '12345678', '1995-05-15', '24 Nguyễn Thị Minh Khai, Q.1, TP.HCM', 'nguyenvana@gmail.com', '0912345678', 'CUSTOMER', 'Khách hàng thân thiết'),
(2, 'Trần Thị B', 'tranthib', '12345678', '1998-08-20', '123 Lê Lợi, Q.1, TP.HCM', 'tranthib@gmail.com', '0987654321', 'CUSTOMER', 'Khách hàng VIP'),
(3, 'Lê Văn C', 'levanc', '12345678', '2000-01-10', '45 Hai Bà Trưng, Q.3, TP.HCM', 'levanc@gmail.com', '0903123456', 'CUSTOMER', 'Khách hàng mới'),
(4, 'Nguyễn Minh Anh', 'minhanh98', '12345678', '1998-08-16', '24 Nguyễn Thị Minh Khai, TP. Hồ Chí Minh', 'minhanh@gmail.com', '0912345678', 'CUSTOMER', 'Tài khoản demo Module 1'),
(5, 'Phạm Bán Hàng', 'sales01', '12345678', '1996-03-12', 'Hà Nội', 'sales01@shopman.vn', '0934112233', 'SALES_STAFF', 'Nhân viên bán hàng ca sáng'),
(6, 'Vũ Giao Hàng', 'shipper01', '12345678', '1997-07-22', 'Hồ Chí Minh', 'shipper01@shopman.vn', '0977889900', 'DELIVERY_STAFF', 'Nhân viên giao hàng nhanh'),
(7, 'Hoàng Quản Lý', 'manager01', '12345678', '1990-11-05', 'Hà Nội', 'manager01@shopman.vn', '0911223344', 'MANAGER_STAFF', 'Trưởng phòng quản lý kinh doanh');

-- 6.2. Dữ liệu các bảng kế thừa User
INSERT INTO tblCustomer9 (tblUser9Id, shippingAddress) VALUES
(1, '24 Nguyễn Thị Minh Khai, Q.1, TP.HCM'),
(2, '123 Lê Lợi, Q.1, TP.HCM'),
(3, '45 Hai Bà Trưng, Q.3, TP.HCM'),
(4, '24 Nguyễn Thị Minh Khai, Phường Sài Gòn, TP. Hồ Chí Minh');

INSERT INTO tblSalesStaff9 (tblUser9Id) VALUES
(5);

INSERT INTO tblDeliveryStaff9 (tblUser9Id, licensePlate, baseSalary, status) VALUES
(6, '29-B1 678.99', 8000000, 'Đang làm việc');

INSERT INTO tblManagerStaff9 (tblUser9Id) VALUES
(7);

-- 6.3. Dữ liệu nhà cung cấp
INSERT INTO tblSupplier9 (id, name, address, phone, email, description) VALUES
(1, 'Công ty Cổ phần Thực phẩm Sạch Việt Nam', 'KCN Tân Bình, TP.HCM', '02838123456', 'contact@thucphamsach.vn', 'Nhà cung cấp nông sản sạch');

-- 6.4. Dữ liệu sản phẩm (tblProduct9)
INSERT INTO tblProduct9 (id, productName, description) VALUES
(1, 'Sữa tươi tiệt trùng 1L', 'Sữa tươi đóng hộp nguyên chất tiệt trùng 1 lít'),
(2, 'Gạo ST25 bao 5kg', 'Gạo ngon nhất thế giới đặc sản Sóc Trăng bao 5kg'),
(3, 'Nước mắm 500ml', 'Nước mắm cốt cá cơm nguyên chất 500ml'),
(4, 'Dầu ăn 1L', 'Dầu ăn thực vật cao cấp nguyên chất 1 lít');

-- 6.5. Dữ liệu biến thể sản phẩm (tblProductVariant9)
-- SKUCode chuẩn theo ảnh giao diện: MH001, MH005, MH012, MH020
INSERT INTO tblProductVariant9 (id, SKUCode, color, size, price, stockQuantity, tblProduct9Id) VALUES
(1, 'MH001', 'Trắng', '1 Lít', 35000, 500, 1),
(2, 'MH005', 'Trắng sữa', '5 Kg', 150000, 300, 2),
(3, 'MH012', 'Nâu đỏ', '500 ml', 40000, 600, 3),
(4, 'MH020', 'Vàng óng', '1 Lít', 55000, 450, 4);

-- 6.6. Dữ liệu đơn hàng bán (tblOrder9)
-- Gồm các mã hóa đơn: HD1005, HD1023, HD1089 (Khớp ảnh chi tiết giao dịch)
INSERT INTO tblOrder9 (id, orderDate, totalAmount, note, orderStatus, shippingFee, tblCustomer9tblUser9Id, tblSalesStaff9tblUser9Id, tblDeliveryStaff9tblUser9Id) VALUES
(1001, '2026-08-01', 0, 'Đơn mua sữa tươi', 'COMPLETED', 0, 1, 5, 6),
(1002, '2026-08-02', 0, 'Đơn mua nước mắm', 'COMPLETED', 0, 3, 5, 6),
(1003, '2026-08-03', 0, 'Đơn mua dầu ăn', 'COMPLETED', 0, 1, 5, 6),
(1005, '2026-08-02', 0, 'Giao giờ hành chính', 'COMPLETED', 0, 1, 5, 6),
(1023, '2026-08-05', 0, 'Gọi trước khi giao', 'COMPLETED', 0, 2, 5, 6),
(1089, '2026-08-12', 0, 'Giao tận cửa', 'COMPLETED', 0, 3, 5, 6);

-- 6.7. Dữ liệu chi tiết đơn hàng (tblOrderDetail9)
-- LƯU Ý: Cột totalPrice là GENERATED ALWAYS AS (quantity * unitPrice), nên không cần chèn, MySQL tự tính!
-- Trigger sẽ tự động cập nhật totalAmount của tblOrder9.
INSERT INTO tblOrderDetail9 (tblOrder9Id, tblProductVariant9Id, quantity, unitPrice) VALUES
-- Mặt hàng MH001 (Sữa tươi): 150 hộp x 35.000 = 5.250.000 đ
(1001, 1, 150, 35000),

-- Mặt hàng MH012 (Nước mắm): 200 chai x 40.000 = 8.000.000 đ
(1002, 3, 200, 40000),

-- Mặt hàng MH020 (Dầu ăn): 120 chai x 55.000 = 6.600.000 đ
(1003, 4, 120, 55000),

-- Mặt hàng MH005 (Gạo ST25) phát sinh trong 3 hóa đơn HD1005, HD1023, HD1089:
-- HD1005: 20 bao x 150.000 = 3.000.000 đ
(1005, 2, 20, 150000),
-- HD1023: 30 bao x 150.000 = 4.500.000 đ
(1023, 2, 30, 150000),
-- HD1089: 35 bao x 150.000 = 5.250.000 đ
(1089, 2, 35, 150000);
-- => Tổng MH005: 20 + 30 + 35 = 85 bao | Doanh thu = 12.750.000 đ (Khớp 100% Ảnh Giao Diện)
