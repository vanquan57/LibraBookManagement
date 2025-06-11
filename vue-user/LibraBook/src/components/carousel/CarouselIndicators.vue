<template>
    <div class="carousel-indicators">
        <button
            v-for="(item, index) in total"
            :key="index"
            class="carousel-indicator-item"
            :class="{ active: currentIndex === index }"
            @click="handleSwitch(index)"
        />
    </div>
</template>

<script setup>
const emit = defineEmits(['switch']);
const props = defineProps({
    currentIndex: {
        type: Number,
        default: 0
    },
    total: {
        type: Number,
        default: 0
    }
});

const handleSwitch = (index) => {
    emit('switch', index);
};


</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/carousel/carousel_indicators.scss';
</style>
