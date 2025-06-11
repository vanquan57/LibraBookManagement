<template>
    <div class="breadcrumb">
        <el-breadcrumb separator="/">
            <el-breadcrumb-item
                v-for="item in breadcrumbList"
                :key="item.path"
                :to="{ path: item.path }"
            >
                <router-link :to="item.path">
                    {{ item.name }}
                </router-link>
            </el-breadcrumb-item>
        </el-breadcrumb>
    </div>
</template>

<script setup>
const props = defineProps({
    breadcrumbList: {
        type: Array,
        default: () => []
    }
});
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/breadcrumb/breadcrumb.scss';
</style>
