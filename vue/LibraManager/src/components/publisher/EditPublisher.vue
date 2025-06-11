<template>
    <div>
        <FormPublisher
            :is-edit="true"
            :publisher="publisher"
            @submit="handleSubmit"
        />
    </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import FormPublisher from './FormPublisher.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { ElMessageBox, ElNotification } from 'element-plus';
import { useRouter } from 'vue-router';
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

const emit = defineEmits(['get-publishers']);

const publisher = ref(null);

/**
 * The method watch props id
 *
 * @param {number} newId - The new id
 *
 * @returns {Promise<void>}
 */
watch(() => props.id, async (newId) => {
    try {
        const response = await axiosInstance.get(`/publisher/${newId}`);

        if (response.success) {
            publisher.value = response.data;
        }
    } catch (error) {
        const errors = error.data.errors;

        if (error && error.status === HTTP_STATUS_CODE.HTTP_NOT_FOUND) {
            ElNotification({
                title: 'Thất bại',
                message: errors.error_message,
                type: 'error'
            });

            router.push({ name: 'publisher' });
        }
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
        const response = await axiosInstance.put(`/publisher/${props.id}`, data);

        if (response.success) {
            showNotificationSuccess(response.data.message);

            emit('get-publishers', props.currentPage, null, null, props.name);
            router.push({ name: 'publisher' });
        }
    } catch (error) {
        showNotificationError(error);
    }
};

</script>

<style lang="scss" scoped></style>
