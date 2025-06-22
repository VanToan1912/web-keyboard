<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="bg-white shadow py-4">
    <div class="container px-4">
        <div class="d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <span class="text-muted me-2">HOTLINE TƯ VẤN:</span>
                <a href="/" class="text-dark fw-bold text-decoration-none">028 3896 6780</a>
            </div>
            <div>
                <a href="/" title="Kibo">
                    <img src="<%= request.getContextPath() %>/img/logo.png" alt="Kibo" style="height: 4.5rem;" />
                </a>
            </div>
            <div class="d-flex align-items-center gap-3">
                <c:if test="${currentUser != null && currentUser.role == 'ADMIN'}">
                    <a class="nav-link nav-item" href="/dashboard">Admin Panel</a>
                </c:if>
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user fa-lg"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <c:choose>
                            <c:when test="${not empty currentUser}">
                                <li><a class="dropdown-item" href="/orders">Đơn Hàng</a></li>
                                <li><a class="dropdown-item" href="/auth/logout">Đăng Xuất</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a class="dropdown-item" href="/login">Đăng Nhập</a></li>
                                <li><a class="dropdown-item" href="/signup">Đăng Ký</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                <a href="/cart" title="Giỏ hàng" class="position-relative text-dark text-decoration-none">
                    <i class="fas fa-shopping-cart fa-lg"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge bg-danger rounded-circle">${cartItemCount}</span>
                </a>
            </div>
        </div>
        <nav class="mt-4">
            <ul class="nav justify-content-center gap-3 text-uppercase">
                <li class="nav-item">
                    <a class="nav-link fw-bold text-dark" href="/">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-bold text-dark" href="/products">Keycap bộ <i class="fas fa-angle-down ms-1"></i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-bold text-dark" href="/products">Bàn phím cơ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-bold text-dark" href="/products">Mods phím</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-bold text-dark" href="/products">Sản phẩm <i class="fas fa-angle-down ms-1"></i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-bold text-dark" href="/">Về Kibo <i class="fas fa-angle-down ms-1"></i></a>
                </li>
            </ul>
        </nav>
    </div>
</header>
