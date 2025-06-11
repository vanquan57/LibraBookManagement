<template>
    <div>
        <FormPublisher
            :is-edit="false"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import FormPublisher from './FormPublisher.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElNotification } from 'element-plus';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const emit = defineEmits(['get-publishers']);

/**
 * Handle submit form create publisher
 *
 * @param {object} data - The data
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async (data) => {
    try {
        const response = await axiosInstance.post('/publisher', data);
        if (response.success) {
            showNotificationSuccess('Thêm nhà xuất bản thành công');

            emit('get-publishers', 1, 'created_at', 'desc');
            router.push({ name: 'publisher' });
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped></style>
