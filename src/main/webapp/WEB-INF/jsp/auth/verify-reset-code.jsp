<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Xác minh mã đặt lại - KeyCraft</title>
  <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <link href="/webjars/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(135deg, #4a90e2 0%, #6b48cc 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
    }
    .verify-card {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(74, 144, 226, 0.3);
      padding: 2rem;
    }
    .form-label { color: #2c3e50; }
    .form-control { border-color: #dfe6e9; background-color: #f8f9fa; }
    .form-control:focus { border-color: #4a90e2; box-shadow: 0 0 5px rgba(74, 144, 226, 0.5); }
    .btn-primary { background-color: #4a90e2; border-color: #4a90e2; }
    .btn-primary:hover { background-color: #357abd; border-color: #357abd; }
    .text-indigo-600 { color: #4a90e2; }
    .alert-danger { background-color: #f8d7da; border-color: #f5c6cb; }
    .alert-success { background-color: #d4edda; border-color: #c3e6cb; }
    .input-group-text { background-color: #f8f9fa; border-color: #dfe6e9; }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
      <div class="verify-card">
        <div class="text-center mb-4">
          <h1 class="h3">
            <i class="fas fa-keyboard text-indigo-600"></i> KeyCraft
          </h1>
          <p class="text-gray-500">Xác minh mã đặt lại mật khẩu</p>
        </div>

        <!-- Success Messages -->
        <c:if test="${success != null}">
          <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
        </c:if>

        <!-- Error Messages -->
        <c:if test="${error != null}">
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
        </c:if>

        <!-- Verify Reset Code Form -->
        <form action="/auth/verify-reset-code" method="post">
          <div class="mb-3">
            <label for="email" class="form-label">Địa chỉ Email</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-envelope"></i></span>
              <input type="email" class="form-control" id="email" name="email" value="${email}" readonly>
            </div>
          </div>
          <div class="mb-3">
            <label for="code" class="form-label">Mã xác minh</label>
            <div class="input-group">
              <span class="input-group-text"><i class="fas fa-key"></i></span>
              <input type="text" class="form-control" id="code" name="code" required pattern="[0-9]{6}" placeholder="Nhập mã 6 chữ số">
            </div>
          </div>
          <button type="submit" class="btn btn-primary w-100 mb-3">
            <i class="fas fa-check"></i> Xác minh
          </button>
        </form>

        <div class="text-center">
          <p class="mb-0">Chưa nhận được mã? <a href="/auth/forgot-password" class="text-indigo-600 text-decoration-none">Gửi lại mã</a></p>
          <p class="mt-2"><a href="/login" class="text-gray-500 text-decoration-none">← Quay lại đăng nhập</a></p>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="/webjars/jquery/3.7.0/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>