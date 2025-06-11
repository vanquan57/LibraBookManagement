<template>
    <div class="about-container">
        <BreadcrumbComponent
            class="breadcrumb-container"
            :breadcrumb-list="breadcrumbs"
        />
        <section class="about-our_story">
            <div class="about-text">
                <h1>Câu chuyện của chúng tôi</h1>
                <p>
                    Với phương châm lấy người học làm trung tâm, VKU theo đuổi triết lý giáo dục "Nhân bản - Phụng sự - Khai phóng" nhằm đào tạo và phát triển người học trở thành những con người toàn diện, thiện lương, đạo đức với tư duy năng động, đổi mới, sáng tạo cùng tinh thần luôn sẵn sàng phụng sự, dấn thân vì hạnh phúc và sự phát triển của đất nước, nhân loại dựa trên hệ thống giá trị cốt lõi: Đức - Trí - Thể - Mỹ; Uy tín - Chất lượng - Chuyên nghiệp; Kế thừa - Đổi mới - Sáng tạo.
                </p>
                <p>
                    VKU đã đạt được những thành tựu nghiên cứu ấn tượng, tạo môi trường nghiên cứu tốt và thu hút giảng viên, sinh viên tài năng. Những công trình nghiên cứu của trường có tầm ảnh hưởng rộng lớn trong cộng đồng khoa học, mang lại niềm vui, động lực cho các nhà nghiên cứu và đóng góp quan trọng vào sự phát triển của ngành khoa học.
                </p>
            </div>
            <div class="about-image">
                <img
                    :src="images.sideImageAbout"
                    alt=""
                >
            </div>
        </section>
        <div class="about-general">
            <div class="card-group-general">
                <StatsOverviewComponent
                    v-for="cardGeneral in cardGenerals"
                    :key="cardGeneral.value"
                    :value="cardGeneral.value"
                    :content="cardGeneral.content"
                    :icon="cardGeneral.icon"
                />
            </div>
        </div>
        <div class="about-service">
            <div class="card-group-service">
                <StatsOverviewComponent
                    v-for="fullService in fullServices"
                    :key="fullService.value"
                    :value="fullService.value"
                    :content="fullService.content"
                    :icon="fullService.icon"
                    :full-service="true"
                    :has-border="false"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
import images from '@/assets/images';
import IconCustomerService from '@/components/icons/IconCustomerService.vue';
import IconDelivery from '@/components/icons/IconDelivery.vue';
import IconMoneyBag from '@/components/icons/IconMoneyBag.vue';
import IconSale from '@/components/icons/IconSale.vue';
import IconSecure from '@/components/icons/IconSecure.vue';
import IconShop from '@/components/icons/IconShop.vue';
import IconShoppingBag from '@/components/icons/IconShoppingBag.vue';
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import StatsOverviewComponent from '@/components/StatsOverviewComponent.vue';
import { markRaw } from 'vue';
import { reactive } from 'vue';

const breadcrumbs = [
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Về chúng tôi',
        path: '/about'
    }
];

const cardGenerals = reactive([
    {
        icon: markRaw(IconMoneyBag),
        value: '12.5k',
        content: 'Số lượng người dùng đăng ký'
    },
    {
        icon: markRaw(IconSale),
        value: '13.5k',
        content: 'Số lượng đơn hàng được đặt'
    },
    {
        icon: markRaw(IconShop),
        value: '14.5k',
        content: 'Số lượng sách trong thư viện'
    },
    {
        icon: markRaw(IconShoppingBag),
        value: '15.5k',
        content: 'Số lượng sách yêu thích'
    }
]);

const fullServices = reactive([
    {
        icon: markRaw(IconDelivery),
        value: 'SÁCH',
        content: 'Số lượng sách có sẵn'
    },
    {
        icon: markRaw(IconCustomerService),
        value: 'THỜI GIAN',
        content: 'Thứ 2 - Thứ 7, 9 AM - 6 PM'
    },
    {
        icon: markRaw(IconSecure),
        value: 'SÁCH MỚI',
        content: 'Sách mới cập nhật'
    }
]);
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/about_view.scss';
</style>
