<%@page import="model.OrderDetail9"%>
<%@page import="dao.StatisticsDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String skuCode = request.getParameter("skuCode") != null ? request.getParameter("skuCode") : "MH005";
    String inSearchProductTransaction = request.getParameter("inSearchProductTransaction") != null ? request.getParameter("inSearchProductTransaction").trim() : "";
    String inStartDateStr = request.getParameter("inStartDate") != null ? request.getParameter("inStartDate").trim() : "";
    String inEndDateStr = request.getParameter("inEndDate") != null ? request.getParameter("inEndDate").trim() : "";
    String selSortTransactionDate = request.getParameter("selSortTransactionDate") != null ? request.getParameter("selSortTransactionDate") : "newest";
    Date startDate = null;
    Date endDate = null;
    String[] datePatterns = {"dd/MM/yy", "dd/MM/yyyy", "yyyy-MM-dd", "d/M/yy", "d/M/yyyy"};
    for (String pattern : datePatterns) {
        if (startDate == null && !inStartDateStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(pattern);
                sdf.setLenient(false);
                startDate = sdf.parse(inStartDateStr);
            } catch (Exception ignored) {}
        }
        if (endDate == null && !inEndDateStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(pattern);
                sdf.setLenient(false);
                endDate = sdf.parse(inEndDateStr);
            } catch (Exception ignored) {}
        }
    }
    StatisticsDAO dao = new StatisticsDAO();
    List<OrderDetail9> listDetails = dao.getTransactionDetails(skuCode, inSearchProductTransaction, startDate, endDate, selSortTransactionDate);
    int totalQuantity = 0;
    float grandTotalAmount = 0;
    String selectedProductName = "Gạo ST25 bao 5kg";
    float unitPriceDisplay = 150000;
    if (listDetails != null && !listDetails.isEmpty()) {
        selectedProductName = listDetails.get(0).getProductVariant().getProduct().getProductName();
        unitPriceDisplay = listDetails.get(0).getProductVariant().getPrice();
        for (OrderDetail9 od : listDetails) {
            totalQuantity += od.getQuantity();
            grandTotalAmount += od.getTotalPrice();
        }
    }
    SimpleDateFormat viewDateFormat = new SimpleDateFormat("dd/MM/yyyy");
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê chi tiết giao dịch mặt hàng - ShopMan</title>

    <link rel="stylesheet" href="css/style.css">
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

        <a href="ProductRevenueStatUI9.jsp" id="btnBack" class="btn-back">
            ← Về trang thống kê mặt hàng
        </a>

        <div class="card-container">
            <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 20px; margin-bottom: 24px;">
                <div>
                    <h1 class="page-title">THỐNG KÊ CHI TIẾT GIAO DỊCH MẶT HÀNG</h1>
                    <p class="page-desc" style="margin-bottom: 0;">Danh sách chi tiết tất cả các hóa đơn phát sinh giao dịch</p>
                </div>

                <div class="product-info-card">
                    <div>
                        <div class="product-info-name"><%= selectedProductName %></div>
                        <div class="product-info-sub">
                            Mã: <strong><%= skuCode %></strong> &nbsp;•&nbsp; Đơn giá niêm yết: <strong><%= df.format(unitPriceDisplay) %> đ</strong>
                        </div>
                    </div>
                </div>
            </div>

            <form id="detailFilterForm" action="ProductTransactionDetailUI9.jsp" method="GET">
                <input type="hidden" name="skuCode" value="<%= skuCode %>">

                <div class="toolbar-row">

                    <div class="search-wrapper">
                        <input type="text" id="inSearchProductTransaction" name="inSearchProductTransaction" class="input-search" 
                               style="padding-left: 16px;"
                               placeholder="Tìm mã hóa đơn, tên khách hàng..." value="<%= inSearchProductTransaction %>"
                               onkeydown="if(event.key==='Enter') this.form.submit();">
                    </div>

                    <div class="filter-group">

                        <div class="date-filter-box" style="position: relative;">
                            <span>Từ:</span>
                            <input type="text" id="inStartDate" name="inStartDate" placeholder="dd/mm/yyyy" value="<%= inStartDateStr %>" 
                                   style="width: 90px; border: none; outline: none; background: transparent; font-size: 13px; cursor: pointer;"
                                   onclick="openDatePicker('nativeStartDate')"
                                   onchange="this.form.submit()"
                                   onkeydown="if(event.key==='Enter') this.form.submit();">
                            <input type="date" id="nativeStartDate" style="position: absolute; opacity: 0; width: 0; height: 0; pointer-events: none;" onchange="applyPickerDate(this, 'inStartDate')">

                            <span>—</span>

                            <span>Đến:</span>
                            <input type="text" id="inEndDate" name="inEndDate" placeholder="dd/mm/yyyy" value="<%= inEndDateStr %>" 
                                   style="width: 90px; border: none; outline: none; background: transparent; font-size: 13px; cursor: pointer;"
                                   onclick="openDatePicker('nativeEndDate')"
                                   onchange="this.form.submit()"
                                   onkeydown="if(event.key==='Enter') this.form.submit();">
                            <input type="date" id="nativeEndDate" style="position: absolute; opacity: 0; width: 0; height: 0; pointer-events: none;" onchange="applyPickerDate(this, 'inEndDate')">

                            <button type="button" class="btn-reset-date" onclick="resetDateFilter()" title="Xóa lọc ngày" style="font-size: 12px; margin-left: 4px;">
                                Xóa
                            </button>
                        </div>

                        <select id="selSortTransactionDate" name="selSortTransactionDate" class="select-filter" onchange="this.form.submit()">
                            <option value="newest" <%= "newest".equals(selSortTransactionDate) ? "selected" : "" %>>Ngày giao dịch: Mới nhất</option>
                            <option value="oldest" <%= "oldest".equals(selSortTransactionDate) ? "selected" : "" %>>Ngày giao dịch: Cũ nhất</option>
                        </select>
                    </div>
                </div>
            </form>

            <div class="table-responsive">
                <table id="tblTransactions" class="data-table">
                    <thead>
                        <tr>
                            <th class="col-center" style="width: 50px;">TT</th>
                            <th style="width: 140px;">MÃ HÓA ĐƠN</th>
                            <th style="width: 160px;">NGÀY GIAO DỊCH</th>
                            <th>TÊN KHÁCH HÀNG</th>
                            <th class="col-number" style="width: 160px;">SỐ LƯỢNG MUA</th>
                            <th class="col-number" style="width: 160px;">ĐƠN GIÁ</th>
                            <th class="col-number" style="width: 180px;">THÀNH TIỀN</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listDetails != null && !listDetails.isEmpty()) {
                                int stt = 1;
                                for (OrderDetail9 od : listDetails) {
                                    String codeHD = "HD" + od.getOrder().getId();
                                    String dateStr = od.getOrder().getOrderDate() != null ? viewDateFormat.format(od.getOrder().getOrderDate()) : "";
                                    String customerName = od.getOrder().getCustomer() != null ? od.getOrder().getCustomer().getName() : "Khách lẻ";
%>
                        <tr>
                            <td class="col-center" style="color: #94a3b8;"><%= stt++ %></td>
                            <td><%= codeHD %></td>
                            <td><%= dateStr %></td>
                            <td class="col-bold"><%= customerName %></td>
                            <td class="col-number"><%= od.getQuantity() %></td>
                            <td class="col-number"><%= df.format(od.getUnitPrice()) %> đ</td>
                            <td class="col-number col-bold"><%= df.format(od.getTotalPrice()) %> đ</td>
                        </tr>
                        <%
                                }
                            } else {
%>
                        <tr>
                            <td colspan="7" class="col-center" style="padding: 30px; color: #94a3b8;">
                                Không có giao dịch nào phù hợp với điều kiện tìm kiếm.
                            </td>
                        </tr>
                        <%
    }
%>
                    </tbody>
                </table>

                <div class="summary-bar">
                    <div>Hiển thị <strong><%= listDetails != null ? listDetails.size() : 0 %></strong> / <strong><%= listDetails != null ? listDetails.size() : 0 %></strong> lượt giao dịch</div>
                    <div style="display: flex; gap: 32px;">
                        <div>Tổng số lượng mua: <span class="summary-value"><%= totalQuantity %></span></div>
                        <div>Tổng thành tiền: <span class="summary-value"><%= df.format(grandTotalAmount) %> đ</span></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="tip-banner">
            <span>Dữ liệu giao dịch được ghi nhận tự động từ hệ thống bán hàng tại quầy và đơn hàng trực tuyến.</span>
        </div>
    </main>

    <footer class="app-footer">
        <div>&copy; 2026 ShopMan. Tốt cho mọi nhà.</div>
        <div>Hệ thống quản lý cửa hàng</div>
    </footer>

    <script>
        function openDatePicker(hiddenId) {
            const el = document.getElementById(hiddenId);
            if (el && typeof el.showPicker === 'function') {
                try { el.showPicker(); } catch (e) {}
            }
        }

        function applyPickerDate(hiddenInput, textInputId) {
            if (!hiddenInput.value) return;
            const parts = hiddenInput.value.split('-');
            if (parts.length === 3) {
                const dd = parts[2];
                const mm = parts[1];
                const yyyy = parts[0];
                const formatted = dd + '/' + mm + '/' + yyyy;
                const textInput = document.getElementById(textInputId);
                textInput.value = formatted;
                textInput.form.submit();
            }
        }

        function resetDateFilter() {
            document.getElementById('inStartDate').value = '';
            document.getElementById('inEndDate').value = '';
            document.getElementById('nativeStartDate').value = '';
            document.getElementById('nativeEndDate').value = '';
            document.getElementById('detailFilterForm').submit();
        }
    </script>
</body>
</html>
