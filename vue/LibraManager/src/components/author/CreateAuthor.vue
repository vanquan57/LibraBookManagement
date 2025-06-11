<template>
    <div>
        <FormAuthor
            :is-edit="false"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import FormAuthor from './FormAuthor.vue';
import axiosInstance from '@/config/axios';
import { useRouter } from 'vue-router';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const emit = defineEmits(['getAuthors']);

/**
 * Handle submit form create author
 *
 * @param {object} data - The data
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async (data) => {
    try {
        const response = await axiosInstance.post('/author', data);

        if (response.success) {
            showNotificationSuccess('Thêm tác giả thành công');

            emit('getAuthors', 1, 'created_at', 'desc');
            router.push({ name: 'author' });
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped></style>
