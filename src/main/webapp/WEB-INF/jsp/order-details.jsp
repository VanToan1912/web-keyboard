<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng #${order.id} - KeyCraft</title>
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
        .btn-outline-secondary {
            color: #6c757d;
            border-color: #6c757d;
        }
        .btn-outline-secondary:hover {
            background-color: #6c757d;
            color: #ffffff;
        }
        strong { color: #333333; }
        .order-summary .d-flex { color: #495057; }
        .order-summary .d-flex strong { color: #0066cc; }
    </style>
</head>
<body>
<!-- Thanh điều hướng -->
<%@ include file="header.jsp" %>

<!-- Nội dung chi tiết đơn hàng -->
<div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2><i class="fas fa-receipt text-primary"></i> Đơn hàng #${order.id}</h2>
        <a href="/orders" class="btn btn-outline-secondary">
            <i class="fas fa-arrow-left"></i> Quay lại danh sách đơn hàng
        </a>
    </div>

    <div class="row">
        <div class="col-lg-8">
            <!-- Thông tin đơn hàng -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5><i class="fas fa-info-circle text-info"></i> Thông tin đơn hàng</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Ngày đặt hàng:</strong><br>
                            <fmt:formatDate value="${createdAtDate}" pattern="MMM dd, yyyy 'lúc' HH:mm" />
                        </div>
                        <div class="col-md-6">
                            <strong>Trạng thái:</strong><br>
                            <c:choose>
                                <c:when test="${order.status == 'PENDING'}">
                                    <span class="badge bg-warning">Chờ xử lý</span>
                                </c:when>
                                <c:when test="${order.status == 'CONFIRMED'}">
                                    <span class="badge bg-success">Đã xác nhận</span>
                                </c:when>
                                <c:when test="${order.status == 'SHIPPED'}">
                                    <span class="badge bg-info">Đang giao</span>
                                    <c:if test="${not empty order.trackingCode}">
                                        <div class="mt-1 text-muted">Mã theo dõi: <code>${order.trackingCode}</code></div>
                                    </c:if>
                                </c:when>
                                <c:when test="${order.status == 'DELIVERED'}">
                                    <span class="badge bg-primary">Đã giao</span>
                                    <c:if test="${not empty order.trackingCode}">
                                        <div class="mt-1 text-muted">Mã theo dõi: <code>${order.trackingCode}</code></div>
                                    </c:if>
                                </c:when>
                                <c:when test="${order.status == 'CANCELLED'}">
                                    <span class="badge bg-danger">Đã hủy</span>
                                    <c:if test="${not empty order.trackingCode}">
                                        <div class="mt-1 text-muted">Trả lại: <code>${order.trackingCode}</code></div>
                                    </c:if>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sản phẩm trong đơn hàng -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5><i class="fas fa-box text-success"></i> Sản phẩm trong đơn</h5>
                </div>
                <div class="card-body">
                    <c:forEach items="${order.orderItems}" var="item">
                        <div class="row align-items-center mb-3 pb-3 border-bottom">
                            <div class="col-md-2">
                                <img src="${item.product.imageUrl}" alt="${item.product.name}"
                                     class="img-fluid rounded" style="height: 80px; object-fit: cover;">
                            </div>
                            <div class="col-md-5">
                                <h6 class="mb-1 text-dark">${item.product.name}</h6>
                                <small class="text-muted">${item.product.brand}</small>
                                <c:if test="${item.product.switchType != null}">
                                    <small class="text-muted d-block">${item.product.switchType} switches</small>
                                </c:if>
                            </div>
                            <div class="col-md-2 text-center">
                                <strong>Số lượng: ${item.quantity}</strong>
                            </div>
                            <div class="col-md-2 text-center">
                                <strong>$${item.unitPrice}</strong>
                            </div>
                            <div class="col-md-1 text-end">
                                <strong>$${item.totalPrice}</strong>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Thông tin giao hàng và thanh toán -->
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h6><i class="fas fa-truck text-info"></i> Địa chỉ giao hàng</h6>
                        </div>
                        <div class="card-body">
                            <address class="text-dark">${order.shippingAddress}</address>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h6><i class="fas fa-file-invoice text-primary"></i> Địa chỉ thanh toán</h6>
                        </div>
                        <div class="card-body">
                            <address class="text-dark">${order.billingAddress}</address>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tóm tắt đơn hàng -->
        <div class="col-lg-4">
            <div class="card order-summary">
                <div class="card-header">
                    <h5><i class="fas fa-calculator text-primary"></i> Tóm tắt đơn hàng</h5>
                </div>
                <div class="card-body">
                    <c:set var="subtotal" value="0" />
                    <c:forEach items="${order.orderItems}" var="item">
                        <c:set var="subtotal" value="${subtotal + item.totalPrice}" />
                    </c:forEach>

                    <div class="d-flex justify-content-between mb-2">
                        <span>Tạm tính:</span>
                        <span>$${subtotal}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Phí vận chuyển:</span>
                        <span class="text-success">Miễn phí</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Thuế:</span>
                        <span>$0.00</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <strong>Tổng cộng:</strong>
                        <strong>$${order.totalAmount}</strong>
                    </div>
                </div>
            </div>

            <div class="card mt-3">
                <div class="card-header">
                    <h6><i class="fas fa-credit-card text-success"></i> Phương thức thanh toán</h6>
                </div>
                <div class="card-body">
                    <p class="text-dark">${order.paymentMethod}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>