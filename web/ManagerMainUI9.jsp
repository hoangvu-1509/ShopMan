<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ quản lý - ShopMan</title>

    <link rel="stylesheet" href="css/style.css">
    <style>
        .grid-features {
            display: flex;
            justify-content: flex-start;
            margin-top: 24px;
        }
        .feature-card {
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-color);
            background: #ffffff;
            padding: 28px 28px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-height: 140px;
            max-width: 460px;
            width: 100%;
            text-decoration: none;
            color: inherit;
            transition: all 0.2s ease;
            position: relative;
        }
        .feature-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            border-color: #cbd5e1;
        }
        .feature-card.highlight {
            background-color: var(--primary);
            color: #ffffff;
            border-color: var(--primary);
            box-shadow: 0 8px 24px rgba(21, 128, 61, 0.25);
        }
        .feature-card.highlight:hover {
            background-color: var(--primary-hover);
        }
        .feature-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .feature-desc {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.5;
        }
        .auth-notice {
            font-size: 13px;
            color: var(--text-muted);
            margin-top: 36px;
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
        <h1 class="page-title">Chào mừng trở lại!</h1>
        <p class="page-desc">Mọi công việc quản lý cửa hàng, trong một không gian.</p>

        <h2 style="font-size: 15px; font-weight: 600; color: #1e293b; margin-bottom: 8px;">Chọn chức năng để bắt đầu</h2>

        <div class="grid-features">

            <a href="ReportSelectionUI9.jsp" id="btnViewReport" class="feature-card highlight">
                <div>
                    <div class="feature-title">Xem các loại thống kê</div>
                    <div class="feature-desc">Theo dõi và tổng hợp tình hình kinh doanh cửa hàng.</div>
                </div>
            </a>
        </div>

        <div class="auth-notice">
            Bạn đang truy cập với quyền nhân viên quản lý.
        </div>
    </main>

    <footer class="app-footer">
        <div>&copy; 2026 ShopMan. Tốt cho mọi nhà.</div>
        <div>Hệ thống quản lý cửa hàng</div>
    </footer>
</body>
</html>
