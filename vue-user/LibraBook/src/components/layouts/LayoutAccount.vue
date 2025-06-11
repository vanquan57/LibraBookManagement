<template>
    <div class="account-container">
        <div class="account-container__header">
            <BreadcrumbComponent
                class="breadcrumb-container"
                :breadcrumb-list="breadcrumbs"
            />
            <span class="welcome-text">Chào mừng <strong>{{ user?.name }}</strong></span>
        </div>
        <div class="account-container__content">
            <div class="account-container__left">
                <div class="account-container__left-sidebar desktop-sidebar">
                    <ul class="account-container__left-sidebar__list">
                        <li
                            v-for="(item, index) in menuItems"
                            :key="index"
                            class="account-container__left-sidebar__list__item"
                        >
                            <span class="account-container__left-sidebar__list__item__title">
                                {{ item.title }}
                            </span>
                            <ul class="account-container__left-sidebar__list__item__list">
                                <li
                                    v-for="(subItem, subIndex) in item.children"
                                    :key="subIndex"
                                    class="account-container__left-sidebar__list__item__list__item"
                                >
                                    <router-link :to="subItem.link">
                                        {{ subItem.name }}
                                    </router-link>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="account-container__left-sidebar mobile-sidebar">
                    <ul class="account-container__left-sidebar__list">
                        <li
                            v-for="(item, index) in menuItems"
                            :key="index"
                            class="account-container__left-sidebar__list__item"
                            @mouseover="activeIndex = index"
                            @mouseleave="activeIndex = null"
                        >
                            <span class="account-container__left-sidebar__list__item__title">
                                {{ item.title }}
                            </span>
                            <ul
                                v-if="activeIndex === index"
                                class="account-container__left-sidebar__list__item__list"
                            >
                                <li
                                    v-for="(subItem, subIndex) in item.children"
                                    :key="subIndex"
                                    class="account-container__left-sidebar__list__item__list__item"
                                >
                                    <router-link :to="subItem.link">
                                        {{ subItem.name }}
                                    </router-link>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="account-container__right">
                <RouterView />
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import axiosInstance from '@/config/axios';
import { onMounted, ref, watchEffect } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const breadcrumbs = ref([
    { name: 'Trang chủ', path: '/' },
    { name: 'Tài khoản của tôi', path: '/my-account' }
]);
const user = ref(null);
onMounted(() => {
    getUser();
});
watchEffect(() => {
    if (route.fullPath === '/my-account') {
        breadcrumbs.value = [
            { name: 'Trang chủ', path: '/' },
            { name: 'Tài khoản của tôi', path: '/my-account' }
        ];
    }
    if (route.fullPath === '/my-account/orders') {
        breadcrumbs.value = [
            { name: 'Trang chủ', path: '/' },
            { name: 'Tài khoản của tôi', path: '/my-account' },
            { name: 'Đơn mượn của tôi', path: '/my-account/orders' }
        ];
    }
    if (route.fullPath === '/my-account/change-password') {
        breadcrumbs.value = [
            { name: 'Trang chủ', path: '/' },
            { name: 'Tài khoản của tôi', path: '/my-account' },
            { name: 'Thay đổi mật khẩu', path: '/my-account/change-password' }
        ];
    }
});
const getUser = async () => {
    try {
        const response = await axiosInstance.get('/profile');
        user.value = response.data;
    } catch (error) {
    }
};

const activeIndex = ref(null);

const toggleDropdown = (index) => {
  activeIndex.value = activeIndex.value === index ? null : index;
};

const menuItems = ref([
  {
    title: "Quản lý tài khoản",
    children: [
      { name: "Tài khoản của tôi", link: "/my-account" },
      { name: "Thay đổi mật khẩu", link: "/my-account/change-password" }
    ]
  },
  {
    title: "Quản lý đơn mượn",
    children: [{ name: "Đơn mượn của tôi", link: "/my-account/orders" }]
  },
  {
    title: "Danh sách yêu thích",
    children: [{ name: "Sách yêu thích", link: "/wishlist" }]
  }
]);
</script>

<style lang="scss" scoped>
@import '@/assets/scss/layouts/layout_account.scss';
</style>

