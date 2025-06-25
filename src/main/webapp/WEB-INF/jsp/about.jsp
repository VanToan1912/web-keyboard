<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Về Kibo - Đam Mê Bàn Phím Cơ</title>
    <link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('https://source.unsplash.com/1600x900/?mechanical-keyboard,desk') no-repeat center center;
            background-size: cover;
        }
        .icon-box {
            font-size: 3rem;
            color: #0d6efd;
        }
        /* Style cho tiêu đề các mục */
        .section-title {
            font-weight: 300; /* Chữ mảnh hơn một chút */
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
            display: inline-block; /* Giúp border chỉ dài bằng độ dài chữ */
            margin-bottom: 2rem;
        }
        /* Style cho các đoạn văn bản để dễ đọc hơn */
        .story-text p {
            line-height: 1.8; /* Tăng khoảng cách dòng */
            text-align: justify; /* Căn đều hai bên cho đẹp */
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<section class="hero-section text-white text-center py-5">
    <div class="container">
        <h1 class="display-4 fw-bold">Về Kibo</h1>
        <p class="lead">Nơi Đam Mê Bàn Phím Cơ Thăng Hoa</p>
    </div>
</section>

<div class="container my-5">
    <section class="our-story mb-5 pb-5">
        <div class="row align-items-center">
            <div class="col-md-6 pe-lg-5 story-text">
                <h2 class="section-title">Câu Chuyện Của Kibo</h2>
                <p class="text-muted">Kibo được thành lập vào năm [Năm thành lập, ví dụ: 2022] bởi một nhóm những người có chung một tình yêu mãnh liệt với bàn phím cơ. Chúng tôi bắt đầu từ một góc nhỏ trên mạng xã hội, nơi mọi người cùng nhau chia sẻ kinh nghiệm, khoe những bộ phím mới và giúp đỡ nhau mod phím. </p>
                <p class="text-muted">Nhận thấy nhu cầu về một nơi cung cấp các sản phẩm chất lượng, đáng tin cậy và một không gian để cộng đồng phát triển, Kibo đã ra đời. Chúng tôi không chỉ là một cửa hàng, mà còn là một điểm đến cho bất kỳ ai muốn khám phá thế giới đầy màu sắc của bàn phím cơ tùy biến.</p>
            </div>
            <div class="col-md-6">
                <img src="https://source.unsplash.com/800x600/?keyboard,setup,desk" class="img-fluid rounded shadow-lg" alt="Góc làm việc với bàn phím cơ">
            </div>
        </div>
    </section>

    <section class="core-values text-center mb-5 pb-5">
        <h2 class="section-title">Giá Trị Cốt Lõi</h2>
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="icon-box mb-3">
                    <i class="fas fa-gem"></i>
                </div>
                <h5 class="fw-bold">Chất Lượng Hàng Đầu</h5>
                <p class="text-muted">Mỗi sản phẩm từ switch, keycap cho đến phụ kiện tại Kibo đều được chúng tôi lựa chọn và kiểm tra kỹ lưỡng, đảm bảo mang đến cho bạn trải nghiệm gõ phím tốt nhất.</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="icon-box mb-3">
                    <i class="fas fa-users"></i>
                </div>
                <h5 class="fw-bold">Xây Dựng Cộng Đồng</h5>
                <p class="text-muted">Chúng tôi tin rằng đam mê sẽ lớn mạnh hơn khi được chia sẻ. Kibo luôn nỗ lực tổ chức các buổi workshop, сходки và tạo sân chơi để mọi người kết nối.</p>
            </div>
            <div class="col-md-4 mb-4">
                <div class="icon-box mb-3">
                    <i class="fas fa-hand-sparkles"></i>
                </div>
                <h5 class="fw-bold">Sáng Tạo Không Giới Hạn</h5>
                <p class="text-muted">Kibo khuyến khích sự sáng tạo và cá nhân hóa. Chúng tôi luôn sẵn sàng tư vấn và hỗ trợ bạn tự tay xây dựng nên một chiếc bàn phím độc nhất mang đậm dấu ấn cá nhân.</p>
            </div>
        </div>
    </section>

    <section class="closing text-center">
        <h2 class="section-title">Hãy Đồng Hành Cùng Kibo</h2>
        <p class="lead text-muted">Dù bạn là người mới bắt đầu hay một người chơi lâu năm, hãy đến với Kibo để cùng chúng tôi lan tỏa và phát triển niềm đam mê này.</p>
        <a href="/products" class="btn btn-primary btn-lg mt-3">Khám phá sản phẩm</a>
    </section>
</div>

<%@ include file="footer.jsp" %>

<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>