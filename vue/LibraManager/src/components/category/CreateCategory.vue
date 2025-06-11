<template>
    <div>
        <FormCategory
            :is-edit="false"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import FormCategory from './FormCategory.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElNotification } from 'element-plus';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const emit = defineEmits(['get-categories']);

/**
 * Handle submit form create category
 *
 * @param {object} data - The data
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async (data) => {
    try {
        const response = await axiosInstance.post('/category', data);
        if (response.success) {
            showNotificationSuccess('Thêm danh mục thành công');

            emit('get-categories', 1, 'created_at', 'desc');
            router.push({ name: 'category' });
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped></style>
