<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products - KeyCraft</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .product-card {
            transition: transform 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .filter-sidebar {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container my-4">
    <div class="row">
        <!-- Sidebar Filters -->
        <div class="col-lg-3 mb-4">
            <div class="filter-sidebar">
                <h5><i class="fas fa-filter"></i> Filters</h5>
                <div class="mb-3">
                    <label>Search</label>
                    <input type="text" class="form-control" id="searchInput" placeholder="Search products...">
                </div>
                <div class="mb-3">
                    <label>Category</label>
                    <select class="form-select" id="categoryFilter">
                        <option value="">All Categories</option>
                        <option value="mechanical-keyboards">Mechanical Keyboards</option>
                        <option value="switches">Switches</option>
                        <option value="keycaps">Keycaps</option>
                        <option value="accessories">Accessories</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Brand</label>
                    <select class="form-select" id="brandFilter">
                        <option value="">All Brands</option>
                        <option value="Keychron">Keychron</option>
                        <option value="Ducky">Ducky</option>
                        <option value="Leopold">Leopold</option>
                        <option value="Cherry">Cherry</option>
                        <option value="Varmilo">Varmilo</option>
                        <option value="HHKB">HHKB</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label>Price Range</label>
                    <div class="row">
                        <div class="col-6"><input type="number" class="form-control" placeholder="Min" id="minPrice"></div>
                        <div class="col-6"><input type="number" class="form-control" placeholder="Max" id="maxPrice"></div>
                    </div>
                </div>
                <button class="btn btn-primary w-100" onclick="applyFilters()">
                    <i class="fas fa-search"></i> Apply Filters
                </button>
            </div>
        </div>

        <!-- Product Grid -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Our Products</h2>
                <span class="text-muted" id="productCount">${products.size()} products found</span>
            </div>
            <div class="row" id="productsGrid">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach items="${products}" var="product">
                            <jsp:include page="productCard.jsp">
                                <jsp:param name="id" value="${product.id}"/>
                                <jsp:param name="title" value="${product.name}"/>
                                <jsp:param name="price" value="${product.price}"/>
                                <jsp:param name="image" value="${product.imageUrl}"/>
                                <jsp:param name="url" value="/product/${product.id}"/>
                                <jsp:param name="brand" value="${product.brand}"/>
                                <jsp:param name="switchType" value="${product.switchType}"/>
                                <jsp:param name="stock" value="${product.stock}"/>
                                <jsp:param name="category" value="${product.category}"/>
                            </jsp:include>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div id="noResults" class="text-center py-5">
                            <i class="fas fa-search fa-3x text-muted mb-3"></i>
                            <h4>No products found</h4>
                            <p class="text-muted">Try adjusting your filters or search terms.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Toast container -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="notification-toast" class="toast border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">KeyCraft</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toast-message"></div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    function applyFilters() {
        const searchTerm = $('#searchInput').val().toLowerCase();
        const category = $('#categoryFilter').val();
        const brand = $('#brandFilter').val();
        const minPrice = parseFloat($('#minPrice').val()) || 0;
        const maxPrice = parseFloat($('#maxPrice').val()) || Infinity;

        let visibleCount = 0;

        $('.product-item').each(function () {
            const $item = $(this);
            const name = $item.data('name').toLowerCase();
            const categoryVal = $item.data('category');
            const brandVal = $item.data('brand');
            const price = parseFloat($item.data('price'));

            let show = true;

            if (searchTerm && !name.includes(searchTerm)) show = false;
            if (category && categoryVal !== category) show = false;
            if (brand && brandVal !== brand) show = false;
            if (price < minPrice || price > maxPrice) show = false;

            $item.toggle(show);
            if (show) visibleCount++;
        });

        $('#noResults').toggle(visibleCount === 0);
        $('#productCount').text(`${visibleCount} products found`);
    }

    function addToCart(productId, quantity = 1) {
        fetch('/cart/add', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: new URLSearchParams({productId, quantity})
        })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    showToast(data.message, 'success');
                    updateCartBadge(data.cartItemCount);
                } else {
                    showToast(data.message || 'Failed to add product to cart', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('An error occurred while adding to cart', 'error');
            });
    }

    function showToast(message, type) {
        const toastEl = document.getElementById('notification-toast');
        const toastBody = document.getElementById('toast-message');
        toastBody.textContent = message;
        toastEl.className = `toast border-0 ${type == 'success' ? 'bg-success text-white' : 'bg-danger text-white'}`;
        const toast = new bootstrap.Toast(toastEl, { delay: 2000 });
        toast.show();
    }

    function updateCartBadge(count) {
        const cartCountElement = document.getElementById('cart-count');
        if (cartCountElement) {
            cartCountElement.textContent = count;
            cartCountElement.style.display = count > 0 ? 'inline-block' : 'none';
        }
    }
</script>
</body>
</html>
