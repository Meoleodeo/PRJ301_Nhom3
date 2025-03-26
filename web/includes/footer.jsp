<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BlackShope</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style-footer.css"/>
</head>
<body>
    <!-- Footer -->
    <footer class="bg-dark text-white p-4">
        <div class="container">
            <div class="row align-items-start">
                <!-- Cột 1: Thông tin công ty -->
                <div class="col-md-3 mb-3">
                    <h6 class="mb-2">BlackShope</h6>
                    <p class="small mb-1">Mua sắm dễ dàng, bán hàng tiện lợi.</p>
                    <p class="small mb-0">© 2024 BlackShope. All Rights Reserved.</p>
                </div>

<<<<<<< HEAD
                <!-- Cột 2: Liên kết hữu ích -->
                <div class="col-md-3 mb-3">
                    <h6 class="mb-2">Liên kết hữu ích</h6>
                    <ul class="list-unstyled small">
                        <li><a href="index.jsp" class="text-white text-decoration-none">Trang chủ</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Sản phẩm</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Chính sách bảo mật</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Hỗ trợ khách hàng</a></li>
                    </ul>
                </div>

                <!-- Cột 3: Liên hệ -->
                <div class="col-md-3 mb-3">
                    <h6 class="mb-2">Liên hệ</h6>
                    <p class="small mb-1">Email: support@blackshope.com</p>
                    <p class="small mb-1">Hotline: 1800 1010</p>
                    <p class="small mb-0">Đại học FPT Campus Đà Nẵng</p>
                </div>

                <!-- Cột 4: Mạng xã hội -->
                <div class="col-md-3 mb-3">
                    <h6 class="mb-2">Theo dõi chúng tôi</h6>
                    <div class="social-links small">
                        <a href="#" class="text-white text-decoration-none d-block mb-1">
                            <img src="assets/image/icons/facebook.jpg" alt="Facebook" class="social-icon me-2">Facebook
                        </a>
                        <a href="#" class="text-white text-decoration-none d-block mb-1">
                            <img src="assets/image/icons/insta.jpg" alt="Instagram" class="social-icon me-2">Instagram
                        </a>
                        <a href="#" class="text-white text-decoration-none d-block">
                            <img src="assets/image/icons/tik-tok.jpg" alt="Tiktok" class="social-icon me-2">Tiktok
                        </a>
                    </div>
=======
<footer>
    <div class="footer-top">
        <div class="container">
            <div class="row">
                <!-- Cột 1: Thông tin công ty -->
                <div class="col">
                    <h6>BlackShope</h6>
                    <p>Mua sắm dễ dàng, bán hàng tiện lợi.</p>
                    <p>© 2025 BlackShope. All Rights Reserved.</p>
                </div>
                <!-- Cột 3: Liên hệ -->
                <div class="col">
                    <h6>Liên hệ</h6>
                    <p>Email: support@blackshope.com</p>
                    <p>Hotline: 1800 1010</p>
                    <p>Đại học FPT Campus Đà Nẵng</p>
                </div>

                <!-- Cột 4: Mạng xã hội -->
                <div class="col social">
                    <h6>Theo dõi chúng tôi</h6>
                    <a href="https://www.facebook.com/"><i class="ti-facebook"></i> Facebook</a>
                    <a href="https://www.instagram.com/"><i class="ti-instagram"></i> Instagram</a>
                    <a href="https://x.com/?lang=en"><i class="ti-twitter"></i> Twitter</a>
>>>>>>> e0dcd666a20638fab7fed2574348049ffb8f9714
                </div>
            </div>

            <!-- Đường phân cách và bản quyền -->
            <hr class="bg-white my-3">
            <div class="text-center">
                <p class="small mb-0">Designed with <span style="color: #e25555;">♥</span> by BlackShope Team</p>
            </div>
        </div>
<<<<<<< HEAD
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>
=======
    </div>

    <!-- Phần bản quyền ở dưới cùng -->
    <div class="footer-bottom">
        <div class="container text-center">
            <p>Designed with <span>♥</span> by BlackShope Team</p>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.17.2/dist/sweetalert2.all.min.js"></script>
<script>
    // Hàm lấy URL parameters
    function getUrlParameter(name) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(name);
    }

    // Lấy giá trị từ URL
    const success = getUrlParameter("success");
    const error = getUrlParameter("error");

    // Hiển thị SweetAlert tùy theo kết quả
    if (success === "true") {
        Swal.fire({
            title: "Thanh toán thành công",
            icon: "success",
            draggable: true // Thực ra SweetAlert2 không hỗ trợ 'draggable', nên dòng này có thể bỏ nếu không dùng plugin ngoài.
        });
    }

    if (error === "insufficient_balance") {
        Swal.fire({
            icon: "error",
            title: "Oops...",
            text: "Bạn không đủ số dư"
        });
    }
</script>
<script>
    let prevScrollpos = window.pageYOffset;
    window.onscroll = function () {
        let currentScrollPos = window.pageYOffset;
        if (prevScrollpos > currentScrollPos) {
            document.querySelector(".navbar-custom").classList.remove("hidden-navbar");
        } else {
            document.querySelector(".navbar-custom").classList.add("hidden-navbar");
        }
        prevScrollpos = currentScrollPos;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
>>>>>>> e0dcd666a20638fab7fed2574348049ffb8f9714
