<template>
    <transition :name="transitionEffect">
        <div
            v-show="index === currentSlide"
            class="carousel-item"
        >
            <img
                :src="slide"
                alt=""
            >
        </div>
    </transition>
</template>

<script setup>
import { computed } from 'vue';


const props = defineProps({
    slide: {
        type: String,
        required: true
    },
    index: {
        type: Number,
        required: true
    },
    currentSlide: {
        type: Number,
        required: true
    }
});

const transitionEffect = computed(() => {
    return props.index === props.currentSlide ? 'slide-in' : 'slide-out';
});
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/carousel/carousel_item.scss';
</style>
