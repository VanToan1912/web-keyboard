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
<div class="container my-4">
    <h2><i class="fas fa-shopping-bag text-primary"></i> Đơn hàng của tôi</h2>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="text-center py-5">
                <i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
                <h4>Chưa có đơn hàng</h4>
                <p class="text-muted">Bạn chưa đặt bất kỳ đơn hàng nào. Hãy bắt đầu mua sắm để xem đơn hàng tại đây.</p>
                <a href="/products" class="btn btn-primary">Bắt đầu mua sắm</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <c:forEach items="${orders}" var="order">
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <div class="row align-items-center">
                                    <div class="col-md-6">
                                        <h6 class="mb-0">Đơn hàng</h6>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${order.createdAtDate}" pattern="MMM dd, yyyy 'lúc' HH:mm" />
                                        </small>
                                    </div>
                                    <div class="col-md-3 text-center">
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="badge bg-warning">Chờ xử lý</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                <span class="badge bg-success">Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">
                                                <span class="badge bg-info">Đang giao</span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <span class="badge bg-primary">Đã giao</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="badge bg-danger">Đã hủy</span>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-3 text-end">
                                        <strong>$${order.totalAmount}</strong>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <h6>Sản phẩm (${order.orderItems.size()})</h6>
                                        <div class="row">
                                            <c:forEach items="${order.orderItems}" var="item" varStatus="loop">
                                                <c:if test="${loop.index < 3}">
                                                    <div class="col-md-4 mb-2">
                                                        <div class="d-flex align-items-center">
                                                            <img src="${item.product.imageUrl}" alt="${item.product.name}"
                                                                 class="me-2 rounded" style="width: 40px; height: 40px; object-fit: cover;">
                                                            <div>
                                                                <small class="fw-bold">${item.product.name}</small>
                                                                <small class="text-muted d-block">Số lượng: ${item.quantity}</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${order.orderItems.size() > 3}">
                                                <div class="col-md-4">
                                                    <small class="text-muted">+${order.orderItems.size() - 3} sản phẩm khác</small>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="col-md-4 text-end">
                                        <a href="/orders/${order.id}" class="btn btn-outline-primary">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </a>
                                        <c:if test="${order.status == 'PENDING' || order.status == 'CONFIRMED'}">
                                            <button class="btn btn-outline-danger ms-2 cancel-order-btn" data-id="${order.id}">
                                                <i class="fas fa-times"></i> Hủy đơn hàng
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

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
