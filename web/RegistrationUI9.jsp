<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Customer9"%>
<%@page import="dao.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    boolean isSuccess = false;
    boolean isError = false;
    String errorMessage = "";
    String successName = "";
    String valUsername = "";
    String valEmail = "";
    String valName = "";
    String valPhone = "";
    String valAddress = "";
    String valShippingAddress = "";
    String valDob = "";
    String action = request.getParameter("action");
    if ("register".equals(action)) {
        valUsername = request.getParameter("username") != null ? request.getParameter("username").trim() : "";
        valEmail = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String valPassword = request.getParameter("password") != null ? request.getParameter("password") : "";
        valName = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        valPhone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
        valAddress = request.getParameter("address") != null ? request.getParameter("address").trim() : "";
        valShippingAddress = request.getParameter("shippingAddress") != null ? request.getParameter("shippingAddress").trim() : "";
        valDob = request.getParameter("dateOfBirth") != null ? request.getParameter("dateOfBirth").trim() : "";
        CustomerDAO dao = new CustomerDAO();
        boolean isExist = dao.checkUsernameAndEmailExist(valUsername, valEmail);
        boolean isPasswordValid = valPassword.length() >= 8;
        if (!isPasswordValid) {
            isError = true;
            errorMessage = "Mật khẩu phải có tối thiểu 8 ký tự!";
        } else if (isExist) {
            isError = true;
            errorMessage = "Tên đăng nhập hoặc Email đã tồn tại. Vui lòng chọn thông tin khác!";
        } else {
            Customer9 c = new Customer9();
            c.setUsername(valUsername);
            c.setEmail(valEmail);
            c.setPassword(valPassword);
            c.setName(valName);
            c.setPhone(valPhone);
            c.setAddress(valAddress);
            c.setShippingAddress(valShippingAddress);
            if (!valDob.isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    c.setDateOfBirth(sdf.parse(valDob));
                } catch (Exception ignored) {}
            }
            if (dao.saveCustomer(c)) {
                isSuccess = true;
                successName = valName.isEmpty() ? valUsername : valName;
            } else {
                isError = true;
                errorMessage = "Có lỗi xảy ra khi lưu vào hệ thống, vui lòng thử lại sau.";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản thành viên - ShopMan</title>

    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <header class="app-header">
        <div class="brand">
            <span class="brand-title">ShopMan</span>
        </div>

        <a href="CustomerMainUI9.jsp" id="btnBack" class="btn-back" style="margin-bottom: 0;">
            ← Về cửa hàng
        </a>
    </header>

    <main class="reg-container">
        <div class="reg-card">
            <h1 class="reg-title">Đăng ký tài khoản thành viên</h1>
            <div class="reg-header-sub-row">
                <span class="reg-subtitle">Mua sắm thả ga, nhận thêm ưu đãi mỗi ngày.</span>
                <span class="reg-required-notice"><span style="color:#ef4444;">*</span> Thông tin bắt buộc</span>
            </div>

            <div id="outNotification">
                <%
    if (isError) {
%>
                <div class="alert-banner">
                    <span><%= errorMessage %></span>
                </div>
                <%
    }
%>
            </div>

            <form name="inPersonalInfo" id="inPersonalInfo" action="RegistrationUI9.jsp" method="POST">
                <input type="hidden" name="action" value="register">

                <div class="reg-section-header">
                    <span>Thông tin tài khoản</span>
                </div>

                <div class="reg-form-grid">

                    <div class="reg-form-group">
                        <label for="username">Tên đăng nhập <span class="star">*</span></label>
                        <div class="reg-input-wrapper">
                            <input type="text" id="username" name="username" class="reg-input-field" placeholder="minhanh" value="<%= valUsername %>" required>
                        </div>
                        <div class="reg-hint-text">Dùng chữ cái, chữ số và dấu gạch dưới.</div>
                    </div>

                    <div class="reg-form-group">
                        <label for="email">Email <span class="star">*</span></label>
                        <div class="reg-input-wrapper">
                            <input type="email" id="email" name="email" class="reg-input-field" placeholder="minhanh@gmail.com" value="<%= valEmail %>" required>
                        </div>
                        <div class="reg-hint-text">Email dùng để nhận thông báo đơn hàng.</div>
                    </div>

                    <div class="reg-form-group full-width">
                        <label for="password">Mật khẩu <span class="star">*</span></label>
                        <div class="reg-input-wrapper">
                            <input type="password" id="password" name="password" class="reg-input-field" 
                                   placeholder="••••••••••••" 
                                   minlength="8" 
                                   title="Mật khẩu tối thiểu 8 ký tự" 
                                   required>
                            <button type="button" class="toggle-pwd" onclick="togglePasswordVisibility('password', this)" style="font-size: 12px; color: #64748b;">Hiện</button>
                        </div>
                        <div class="reg-hint-text">Tối thiểu 8 ký tự.</div>
                    </div>
                </div>

                <div class="reg-section-header">
                    <span>Thông tin cá nhân & giao hàng</span>
                </div>

                <div class="reg-form-grid">

                    <div class="reg-form-group">
                        <label for="name">Họ và tên <span class="star">*</span></label>
                        <div class="reg-input-wrapper">
                            <input type="text" id="name" name="name" class="reg-input-field" placeholder="Nhập họ và tên của bạn" value="<%= valName %>" required>
                        </div>
                    </div>

                    <div class="reg-form-group">
                        <label for="dateOfBirth">Ngày sinh</label>
                        <div class="reg-input-wrapper">
                            <input type="date" id="dateOfBirth" name="dateOfBirth" class="reg-input-field" value="<%= valDob %>">
                        </div>
                        <div class="reg-hint-text">Định dạng: ngày / tháng / năm</div>
                    </div>

                    <div class="reg-form-group">
                        <label for="phone">Số điện thoại <span class="star">*</span></label>
                        <div class="reg-input-wrapper">
                            <input type="tel" id="phone" name="phone" class="reg-input-field" placeholder="0912 345 678" value="<%= valPhone %>" required>
                        </div>
                    </div>

                    <div class="reg-form-group">
                        <label for="address">Địa chỉ</label>
                        <div class="reg-input-wrapper">
                            <input type="text" id="address" name="address" class="reg-input-field" placeholder="24 Nguyễn Thị Minh Khai, TP. Hồ Chí Minh" value="<%= valAddress %>">
                        </div>
                    </div>
                </div>

                <div class="reg-form-group full-width">
                    <label for="shippingAddress">Địa chỉ giao hàng</label>
                    <div class="reg-input-wrapper">
                        <input type="text" id="shippingAddress" name="shippingAddress" class="reg-input-field" placeholder="24 Nguyễn Thị Minh Khai, Phường Sài Gòn, TP. Hồ Chí Minh" value="<%= valShippingAddress %>">
                    </div>
                    <div class="reg-hint-text">Địa chỉ này sẽ được dùng làm địa chỉ giao hàng mặc định.</div>
                </div>

                <div class="reg-terms-text">
                    Bằng việc đăng ký, bạn đồng ý với <a href="#">Điều khoản sử dụng</a> và <a href="#">Chính sách bảo mật</a> của ShopMan.
                </div>

                <button type="submit" id="btnSubmit" name="btnSubmit" class="btn-reg-submit">
                    Đăng ký
                </button>

                <div class="reg-login-row">
                    Đã có tài khoản? <a href="CustomerMainUI9.jsp" id="btnLogin">Đăng nhập</a>
                </div>
            </form>
        </div>
    </main>

    <footer class="app-footer">
        <div>&copy; 2026 ShopMan. Tốt cho mọi nhà.</div>
        <div>Thông tin của bạn luôn được bảo mật</div>
    </footer>

    <div id="successModal" class="modal-overlay <%= isSuccess ? "active" : "" %>">
        <div class="modal-card" style="padding: 36px 30px; text-align: center;">
            <h2 class="modal-title" style="margin: 0 0 24px 0; font-size: 22px;">Đăng ký thành công!</h2>
            <a href="CustomerMainUI9.jsp" id="btnGoLogin" class="btn-modal-login" style="margin-top: 0;">
                Đăng nhập ngay
            </a>
        </div>
    </div>

    <script>
        function togglePasswordVisibility(fieldId, btn) {
            const input = document.getElementById(fieldId);
            if (input.type === 'password') {
                input.type = 'text';
                btn.textContent = 'Ẩn';
            } else {
                input.type = 'password';
                btn.textContent = 'Hiện';
            }
        }

        function closeModal() {
            document.getElementById('successModal').classList.remove('active');
            window.location.href = "CustomerMainUI9.jsp";
        }
    </script>
</body>
</html>
