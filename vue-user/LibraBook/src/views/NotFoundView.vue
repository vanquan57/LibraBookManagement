<template>
    <div class="not-found-container">
        <BreadcrumbComponent
            class="bread-crumb"
            :breadcrumbList="breadcrumbs"
        />
        <div class="not-found-content">
            <h1>404 Không tồn tại</h1>
            <p>Trang bạn đang tìm kiếm không tồn tại. Bạn có thể trở về trang chủ.</p>
            <router-link to="/"> Trở về trang chủ </router-link>
        </div>
    </div>
</template>


<script setup>
import BreadcrumbComponent from "@/components/Breadcrumb/BreadcrumbComponent.vue";

const breadcrumbs = [
    {
        name: "Trang chủ",
        path: "/",
    },

    {
        name: "404 Không tồn tại",
        path: "/404",
    },

];
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/not_found_view.scss';
</style>
