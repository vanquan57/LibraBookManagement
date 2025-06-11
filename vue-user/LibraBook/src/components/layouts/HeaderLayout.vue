<template>
    <header>
        <section class="top-header">
            <div class="top-header__container">
                <div class="sale-banner">
                    <p class="sale-banner__text">
                        VKU - Trao tri thức, nhận thành công: Mượn Sách Miễn Phí, đọc sách hôm nay, thành công mai sau.
                        <span class="promo-link">Mượn ngay tại</span>
                    </p>
                </div>
                <div class="language">
                    <select id="choose_language">
                        <option value="en">
                            English
                        </option>
                        <option value="es">
                            Viet Nam
                        </option>
                        <option value="fr">
                            Japanese
                        </option>
                    </select>
                </div>
            </div>
        </section>
        <nav class="nav-bar">
            <div class="logo">
                <router-link to="/">
                    VKU-Libra
                </router-link>
            </div>
            <div class="menu">
                <ul>
                    <li>
                        <router-link to="/">
                            Trang Chủ
                        </router-link>
                    </li>
                    <li>
                        <router-link to="/contact">
                            Liên Hệ
                        </router-link>
                    </li>
                    <li>
                        <router-link to="/about">
                            Giới Thiệu
                        </router-link>
                    </li>
                    <li>
                        <router-link to="/auth/register">
                            Đăng Ký
                        </router-link>
                    </li>
                </ul>
            </div>
            <div class="search">
                <form @submit.prevent="handleSearch">
                    <div class="search-group">
                        <input
                            type="text"
                            v-model="searchQuery"
                            placeholder="Tìm kiếm sách"
                        >
                        <button type="submit">
                            <IconSearch />
                        </button>
                    </div>
                </form>
                <div
                    v-if="isShowGroupAction"
                    class="actions"
                >
                    <div class="action-item">
                        <router-link to="/wishlist">
                            <IconHeart />
                        </router-link>
                        <span
                            v-if="counterCartAndWishList.wishList > 0"
                            class="action-item__counter"
                        >
                            {{ counterCartAndWishList.wishList }}
                        </span>
                    </div>

                    <div class="action-item">
                        <router-link to="/cart">
                            <IconCart />
                        </router-link>
                        <span
                            v-if="counterCartAndWishList.cart > 0"
                            class="action-item__counter"
                        >
                            {{ counterCartAndWishList.cart }}
                        </span>
                    </div>


                    <div class="action-item">
                        <span
                            class="action-item__user"
                            :class="{ active: isShowAction }"
                            @click="isShowAction = !isShowAction"
                        >
                            <IconUser
                                :color-stroke="isShowAction ? 'white' : 'black'"
                            />
                        </span>
                        <div
                            v-if="isShowAction"
                            class="user-menu-dropdown"
                        >
                            <ul class="user-menu">
                                <li class="user-menu__item">
                                    <IconUser
                                        class="icon"
                                        :color-stroke="'white'"
                                    />
                                    <router-link
                                        to="/my-account"
                                        @click="isShowAction = false"
                                    >
                                        Tài Khoản Của Tôi
                                    </router-link>
                                </li>

                                <li class="user-menu__item">
                                    <IconMyOrder class="icon" />
                                    <router-link 
                                        to="/my-account/orders"
                                        @click="isShowAction = false"
                                    >
                                        Đơn Hàng Của Tôi
                                    </router-link>
                                </li>
                                <li class="user-menu__item">
                                    <IconHeart
                                        class="icon"
                                        :color-stroke="'white'"
                                    />
                                    <router-link
                                        to="/wishlist"
                                        @click="isShowAction = false"
                                    >
                                        Danh Sách Yêu Thích
                                    </router-link>
                                </li>

                                <li class="user-menu__item">
                                    <IconLogout />
                                    <button @click="logout">
                                        Đăng Xuất
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </header>
</template>

<script setup>
import IconSearch from '@/components/icons/IconSearch.vue';
import IconCart from '../icons/IconCart.vue';
import IconHeart from '../icons/IconHeart.vue';
import IconUser from '../icons/IconUser.vue';
import IconMyOrder from '../icons/IconMyOrder.vue';
import IconLogout from '../icons/IconLogout.vue';
import { ref, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import { useRouter } from 'vue-router';
import axiosInstance from '@/config/axios';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import { useWishListStore } from '@/stores/wishList';

const router = useRouter();
const route = useRoute();
const isShowAction = ref(false);
const isShowGroupAction = ref(true);
const counterCartAndWishList = useCounterCartAndWishList();
const searchQuery = ref('');
const wishListStore = useWishListStore();

watchEffect(() => {
    if (
        route.name === 'auth-login' ||
        route.name === 'auth-register' ||
        route.name === 'auth-verify-email' ||
        route.name === 'reset-password'
    ) {
        isShowGroupAction.value = false;
    } else {
        isShowGroupAction.value = true;
    }
});

const logout = async () => {
    try {
        const response = await axiosInstance.post('/auth/logout');

        if (response.success) {
            localStorage.removeItem('token');
            router.push('/auth/login');
            counterCartAndWishList.setCart(0);
            counterCartAndWishList.setWishList(0);
            wishListStore.clearWishList();
        }
    } catch (error) {
    }
};

const handleSearch = () => {
    let query = searchQuery.value.trim();
    let currentQuery = new URLSearchParams(route.query);

    if (query) {
        currentQuery.set('search', query);
    } else {
        currentQuery.delete('search');
    }

    router.push({
        path: '/list-book',
        query: Object.fromEntries(currentQuery)
    });
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/layouts/header_layout.scss';
</style>
