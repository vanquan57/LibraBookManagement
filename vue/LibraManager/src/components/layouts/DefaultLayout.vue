<template>
    <div class="container">
        <SidebarLayout @logout="handleLogout" />
        <div class="main-container">
            <HeaderLayout
                class="header-layout"
                @logout="handleLogout"
            />
            <div class="content">
                <RouterView />
            </div>
        </div>
    </div>
</template>

<script setup>
import HTTP_STATUS_CODE from '@/config/statusCode';
import HeaderLayout from './HeaderLayout.vue';
import SidebarLayout from './SidebarLayout.vue';
import axiosInstance from '@/config/axios';
import { useRouter } from 'vue-router';

const router = useRouter();

/**
 * Handle logout
 *
 * @returns {void}
*/
const handleLogout = async () => {
    try {
        const response = await axiosInstance.post('auth/logout');

        if (response.success) {
            localStorage.removeItem('token');
            router.push('/auth/login');
        }
    } catch (error) {
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/layouts/default_layout.scss';
</style>
