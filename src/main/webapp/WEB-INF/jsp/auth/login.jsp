<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4a90e2 0%, #6b48cc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(74, 144, 226, 0.3);
            padding: 2rem;
        }
        .form-label {
            color: #2c3e50;
        }
        .form-control {
            border-color: #dfe6e9;
            background-color: #f8f9fa;
        }
        .form-control:focus {
            border-color: #4a90e2;
            box-shadow: 0 0 5px rgba(74, 144, 226, 0.5);
        }
        .btn-primary {
            background-color: #4a90e2;
            border-color: #4a90e2;
        }
        .btn-primary:hover {
            background-color: #357abd;
            border-color: #357abd;
        }
        .text-indigo-600 {
            color: #4a90e2;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .alert-info {
            background-color: #cce5ff;
            border-color: #b8daff;
            color: #004085;
        }
        .input-group-text {
            background-color: #f8f9fa;
            border-color: #dfe6e9;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
            <div class="login-card">
                <div class="text-center mb-4">
                    <h1 class="h3">
                        <i class="fas fa-keyboard text-indigo-600"></i> Kibo Store
                    </h1>
                    <p class="text-gray-500">Đăng nhập vào tài khoản của bạn</p>
                </div>

                <!-- Error Messages -->
                <c:if test="${success != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Login Form -->
                <form action="/auth/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Địa chỉ Email</label>
                        <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-envelope"></i>
                                </span>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-lock"></i>
                                </span>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 mb-3">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </button>
                </form>

                <!-- Test Accounts Info -->
<%--                <div class="alert alert-info">--%>
<%--                    <strong>Tài khoản thử nghiệm:</strong><br>--%>
<%--                    <small>--%>
<%--                        Quản trị viên: admin@keycraft.com / admin123<br>--%>
<%--                        Khách hàng: customer@keycraft.com / customer123--%>
<%--                    </small>--%>
<%--                </div>--%>

                <div class="text-center">
                    <p class="mb-0">Chưa có tài khoản? <a href="/signup" class="text-indigo-600 text-decoration-none">Đăng ký tại đây</a></p>
                    <p class="mb-0"><a href="/auth/forgot-password" class="text-indigo-600 text-decoration-none">Quên mật khẩu?</a></p>
                    <p class="mt-2"><a href="/" class="text-gray-500 text-decoration-none">← Quay lại trang chủ</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
