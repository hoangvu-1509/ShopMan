<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - ShopMan</title>

    <link rel="stylesheet" href="css/style.css">
    <style>
        .hero-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 20px;
        }
        .hero-box {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            max-width: 680px;
            width: 100%;
            padding: 50px 40px;
            text-align: center;
        }
    </style>
</head>
<body>

    <header class="app-header">
        <div class="brand">
            <span class="brand-title">ShopMan</span>
        </div>

        <div>
            <a href="RegistrationUI9.jsp" id="btnRegister" class="btn-primary" style="padding: 10px 20px; font-size: 14px;">
                Đăng ký thành viên
            </a>
        </div>
    </header>

    <main class="hero-section">
        <div class="hero-box">
            <h1 class="page-title" style="font-size: 32px; margin-bottom: 16px;">Chào mừng đến với ShopMan</h1>
            <p class="page-desc" style="font-size: 16px; line-height: 1.6; margin-bottom: 36px;">
                Trải nghiệm nền tảng mua sắm tiện lợi, hiện đại và bảo mật.<br>
                Hãy đăng ký tài khoản thành viên ngay hôm nay để nhận thêm nhiều ưu đãi độc quyền.
            </p>
            <div>
                <a href="RegistrationUI9.jsp" class="btn-primary">
                    Đăng ký tài khoản ngay
                </a>
            </div>
        </div>
    </main>

    <footer class="app-footer">
        <div>&copy; 2026 ShopMan. Tốt cho mọi nhà.</div>
        <div>Thông tin của bạn luôn được bảo mật</div>
    </footer>
</body>
</html>
