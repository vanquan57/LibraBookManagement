<template>
    <div class="layout-container">
        <HeaderLayout />
        <main>
            <RouterView />
        </main>
        <FooterLayout />
    </div>
</template>

<script setup>
import HeaderLayout from '@/components/layouts/HeaderLayout.vue';
import FooterLayout from '@/components/layouts/FooterLayout.vue';
</script>

<style lang="scss" scoped>
@import '@/assets/scss/layouts/default_layout.scss';
</style>
