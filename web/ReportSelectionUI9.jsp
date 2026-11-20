<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn loại thống kê - ShopMan</title>

    <link rel="stylesheet" href="css/style.css">
    <style>
        .selection-box {
            max-width: 580px;
            margin: 40px auto;
            text-align: center;
            background: #ffffff;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 50px 40px;
        }
        .select-subtitle {
            font-size: 20px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 32px;
        }
        .btn-select-stat {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: var(--primary);
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            padding: 14px 28px;
            border-radius: 10px;
            text-decoration: none;
            transition: all 0.2s ease;
            box-shadow: 0 4px 14px rgba(21, 128, 61, 0.25);
            width: 100%;
            max-width: 360px;
        }
        .btn-select-stat:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

    <header class="app-header">
        <div class="brand">
            <span class="brand-title">ShopMan</span>
        </div>
        <div class="user-badge">
            <span>Không gian quản lý</span>
        </div>
    </header>

    <main class="main-content">

        <a href="ManagerMainUI9.jsp" id="btnBack" class="btn-back">
            ← Về trang quản lý chính
        </a>

        <div class="selection-box">
            <div class="select-subtitle">Chọn loại thống kê</div>

            <a href="ProductRevenueStatUI9.jsp" id="btnSelectProductRevenueStat" class="btn-select-stat">
                Xem thống kê mặt hàng theo doanh thu
            </a>
        </div>
    </main>

    <footer class="app-footer">
        <div>&copy; 2026 ShopMan. Tốt cho mọi nhà.</div>
        <div>Hệ thống quản lý cửa hàng</div>
    </footer>
</body>
</html>
