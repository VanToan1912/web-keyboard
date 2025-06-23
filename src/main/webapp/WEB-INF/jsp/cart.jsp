<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Giỏ Hàng - KeyCraft</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    .cart-container { max-width: 1000px; margin: 0 auto; padding: 20px; }
    .cart-header { font-size: 24px; font-weight: bold; margin-bottom: 20px; }
    .cart-content { display: flex; gap: 60px; }
    .cart-items { flex-grow: 1; }
    .cart-item { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px solid #eee; }
    .cart-item img { width: 100px; height: 100px; object-fit: cover; margin-right: 15px; }
    .cart-item-details { flex-grow: 1; }
    .cart-item-name { font-size: 16px; font-weight: 500; margin-bottom: 5px; }
    .cart-item-price { font-size: 14px; color: #555; margin-bottom: 5px; }
    .cart-quantity { width: 120px; display: flex; align-items: center; }
    .cart-quantity input { width: 60px; text-align: center; border: 1px solid #ddd; height: 30px; font-size: 16px; font-weight: bold; }
    .cart-quantity button { width: 30px; height: 30px; border: 1px solid #ddd; background: #fff; font-size: 14px; }
    .cart-summary { width: 250px; text-align: right; }
    .cart-summary-item { font-size: 14px; margin-bottom: 10px; }
    .cart-total { font-size: 18px; font-weight: bold; color: #0066cc; }
    .cart-actions { display: flex; flex-direction: column; gap: 20px; margin-top: 20px; }
    .btn-black { background-color: #000; color: #fff; padding: 12px 30px; font-size: 16px; width: 100%; }
    .btn-black:hover { background-color: #ffc107; }
    .btn-outline-secondary { padding: 10px 20px; font-size: 14px; width: 100%; }
    .divider { border-top: 2px solid #ccc; margin: 20px 0; }
  </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="cart-container mt-4">
  <h2 class="cart-header">Trang chủ > Giỏ hàng</h2>
  <h3 class="cart-header">GIỎ HÀNG (<span id="cart-count">${cartItemCount}</span> sản phẩm)</h3>

  <c:if test="${empty cartItems}">
    <div class="text-center py-5">
      <img src="https://via.placeholder.com/150" alt="Giỏ hàng trống" class="mb-3" />
      <p class="text-muted">Giỏ Hàng Trống</p>
      <a href="/products" class="btn btn-outline-secondary">TIẾP TỤC MUA HÀNG</a>
    </div>
  </c:if>

  <c:if test="${not empty cartItems}">
    <div class="cart-content">
      <div class="cart-items">
        <c:forEach var="item" items="${cartItems}">
          <div class="cart-item" data-cart-item-id="${item.id}">
            <img src="${item.product.imageUrl}" alt="${item.product.name}" />
            <div class="cart-item-details">
              <h5 class="cart-item-name">${item.product.name}</h5>
              <p class="cart-item-price">
                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₫" pattern="#,##0₫" />
              </p>
            </div>

            <div class="cart-quantity">
              <button class="btn btn-sm" onclick="removeFromCart('${item.id}')">
                <i class="fas fa-trash"></i>
              <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(this, -1)"
                      data-cart-item-id="${item.id}" ${item.quantity <= 1 ? 'disabled' : ''}>-</button>
              <input type="number" id="input-${item.id}" class="form-control text-center"
                     value="${not empty item.quantity ? item.quantity : 1}" min="1" max="10" data-product-price="${item.product.price}"
                     onchange="changeQuantity(this, 0)" readonly />
              <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(this, 1)"
                      data-cart-item-id="${item.id}" ${item.quantity >= 10 ? 'disabled' : ''}>+</button>
            </div>
          </div>
          <button class="btn btn-outline-secondary w-100 mt-2" onclick="clearCart()">Xoá tất cả sản phẩm</button>
        </c:forEach>
      </div>

      <div class="cart-summary">
        <div class="cart-summary-item">Tạm tính: <span id="cart-total">
                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫" pattern="#,##0₫" />
                </span></div>
        <div class="divider"></div>
        <div class="cart-summary-item cart-total">Thành tiền: <span id="final-total">
                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₫" pattern="#,##0₫" />
                </span></div>
        <div class="cart-actions">
          <button class="btn btn-black" onclick="proceedToCheckout()">THANH TOÁN NGAY</button>
          <button class="btn btn-outline-secondary" onclick="window.location.href='/products'">TIẾP TỤC MUA HÀNG</button>

        </div>
      </div>
    </div>
  </c:if>
</div>

<%@ include file="footer.jsp" %>

<!-- Toast -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
  <div id="notification-toast" class="toast" role="alert">
    <div class="toast-header">
      <strong class="me-auto">KeyCraft</strong>
      <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
    </div>
    <div class="toast-body" id="toast-message"></div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function changeQuantity(el, delta) {
    let cartItemId = el.getAttribute('data-cart-item-id');
    if (!cartItemId) {
      cartItemId = el.id.replace('input-', '');
      el = document.getElementById('input-' + cartItemId);
      delta = 0;
    }
    const input = delta === 0 ? el : el.closest('.cart-quantity').querySelector('input');
    let qty = parseInt(input.value) || 1;
    if (delta !== 0) {
      qty = Math.max(1, Math.min(10, qty + delta));
      input.value = qty;
    }
    updateQuantity(cartItemId, qty);
  }

  function updateQuantity(cartItemId, quantity) {
    fetch('/cart/update', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ cartItemId, quantity })
    })
            .then(res => res.json())
            .then(data => {
              showNotification(data.message, data.success ? 'success' : 'error');
              if (data.success) updateCartDisplay(data, cartItemId, quantity);
            });
  }

  function updateCartDisplay(data, cartItemId, quantity) {
    document.getElementById('cart-count').textContent = data.cartItemCount;
    const span = document.querySelector('#subtotal-' + cartItemId + ' span');
    const input = document.getElementById('input-' + cartItemId);
    if (span && input) {
      const price = parseFloat(input.dataset.productPrice);
      span.textContent = (price * quantity).toLocaleString('vi-VN') + '₫';
      input.value = quantity;
    }
    if (data.cartTotal !== undefined) {
      document.getElementById('cart-total').textContent = data.cartTotal.toLocaleString('vi-VN') + '₫';
      document.getElementById('final-total').textContent = data.cartTotal.toLocaleString('vi-VN') + '₫';
    }
  }

  function removeFromCart(cartItemId) {
    fetch('/cart/remove', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ cartItemId })
    })
            .then(res => res.json())
            .then(data => {
              showNotification(data.message, data.success ? 'success' : 'error');
              if (data.success) {
                document.querySelector('[data-cart-item-id="' + cartItemId + '"]').remove();
                updateCartDisplay(data);
                if (data.cartItemCount === 0) location.reload();
              }
            });
  }

  function clearCart() {
    if (!confirm('Are you sure?')) return;
    fetch('/cart/clear', { method: 'POST' })
            .then(res => res.json())
            .then(data => { if (data.success) location.reload(); });
  }

  function proceedToCheckout() {
    window.location.href = '/checkout';
  }

  function showNotification(msg, type) {
    const toast = document.getElementById('notification-toast');
    const body = document.getElementById('toast-message');
    body.textContent = msg;
    toast.className = 'toast ' + (type === 'success' ? 'bg-success text-white' : 'bg-danger text-white');
    new bootstrap.Toast(toast).show();
  }
</script>
</body>
</html>