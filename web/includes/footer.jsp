<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
                </div>
            </div>
        </div>
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