<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="/webjars/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #4a90e2 0%, #6b48cc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .signup-card {
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
            <div class="signup-card">
                <div class="text-center mb-4">
                    <h1 class="h3">
                        <i class="fas fa-keyboard text-indigo-600"></i> Kibo Store
                    </h1>
                    <p class="text-gray-500">Tạo tài khoản của bạn</p>
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

                <!-- Signup Form -->
                <form action="/auth/signup" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName" class="form-label">Tên</label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName" class="form-label">Họ</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Địa chỉ Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>

<%--                    <div class="mb-3">--%>
<%--                        <label for="role" class="form-label">Loại tài khoản</label>--%>
<%--                        <select class="form-select" id="role" name="role">--%>
<%--                            <option value="CUSTOMER">Khách hàng</option>--%>
<%--                            <option value="ADMIN">Quản trị viên</option>--%>
<%--                        </select>--%>
<%--                    </div>--%>

                    <button type="submit" class="btn btn-primary w-100 mb-3">
                        <i class="fas fa-user-plus"></i> Tạo tài khoản
                    </button>
                </form>

                <div class="text-center">
                    <p class="mb-0">Đã có tài khoản? <a href="/login" class="text-indigo-600 text-decoration-none">Đăng nhập tại đây</a></p>
<%--                    <p class="mt-2"><a href="/" class="text-gray-500 text-decoration-none">← Quay lại trang chủ</a></p>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/webjars/jquery/3.7.0/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
