<template>
    <div>
        <div class="contact-container">
            <BreadcrumbComponent
                class="breadcrumb-container"
                :breadcrumb-list="breadcrumbs"
            />
            <section class="contact-content">
                <div class="contact-content__left">
                    <div class="content-left__header">
                        <div class="header-title">
                            <span class="icon-box">
                                <IconPhone />
                            </span>
                            <h2>Gọi đến chúng tôi</h2>
                        </div>
                        <p>Chúng tôi hoạt động 24/7, 7 ngày một tuần.</p>
                        <p>Điện thoại: +8801611112222</p>
                    </div>
                    <div class="content-left__footer">
                        <div class="header-title">
                            <span class="icon-box">
                                <IconBoxMessage />
                            </span>
                            <h2>Gửi tin nhắn cho chúng tôi</h2>
                        </div>
                        <p>
                            Điền vào biểu mẫu của chúng tôi và chúng tôi sẽ liên hệ với bạn trong 24
                            giờ.
                        </p>
                        <p>Emails: info@vku.udn.vn</p>
                        <p>Emails: contact@vku.udn.vn</p>
                    </div>
                </div>
                <div class="contact-content__right">
                    <form class="contact-form">
                        <div class="group-form__input">
                            <div class="input-field__item">
                                <label for="name">
                                    <span class="name-label">Họ tên</span>
                                    <span class="required">*</span>
                                </label>
                                <input
                                    id="name"
                                    type="text"
                                    class="input-field"
                                >
                            </div>
                            <div class="input-field__item">
                                <label for="email">
                                    <span class="email-label">Email</span>
                                    <span class="required">*</span>
                                </label>
                                <input
                                    id="email"
                                    type="email"
                                    class="input-field"
                                >
                            </div>
                            <div class="input-field__item">
                                <label for="phone">
                                    <span class="phone-label">Số điện thoại</span>
                                    <span class="required">*</span>
                                </label>
                                <input
                                    id="phone"
                                    type="text"
                                    class="input-field"
                                >
                            </div>
                        </div>
                        <div class="input-area">
                            <textarea
                                type="textarea"
                                placeholder="Tin nhắn"
                                class="input-field"
                            />
                        </div>
                        <div class="group-form__button">
                            <div>
                                <button class="btn-submit">
                                    Gửi tin nhắn
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
        </div>
    </div>
</template>

<script setup>
import IconBoxMessage from '@/components/icons/IconBoxMessage.vue';
import IconPhone from '@/components/icons/IconPhone.vue';
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';

const breadcrumbs = [
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Liên hệ',
        path: '/contact'
    }
];
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/contact_view.scss';
</style>
