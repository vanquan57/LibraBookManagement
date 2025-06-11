<template>
    <div>
        <FormCategory
            :is-edit="true"
            :category="category"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import FormCategory from './FormCategory.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { ElNotification } from 'element-plus';
import { useRouter } from 'vue-router';
import { showNotificationError } from '@/helpers/notification';

const router = useRouter();
const props = defineProps({
    id: {
        type: Number,
        required: true
    },
    currentPage: {
        type: Number,
        required: true
    },
    name: {
        type: String,
        required: true
    }
});
const emit = defineEmits(['getCategories']);
const category = ref(null);

/**
 * The method watch props id
 *
 * @param {number} newId - The new id
 *
 * @returns {Promise<void>}
 */
watch(() => props.id, async (newId) => {
    try {
        const response = await axiosInstance.get(`/category/${newId}`);

        if (response.success) {
            category.value = response.data;
        }
    } catch (error) {
        showNotificationError(error);

        router.push({ name: 'category' });
    }
}, { immediate: true });

/**
 * The method handle submit
 *
 * @param {object} data - The data
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async (data) => {
    try {
        const response = await axiosInstance.put(`/category/${props.id}`, data);

        if (response.success) {
            ElNotification({
                title: 'Thành công',
                message: response.data.message,
                type: 'success'
            });

            emit('getCategories', props.currentPage, null, null, props.name ?? null);
            router.push({ name: 'category' });
        }
    } catch (error) {
        showNotificationError(error);
    }
};

</script>

<style lang="scss" scoped></style>
