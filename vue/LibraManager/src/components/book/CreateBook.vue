<template>
    <div>
        <FormBook
            :is-edit="false"
            :author-data="props.authorData"
            :publisher-data="props.publisherData"
            :category-data="props.categoryData"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import FormBook from './FormBook.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { ElNotification } from 'element-plus';
import { useRouter } from 'vue-router';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const emit = defineEmits(['getBooks']);
const router = useRouter();
const props = defineProps({
    authorData: {
        type: Array,
        default: () => []
    },
    publisherData: {
        type: Array,
        default: () => []
    },
    categoryData: {
        type: Array,
        default: () => []
    }
});

/**
 * The method handle submit form book
 *
 * @param {Object} data - The data
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async (data) => {
    const formData = new FormData();

    formData.append('name', data.name);
    formData.append('author_id', data.author_id);
    formData.append('publisher_id', data.publisher_id);
    formData.append('category_id', data.category_id);
    formData.append('mini_description', data.mini_description);
    formData.append('details_description', data.details_description);
    formData.append('publication_date', data.publication_date);
    formData.append('quantity', data.quantity);
    formData.append('size', data.size);
    formData.append('page', data.page);
    formData.append('cover_type', data.cover_type);
    formData.append('image', data.image);
    data.images.forEach(({ id, file }) => {
        formData.append('images[]', file);
    });

    try {
        const response = await axiosInstance.post('book', formData);
        if (response.success) {
            showNotificationSuccess('Thêm mới sách thành công');

            emit('getBooks', 1, 'created_at', 'desc');
            router.push('/book');
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped></style>
