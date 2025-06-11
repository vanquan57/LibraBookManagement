<template>
    <div class="carousel">
        <div class="carousel-inner">
            <CarouselItem
                v-for="(slide, index) in slides"
                :key="index"
                :slide="slide"
                :index="index"
                :current-slide="currentSlide"
            />
            <CarouselIndicators
                :total="5"
                :current-index="currentSlide"
                @switch="setCurrentSlide"
            />
        </div>
    </div>
</template>

<script setup>
import images from '@/assets/images';
import CarouselIndicators from './CarouselIndicators.vue';
import CarouselItem from './CarouselItem.vue';
import { onBeforeUnmount, onMounted } from 'vue';
const slides = [
    images.slide1,
    images.slide2,
    images.slide3,
    images.slide4,
    images.slide5
];
import { ref } from 'vue';

const currentSlide = ref(3);
let slideInterval = null;

const setCurrentSlide = (index) => {
    currentSlide.value = index;
};
const startSlideTimer = () => {
    stopSlideTimer();
    slideInterval = setInterval(() => {
        nextSlide();
    }, 3000);
};
const stopSlideTimer = () => {
    clearInterval(slideInterval);
};
const nextSlide = (step = 1) => {
    const index = currentSlide.value < slides.length - 1 ? currentSlide.value + step: 0;
    setCurrentSlide(index);
};

onMounted(() => {
    startSlideTimer();
});
onBeforeUnmount(() => {
    stopSlideTimer();
});
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/carousel/carousel_component.scss';
</style>
