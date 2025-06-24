<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin người dùng - KeyCraft</title>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .profile-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            margin-top: 2rem;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        .profile-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #4a90e2;
            display: block;
            margin: 0 auto 1rem;
        }
        .form-label { color: #2c3e50; }
        .form-control { border-color: #dfe6e9; }
        .form-control:focus { border-color: #4a90e2; box-shadow: 0 0 5px rgba(74, 144, 226, 0.5); }
        .btn-primary { background-color: #4a90e2; border-color: #4a90e2; }
        .btn-primary:hover { background-color: #357abd; border-color: #357abd; }
        .btn-secondary { background-color: #357abd; border-color: #6c757d; }
        .btn-secondary:hover { background-color: #357abd; border-color: #5a6268; }
        .alert-success { background-color: #d4edda; border-color: #c3e6cb; }
        .alert-danger { background-color: #f8d7da; border-color: #f5c6cb; }

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
<%--                    <c:if test="${not empty user.profileImageUrl}">--%>
<%--                        <img src="${user.profileImageUrl}" alt="Profile Image" class="profile-img mb-3">--%>
<%--                    </c:if>--%>
<%--                    <c:if test="${empty user.profileImageUrl}">--%>
<%--                        <i class="fas fa-user-circle fa-5x text-muted mb-3"></i>--%>
<%--                    </c:if>--%>
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
<%--                    <div class="mb-3">--%>
<%--                        <label for="profileImage" class="form-label">Ảnh đại diện</label>--%>
<%--                        <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">--%>
<%--                    </div>--%>
                    <button type="submit" class="btn btn-primary w-100 mb-2">
                        <i class="fas fa-save"></i> Cập nhật thông tin
                    </button>
                </form>

                <div class="d-flex justify-content-between mb-3">
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                        <i class="fas fa-lock"></i> Đổi mật khẩu
                    </button>
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-secondary">
                        <i class="fas fa-history"></i> Lịch sử mua hàng
                    </a>
                </div>

                <div class="text-center mb-4">
                    <a href="/auth/logout" class="btn btn-secondary">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Change Password Modal -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">Đổi mật khẩu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="changePasswordForm" action="/profile/change-password" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="currentPassword" class="form-label">Mật khẩu hiện tại</label>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">Mật khẩu mới</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div id="passwordError" class="text-danger d-none"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="/webjars/jquery/3.7.0/jquery.min.js"></script>
<script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function() {
        $('#changePasswordForm').on('submit', function(e) {
            const newPassword = $('#newPassword').val();
            const confirmPassword = $('#confirmPassword').val();
            const errorDiv = $('#passwordError');

            if (newPassword !== confirmPassword) {
                e.preventDefault();
                errorDiv.text('Mật khẩu mới và xác nhận mật khẩu không khớp.');
                errorDiv.removeClass('d-none');
            } else if (newPassword.length < 6) {
                e.preventDefault();
                errorDiv.text('Mật khẩu mới phải có ít nhất 6 ký tự.');
                errorDiv.removeClass('d-none');
            } else {
                errorDiv.addClass('d-none');
            }
        });
    });
</script>
</body>
</html>
