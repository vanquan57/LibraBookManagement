<template>
    <div
        class="category-card"
        @click="handleRedirectToListBook(props.category.id)"
    >
        <img
            :src="props.category.icon"
            alt="category"
        >
        <h3>{{ props.category.name }}</h3>
    </div>
</template>

<script setup>
import { useRouter } from 'vue-router';

const router = useRouter();

const props = defineProps({
    category: {
        type: Object,
        required: true
    }
});

const handleRedirectToListBook = (categoryId) => {
    router.push(`/list-book?category=${categoryId}`);
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/category/category_card.scss';
</style>
