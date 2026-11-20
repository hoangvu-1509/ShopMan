<%@page import="model.ProductRevenueStat9"%>
<%@page import="dao.StatisticsDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String inSearchProduct = request.getParameter("inSearchProduct") != null ? request.getParameter("inSearchProduct").trim() : "";
    String selSortRevenue = request.getParameter("selSortRevenue") != null ? request.getParameter("selSortRevenue") : "default";
    String selSortQuantity = request.getParameter("selSortQuantity") != null ? request.getParameter("selSortQuantity") : "default";
    StatisticsDAO dao = new StatisticsDAO();
    List<ProductRevenueStat9> listStats = dao.getRevenueStatistics(inSearchProduct, selSortRevenue, selSortQuantity);
    int grandTotalQuantity = 0;
    float grandTotalRevenue = 0;
    for (ProductRevenueStat9 stat : listStats) {
        grandTotalQuantity += stat.getTotalQuantitySold();
        grandTotalRevenue += stat.getTotalRevenue();
    }
    DecimalFormat df = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê doanh thu mặt hàng - ShopMan</title>

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

        <a href="ManagerMainUI9.jsp" id="btnBack" class="btn-back">
            ← Về trang quản lý chính
        </a>

        <div class="card-container">
            <h1 class="page-title">THỐNG KÊ DOANH THU MẶT HÀNG</h1>
            <p class="page-desc">Xem thống kê mặt hàng theo tổng doanh thu</p>

            <form id="filterForm" action="ProductRevenueStatUI9.jsp" method="GET">
                <div class="toolbar-row">

                    <div class="search-wrapper">
                        <input type="text" id="inSearchProduct" name="inSearchProduct" class="input-search" 
                               style="padding-left: 16px;"
                               placeholder="Tìm kiếm mặt hàng..." value="<%= inSearchProduct %>" 
                               onkeydown="if(event.key==='Enter') this.form.submit();">
                    </div>

                    <div class="filter-group">

                        <select id="selSortRevenue" name="selSortRevenue" class="select-filter" onchange="this.form.submit()">
                            <option value="default" <%= "default".equals(selSortRevenue) ? "selected" : "" %>>Xếp theo Doanh thu: Mặc định</option>
                            <option value="desc" <%= "desc".equals(selSortRevenue) ? "selected" : "" %>>Doanh thu: Cao đến thấp</option>
                            <option value="asc" <%= "asc".equals(selSortRevenue) ? "selected" : "" %>>Doanh thu: Thấp đến cao</option>
                        </select>

                        <select id="selSortQuantity" name="selSortQuantity" class="select-filter" onchange="this.form.submit()">
                            <option value="default" <%= "default".equals(selSortQuantity) ? "selected" : "" %>>Xếp theo Số lượng: Mặc định</option>
                            <option value="desc" <%= "desc".equals(selSortQuantity) ? "selected" : "" %>>Số lượng: Nhiều nhất</option>
                            <option value="asc" <%= "asc".equals(selSortQuantity) ? "selected" : "" %>>Số lượng: Ít nhất</option>
                        </select>
                    </div>
                </div>
            </form>

            <div class="table-responsive">
                <table id="tblStatistics" class="data-table">
                    <thead>
                        <tr>
                            <th class="col-center" style="width: 60px;">TT</th>
                            <th style="width: 140px;">MÃ MẶT HÀNG</th>
                            <th>TÊN MẶT HÀNG</th>
                            <th class="col-number" style="width: 180px;">SỐ LƯỢNG ĐÃ BÁN</th>
                            <th class="col-number" style="width: 200px;">TỔNG DOANH THU</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listStats != null && !listStats.isEmpty()) {
                                int stt = 1;
                                for (ProductRevenueStat9 stat : listStats) {
%>

                        <tr ondblclick="viewProductDetail('<%= stat.getSKUCode() %>')" title="Click đúp để xem chi tiết lịch sử giao dịch">
                            <td class="col-center" style="color: #94a3b8;"><%= stt++ %></td>
                            <td><%= stat.getSKUCode() %></td>
                            <td class="col-bold"><%= stat.getProduct().getProductName() %></td>
                            <td class="col-number"><%= stat.getTotalQuantitySold() %></td>
                            <td class="col-number col-bold"><%= df.format(stat.getTotalRevenue()) %> đ</td>
                        </tr>
                        <%
                                }
                            } else {
%>
                        <tr>
                            <td colspan="5" class="col-center" style="padding: 30px; color: #94a3b8;">
                                Không tìm thấy dữ liệu mặt hàng phù hợp.
                            </td>
                        </tr>
                        <%
    }
%>
                    </tbody>
                </table>

                <div class="summary-bar">
                    <div>Hiển thị <strong><%= listStats != null ? listStats.size() : 0 %></strong> / <strong><%= listStats != null ? listStats.size() : 0 %></strong> mặt hàng</div>
                    <div style="display: flex; gap: 32px;">
                        <div>Tổng số lượng đã bán: <span class="summary-value"><%= grandTotalQuantity %></span></div>
                        <div>Tổng doanh thu: <span class="summary-value"><%= df.format(grandTotalRevenue) %> đ</span></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="tip-banner">
            <span><strong>Mẹo thao tác:</strong> Click đúp (Double click) vào bất kỳ dòng mặt hàng nào để xem bảng chi tiết lịch sử giao dịch.</span>
        </div>
    </main>

    <footer class="app-footer">
        <div>&copy; 2026 ShopMan. Tốt cho mọi nhà.</div>
        <div>Hệ thống quản lý cửa hàng</div>
    </footer>

    <script>
        function viewProductDetail(skuCode) {
            window.location.href = 'ProductTransactionDetailUI9.jsp?skuCode=' + encodeURIComponent(skuCode);
        }
    </script>
</body>
</html>
