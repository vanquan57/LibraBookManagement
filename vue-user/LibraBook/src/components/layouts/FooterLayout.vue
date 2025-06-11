<template>
    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-section">
                <h3 class="footer-logo">
                    VKU - Libra
                </h3>
                <h4 class="footer-subtitle">
                    Đăng Ký Nhận Thông Tin
                </h4>
                <p class="footer-text">
                    Nhận ngay giảm giá 10% cho đơn hàng đầu tiên
                </p>
                <form class="footer-form">
                    <input
                        id="footer-email"
                        type="email"
                        placeholder="Nhập email của bạn"
                        class="footer-input"
                    >
                    <button
                        type="submit"
                        class="footer-submit"
                        aria-label="Submit email"
                    >
                        <IconSend />
                    </button>
                </form>
            </div>
            <div class="footer-section">
                <h4 class="footer-title">
                    Hỗ Trợ
                </h4>
                <address class="footer-address">
                    470 Trần Đại Nghĩa, Q. Ngũ Hành Sơn, Tp. Đà Nẵng
                </address>
                <a
                    href="#"
                    class="footer-link"
                >info@vku.udn.vn</a>
                <a
                    href="#"
                    class="footer-link"
                >0236.3.667.117</a>
            </div>
            <div class="footer-section">
                <h4 class="footer-title">
                    Tài Khoản
                </h4>
                <nav class="footer-nav">
                    <ul>
                        <li>
                            <router-link
                                to="/account"
                                class="footer-link"
                            >
                                Tài Khoản Của Tôi
                            </router-link>
                        </li>
                        <li>
                            <router-link
                                to="/auth/login"
                                class="footer-link"
                            >
                                Đăng Nhập / Đăng Ký
                            </router-link>
                        </li>
                        <li>
                            <router-link
                                to="/cart"
                                class="footer-link"
                            >
                                Giỏ Hàng
                            </router-link>
                        </li>
                        <li>
                            <router-link
                                to="/wishlist"
                                class="footer-link"
                            >
                                Danh Sách Yêu Thích
                            </router-link>
                        </li>
                        <li>
                            <router-link
                                to="/"
                                class="footer-link"
                            >
                                Cửa Hàng
                            </router-link>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="footer-section">
                <h4 class="footer-title">
                    Liên Kết Nhanh
                </h4>
                <nav class="footer-nav">
                    <ul>
                        <li>
                            <a
                                href="#"
                                class="footer-link"
                            >Chính Sách Bảo Mật</a> 
                        </li>
                        <li>
                            <a
                                href="#"
                                class="footer-link"
                            >Điều Khoản Sử Dụng</a>
                        </li>
                        <li>
                            <a
                                href="#"
                                class="footer-link"
                            >Câu Hỏi Thường Gặp (FAQ)</a>
                        </li>
                        <li>
                            <router-link
                                to="/contact"
                                class="footer-link"
                            >
                                Liên Hệ
                            </router-link>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="footer-section">
                <h4 class="footer-title">
                    Tải Ứng Dụng
                </h4>
                <p class="app-promo">
                    Tiết kiệm 3 USD dành riêng cho người dùng mới trên ứng dụng
                </p>
                <div class="app-download">
                    <img
                        :src="images.qrCode"
                        alt="Mã QR để tải ứng dụng"
                        class="qr-code"
                    >
                    <div class="app-stores">
                        <img
                            :src="images.appStore"
                            alt="Tải trên App Store"
                            class="app-store-badge"
                        >
                        <img
                            :src="images.googlePlay"
                            alt="Tải trên Google Play"
                            class="play-store-badge"
                        >
                    </div>
                </div>
                <div class="social-links">
                    <a
                        href="#"
                        aria-label="Facebook"
                    ><IconFacebook /></a>
                    <a
                        href="#"
                        aria-label="Twitter"
                    >
                        <IconTwitter />
                    </a>
                    <a
                        href="#"
                        aria-label="Instagram"
                    >
                        <IconInstagram />
                    </a>
                    <a
                        href="#"
                        aria-label="LinkedIn"
                    ><IconLinkedin /> </a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p class="copyright">
                BẢN QUYỀN © 2025 VKU CO., LTD. MỌI QUYỀN ĐƯỢC BẢO LƯU.
            </p>
        </div>
    </footer>
</template>

<script setup>
import images from '@/assets/images';
import IconFacebook from '@/components/icons/IconFacebook.vue';
import IconInstagram from '@/components/icons/IconInstagram.vue';
import IconLinkedin from '@/components/icons/IconLinkedin.vue';
import IconTwitter from '@/components/icons/IconTwitter.vue';
import IconSend from '@/components/icons/IconSend.vue';
</script>

<style lang="scss" scoped>
@import '@/assets/scss/layouts/footer_layout.scss';
</style>
