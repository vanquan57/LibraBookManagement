<script setup>
import { onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import axiosInstance from '@/config/axios';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';
import HTTP_STATUS_CODE from '@/config/statusCode';

const route = useRoute();
const router = useRouter();

onMounted(async () => {
    const { id, hash } = route.params;
    const { expires, signature } = route.query;

    if (!expires || !signature || !id) {
        router.push('/auth/register');

        return;
    }

    try {
        const response = await axiosInstance.get(`/auth/email/verify/${id}/${hash}`, {
            params: {
                expires,
                signature
            }
        });

        if (response.success) {
            showNotificationSuccess(response.data.message);

            router.push('/auth/login');
        }
    } catch (error) {
        if (error.status === HTTP_STATUS_CODE.HTTP_FORBIDDEN) {
            showNotificationError('Dữ liệu không hợp lệ, vui lòng thử lại.');
        } else {
            showNotificationError(error);
        }

        router.push('/auth/register');
    }
});
</script>
