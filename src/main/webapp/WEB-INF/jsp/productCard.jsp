<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="col-md-6 col-lg-4 mb-4 product-item" style="height: 440px"
     data-category="${param.category}"
     data-brand="${param.brand}"
     data-price="${param.price}"
     data-name="${param.title}">
    <div class="card product-card h-100 text-center" style="width: 300px">
        <a href="${param.url}" class="text-decoration-none text-dark">
            <img src="${param.image}" class="card-img-top" alt="${param.title}"
                 style="height: 200px; object-fit: cover;">
        </a>
        <div class="card-body d-flex flex-column">
            <a href="${param.url}" class="text-decoration-none text-dark">
                <h5 class="card-title">${param.title}</h5>
            </a>
            <p class="text-muted small">${param.brand}</p>
            <div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="h5 text-primary">
                        <fmt:formatNumber value="${param.price}" pattern="#,###" />₫
                    </span>
                    <small class="text-success">
                        <i class="fas fa-box"></i> ${param.stock} in stock
                    </small>
                </div>
                <c:if test="${not empty param.switchType}">
                    <small class="text-muted d-block">
                        <i class="fas fa-cog"></i> ${param.switchType} switches
                    </small>
                </c:if>
            </div>
        </div>
        <div class="card-footer">
            <button class="btn btn-primary w-100" onclick="addToCart(${param.id}, 1)">
                <i class="fas fa-cart-plus"></i> Add to Cart
            </button>
        </div>
    </div>
</div>
