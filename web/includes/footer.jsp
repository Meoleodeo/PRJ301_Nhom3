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

                <!-- Cột 2: Liên kết hữu ích -->
                <div class="col">
                    <h6>Liên kết hữu ích</h6>
                    <ul>
                        <li><a href="index.jsp">Trang chủ</a></li>
                        <li><a href="#">Sản phẩm</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Hỗ trợ khách hàng</a></li>
                    </ul>
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
<script>
    let prevScrollpos = window.pageYOffset;
    window.onscroll = function() {
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