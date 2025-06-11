<template>
    <div class="card">
        <div
            class="card-body"
            :style="cardBodyStyle"
        >
            <div class="card-header">
                <div class="icon">
                    <component :is="props.icon" />
                </div>
            </div>
            <div class="card-content">
                <h2 :class="{ 'text-small': fullService }">
                    {{ props.value }}
                </h2>
                <p>{{ props.content }}</p>
            </div>
        </div>
    </div>
</template>

<script setup>
import { computed, defineProps } from 'vue';

const props = defineProps({
    value: {
        type: String,
        default: ''
    },
    fullService: {
        type: Boolean,
        default: false
    },
    content: {
        type: String,
        default: ''
    },
    icon: {
        type: Object,
        default: () => ({})
    },
    hasBorder: {
        type: Boolean,
        default: true
    }
});

const cardBodyStyle = computed(() => {
    return {
        border: props.hasBorder ? '1px solid $border-color' : 'none'
    };
});
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/overview/stats_overview_component.scss';
</style>
