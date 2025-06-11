<template>
    <div>
        <FormAuthor
            :is-edit="true"
            :author="author"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import FormAuthor from './FormAuthor.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElNotification } from 'element-plus';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

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

const emit = defineEmits(['getAuthors']);

const author = ref(null);

/**
 * The method watch props id
 *
 * @param {number} newId - The new id
 *
 * @returns {Promise<void>}
 */
watch(() => props.id, async (newId) => {
    try {
        const response = await axiosInstance.get(`/author/${newId}`);

        if (response.success) {
            author.value = response.data;
        }

    } catch (error) {
        showNotificationError(error);

        router.push({ name: 'author' });
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
        const response = await axiosInstance.put(`/author/${props.id}`, data);

        if (response.success) {
            showNotificationSuccess(response.data.message);

            emit('getAuthors', props.currentPage, null, null, props.name);
            router.push({ name: 'author' });
        }
    } catch (error) {
        showNotificationError(error);
    }
};

</script>

<style lang="scss" scoped></style>
