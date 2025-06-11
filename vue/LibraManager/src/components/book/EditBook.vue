<template>
    <div>
        <FormBook
            :id="props.id"
            :is-edit="true"
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

const router = useRouter();
const emit = defineEmits(['getBooks']);
const props = defineProps({
    id: {
        type: Number,
        default: 0
    },
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
    },
    currentPage: {
        type: Number,
        required: true
    },
    formSearch: {
        type: Object,
        default: () => {}
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
    formData.append('author_id', Number(data.author_id));
    formData.append('publisher_id', Number(data.publisher_id));
    formData.append('category_id', Number(data.category_id));
    formData.append('mini_description', data.mini_description);
    formData.append('details_description', data.details_description);
    formData.append('publication_date', data.publication_date);
    formData.append('quantity', Number(data.quantity));
    formData.append('size', data.size);
    formData.append('page', Number(data.page));
    formData.append('cover_type', Number(data.cover_type));
    if (data.image) {
        formData.append('image', data.image);
    }
    if (data.images) {
        data.images.forEach((item) => {
            formData.append('id_images_removed[]', item.id);
            formData.append('images[]', item.file);
        });
    }
    formData.append('_method', 'PUT');

    try {
        const response = await axiosInstance.post(`book/${props.id}`, formData);

        if (response.success) {
            showNotificationSuccess(response.data.message);

            emit('getBooks', props.currentPage, null, null, props.formSearch);
            router.push('/book');
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>


<style lang="scss" scoped></style>
