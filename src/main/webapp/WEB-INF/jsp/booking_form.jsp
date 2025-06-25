<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đơn hàng - KeyCraft</title> <%-- Sửa lại Title cho đúng trang --%>
    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .receipt-container {
            border: 1px solid #e9ecef;
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 0.5rem; /* Thêm bo góc cho đẹp */
            box-shadow: 0 4px 8px rgba(0,0,0,0.05); /* Thêm đổ bóng nhẹ */
        }
        .receipt-header {
            text-align: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid #eee;
            padding-bottom: 1rem;
        }
        .receipt-item {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px dashed #f1f1f1;
        }
        .receipt-item:last-child {
            border-bottom: none;
        }
        strong { color: #333333; }
        /* ... các style khác của bạn ... */
    </style>
</head>
<body> <%@ include file="header.jsp" %>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">

            <div class="receipt-container">
                <div class="receipt-header">
                    <h2 class="h4">Xác Nhận Đặt Hàng Trước</h2>
                    <p class="text-muted">Cảm ơn bạn đã đặt hàng! Chúng tôi sẽ liên hệ lại sớm.</p>
                </div>

                <div>
                    <div class="receipt-item">
                        <span>Mã đơn hàng:</span>
                        <strong>#${booking.id}</strong>
                    </div>
                    <div class="receipt-item">
                        <span>Ngày tạo:</span>
                        <strong>
                            <fmt:formatDate value="${booking.createdAtAsDate}" pattern="dd-MM-yyyy HH:mm:ss"/>
                        </strong>
                    </div>
                    <div class="receipt-item">
                        <span>Trạng thái:</span>
                        <%-- SỬA LẠI: Dùng thẻ span thay vì td --%>
                        <span>
                            <c:choose>
                                <c:when test="${booking.status == 'PENDING'}"><span
                                        class="badge bg-warning">Chờ xử lý</span></c:when>
                                <c:when test="${booking.status == 'CONFIRMED'}"><span
                                        class="badge bg-success">Đã xác nhận</span></c:when>
                                <%-- Các trạng thái khác --%>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <hr>

                <div>
                    <h5 class="h6 mb-3">Thông tin khách hàng</h5>
                    <div class="receipt-item">
                        <span>Họ và tên:</span>
                        <strong>${booking.customerName}</strong>
                    </div>
                    <div class="receipt-item">
                        <span>Email:</span>
                        <strong>${booking.customerEmail}</strong>
                    </div>
                    <div class="receipt-item">
                        <span>Số điện thoại:</span>
                        <strong>${booking.customerPhone}</strong>
                    </div>
                </div>

                <hr>

                <div>
                    <h5 class="h6 mb-3">Chi tiết sản phẩm</h5>
                    <div class="receipt-item">
                        <span>Tên sản phẩm:</span>
                        <strong>${booking.serviceName}</strong>
                    </div>
                    <div class="receipt-item">
                        <span>Số lượng:</span>
                        <strong>${booking.quantity}</strong>
                    </div>
                    <div class="receipt-item">
                        <span>Ghi chú:</span>
                        <strong>${not empty booking.notes ? booking.notes : 'Không có'}</strong>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <a href="/booking" class="btn btn-primary">Tạo đơn hàng khác</a>
                </div>
            </div>

        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>