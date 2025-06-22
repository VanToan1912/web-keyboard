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
                    <img src="/img/logo.png" alt="Kibo" style="height: 4.5rem;" />
                </a>
            </div>
            <div class="d-flex align-items-center gap-3">
                <c:choose>
                    <c:when test="${not empty currentUser}">
                        <a href="/orders" title="Tài khoản" class="text-dark text-decoration-none">
                            <i class="fas fa-user fa-lg"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="/login" title="Tài khoản" class="text-dark text-decoration-none">
                            <i class="fas fa-user fa-lg"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="/cart" title="Giỏ hàng" class="position-relative text-dark text-decoration-none">
                    <i class="fas fa-shopping-cart fa-lg"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge bg-danger rounded-circle">${cartItemCount}</span>
                </a>
                <a href="/search" title="Tìm kiếm" class="text-dark text-decoration-none">
                    <i class="fas fa-search fa-lg"></i>
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
