<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin người dùng - KeyCraft</title>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="/webjars/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .profile-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-top: 2rem;
        }
        .form-label { color: #2c3e50; }
        .form-control { border-color: #dfe6e9; }
        .form-control:focus { border-color: #4a90e2; box-shadow: 0 0 5px rgba(74, 144, 226, 0.5); }
        .btn-primary { background-color: #4a90e2; border-color: #4a90e2; }
        .btn-primary:hover { background-color: #357abd; border-color: #357abd; }
        .alert-success { background-color: #d4edda; border-color: #c3e6cb; }
        .alert-danger { background-color: #f8d7da; border-color: #f5c6cb; }
        .profile-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #4a90e2;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="profile-card">
                <div class="text-center mb-4">
                    <h1 class="h3">Thông tin người dùng</h1>
                    <c:if test="${not empty user.profileImageUrl}">
                        <img src="${user.profileImageUrl}" alt="Profile Image" class="profile-img mb-3">
                    </c:if>
                    <c:if test="${empty user.profileImageUrl}">
                        <i class="fas fa-user-circle fa-5x text-muted mb-3"></i>
                    </c:if>
                </div>

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

                <form action="/profile" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" value="${user.email}" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="firstName" class="form-label">Họ</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="${user.firstName}">
                    </div>
                    <div class="mb-3">
                        <label for="lastName" class="form-label">Tên</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="${user.lastName}">
                    </div>
                    <div class="mb-3">
                        <label for="role" class="form-label">Vai trò</label>
                        <input type="text" class="form-control" id="role" value="${user.roleString}" disabled>
                    </div>
                    <div class="mb-3">
                        <label for="profileImage" class="form-label">Ảnh đại diện</label>
                        <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-save"></i> Cập nhật thông tin
                    </button>
                </form>

                <div class="text-center mt-3">
                    <a href="/auth/logout" class="text-danger text-decoration-none">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/webjars/jquery/3.7.0/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>