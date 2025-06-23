<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KeyCraft - Premium Mechanical Keyboards</title>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
        }
        .product-card { transition: transform 0.3s; }
        .product-card:hover { transform: translateY(-5px); }
        .carousel-inner img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        .sale-section {
            background: linear-gradient(to bottom, #eac160, #ff1212);
            padding: 20px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <%@ include file="header.jsp" %>

    <!-- Hero Section -->
    <section class="hero-section text-center">
        <div class="container">
            <h1 class="display-4 mb-4">Premium Mechanical Keyboards</h1>
            <p class="lead mb-4">Discover the perfect typing experience with our curated collection.</p>
            <a href="/products" class="btn btn-light btn-lg">
                <i class="fas fa-shopping-cart"></i> Shop Now
            </a>
        </div>
    </section>

    <!-- Sale Product Section (New Products) -->
    <section class="bg-gray-100 py-5">
        <div class="container sale-section">
            <div class="row">
                <div class="col-12 text-center mb-4">
                    <h2 class="text-white text-2xl font-bold d-flex align-items-center justify-content-center">
                        <img src="https://bizweb.dktcdn.net/100/436/596/themes/980306/assets/flash.png?1746716722609" alt="FLASH SALE" width="32" height="32" class="me-2" />
                        Sản Phẩm Mới
                    </h2>
                </div>
                <div class="col-12">
                    <div class="row row-cols-2 row-cols-sm-3 row-cols-lg-4 g-4">
                        <c:choose>
                            <c:when test="${not empty newProducts}">
                                <c:forEach items="${newProducts}" var="product">
                                    <div class="col">
                                        <jsp:include page="productCard.jsp">
                                            <jsp:param name="title" value="${product.name}" />
                                            <jsp:param name="price" value="${product.price}"/>
                                            <jsp:param name="image" value="${product.imageUrl}" />
                                            <jsp:param name="url" value="/product/${product.id}" />
                                            <jsp:param name="id" value="${product.id}" />
                                        </jsp:include>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center">No new products available.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Sản Phẩm Đề Xuất</h2>
            <div class="row">
                <c:choose>
                    <c:when test="${not empty featuredProducts}">
                        <c:forEach items="${featuredProducts}" var="product">
                            <div class="col-md-3 mb-4">
                                <jsp:include page="productCard.jsp">
                                    <jsp:param name="title" value="${product.name}" />
                                    <jsp:param name="price" value="${product.price}"/>
                                    <jsp:param name="image" value="${product.imageUrl}" />
                                    <jsp:param name="url" value="/product/${product.id}" />
                                    <jsp:param name="id" value="${product.id}" />
                                </jsp:include>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center">No featured products available.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Suggested Products -->
    <section class="bg-gray-100 py-5">
        <div class="container ">
            <div class="row">
                <div class="col-12 text-center mb-4">
                    <h2 class="text-2xl font-bold d-flex align-items-center justify-content-center">
                        Sản Phẩm Gợi Ý
                    </h2>
                </div>
                <div class="col-12">
                    <div class="row row-cols-2 row-cols-sm-3 row-cols-lg-4 g-4">
                        <c:choose>
                            <c:when test="${not empty suggestedProducts}">
                                <c:forEach items="${suggestedProducts}" var="product">
                                    <div class="col">
                                        <jsp:include page="productCard.jsp">
                                            <jsp:param name="title" value="${product.name}" />
                                            <jsp:param name="price" value="${product.price}"/>
                                            <jsp:param name="image" value="${product.imageUrl}" />
                                            <jsp:param name="url" value="/product/${product.id}" />
                                            <jsp:param name="id" value="${product.id}" />
                                        </jsp:include>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center">No suggested products available.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Toast Notification -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="notification-toast" class="toast" role="alert">
            <div class="toast-header">
                <strong class="me-auto">KeyCraft</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toast-message"></div>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script src="/webjars/jquery/3.7.0/jquery.min.js"></script>
    <script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function addToCart(productId, quantity) {
            fetch('/cart/add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ productId, quantity })
            })
            .then(r => r.json())
            .then(json => {
                if (json.success) {
                    showToast(json.message, 'success');
                    refreshCartCount();
                } else {
                    showToast(json.message, 'error');
                }
            })
            .catch(() => showToast('Error adding to cart', 'error'));
        }

        function refreshCartCount() {
            fetch('/cart/count')
                .then(r => r.json())
                .then(j => {
                    const cnt = j.cartItemCount || 0;
                    const el = document.getElementById('cart-count');
                    if (el) {
                        el.textContent = cnt;
                        el.style.display = cnt > 0 ? 'inline-block' : 'none';
                    }
                })
                .catch(() => {});
        }

        function showToast(msg, type) {
            const toastEl = document.createElement('div');
            toastEl.className = 'toast align-items-center text-white ' + (type === 'success' ? 'bg-success' : 'bg-danger') + ' border-0';
            toastEl.role = 'alert';
            toastEl.innerHTML = `
                <div class="toast-body">${msg}</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            `;
            document.body.append(toastEl);
            new bootstrap.Toast(toastEl, { delay: 2000 }).show();
        }
    </script>
</body>
</html>
