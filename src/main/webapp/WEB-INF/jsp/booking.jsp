<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - KeyCraft</title>
    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Màu sắc tùy chỉnh */
        .card {
            border-color: #e9ecef;
            background-color: #ffffff;
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom-color: #e9ecef;
        }
        .badge {
            font-weight: 600;
            padding: 0.4em 0.8em;
        }
        .badge.bg-warning { background-color: #ffc107; color: #212529; }
        .badge.bg-success { background-color: #28a745; color: #ffffff; }
        .badge.bg-info { background-color: #17a2b8; color: #ffffff; }
        .badge.bg-primary { background-color: #0066cc; color: #ffffff; }
        .badge.bg-danger { background-color: #dc3545; color: #ffffff; }
        .text-muted { color: #6c757d !important; }
        .btn-outline-primary {
            color: #0066cc;
            border-color: #0066cc;
        }
        .btn-outline-primary:hover {
            background-color: #0066cc;
            color: #ffffff;
        }
        .btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        .btn-outline-danger:hover {
            background-color: #dc3545;
            color: #ffffff;
        }
        strong { color: #333333; }
    </style>
</head>
<body>
<!-- Thanh điều hướng -->
<%@ include file="header.jsp" %>

<!-- Nội dung đơn hàng -->
<body>

<div class="container my-4">

    <%-- Tiêu đề trang --%>
    <div class="text-center mb-4">
        <h2><i class="fas fa-pen-to-square text-primary"></i> Đặt hàng Pre-Order</h2>
        <p class="text-muted">
            Vui lòng điền thông tin vào biểu mẫu bên dưới. Chúng tôi sẽ liên hệ lại với bạn để xác nhận ngay khi có hàng.
        </p>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header">
                    <h5 class="mb-0">Thông tin liên hệ & sản phẩm</h5>
                </div>
                <div class="card-body">

                    <%-- Hiển thị thông báo thành công (nếu có) sau khi gửi form --%>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle"></i> ${successMessage}
                        </div>
                    </c:if>

                    <%-- Hiển thị thông báo lỗi (nếu có) --%>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <%-- Form đặt hàng --%>
                    <%-- Xóa bỏ thuộc tính modelAttribute không hợp lệ --%>
                    <form action="/booking/submit" method="POST">
                        <div class="row">

                            <%-- Cột thông tin cá nhân --%>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="customerName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                    <%-- SỬA LẠI NAME --%>
                                    <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Nguyễn Văn A" required>
                                </div>
                                <div class="mb-3">
                                    <label for="customerEmail" class="form-label">Email <span class="text-danger">*</span></label>
                                     <%-- SỬA LẠI NAME --%>
                                    <input type="email" class="form-control" id="customerEmail" name="customerEmail" placeholder="email@example.com" required>
                                </div>
                                <div class="mb-3">
                                    <label for="customerPhone" class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                     <%-- SỬA LẠI NAME --%>
                                    <input type="tel" class="form-control" id="customerPhone" name="customerPhone" placeholder="09xxxxxxxx" required>
                                </div>
                            </div>

                            <%-- Cột thông tin sản phẩm --%>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="serviceName" class="form-label">Tên sản phẩm muốn đặt <span class="text-danger">*</span></label>
                                     <%-- SỬA LẠI NAME --%>
                                    <input type="text" class="form-control" id="serviceName" name="serviceName" placeholder="Ví dụ: Bàn phím cơ XYZ" required>
                                </div>
                                <div class="mb-3">
                                    <label for="quantity" class="form-label">Số lượng</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" value="1" min="1">
                                </div>
                            </div>
                        </div>

                        <%-- Ghi chú --%>
                        <div class="mb-3">
                            <label for="notes" class="form-label">Ghi chú thêm</label>
                            <textarea class="form-control" id="notes" name="notes" rows="3" placeholder="Ví dụ: màu sắc, phiên bản, yêu cầu đặc biệt..."></textarea>
                        </div>

                        <%-- Nút gửi --%>
                        <div class="text-end mt-4">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i> Gửi yêu cầu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<%@ include file="footer.jsp" %>

<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    $(function () {
        $('.cancel-order-btn').on('click', function () {
            const id = $(this).data('id');
            if (confirm("Bạn có chắc muốn hủy đơn hàng #" + id + "?")) {
                $.ajax({
                    url: '/api/orders/' + id,
                    type: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify({ status: 'CANCELLED' }),
                    success: () => location.reload(),
                    error: () => alert("Không thể hủy đơn hàng.")
                });
            }
        });
    });
</script>
</body>
</html>