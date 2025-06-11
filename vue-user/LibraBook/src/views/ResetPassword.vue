<template>
    <main class="reset-password-container">
        <div class="side-image">
            <img
                :src="images.heroImage"
                alt=""
            >
        </div>
        <div class="reset-password-form">
            <el-form
                ref="resetPasswordForm"
                :model="form"
                :rules="rules"
                class="form-control"
                @submit.prevent="handleSubmit"
            >
                <div class="form-header">
                    <h2>Đặt lại mật khẩu</h2>
                    <p>Nhập mật khẩu mới của bạn</p>
                </div>
                <el-form-item
                    prop="password"
                    class="form-group"
                >
                    <el-input
                        v-model="form.password"
                        class="form-input no-border"
                        type="password"
                        placeholder="Mật khẩu mới"
                        show-password
                    />
                </el-form-item>

                <el-form-item
                    prop="confirm_password"
                    class="form-group"
                >
                    <el-input
                        v-model="form.confirm_password"
                        class="form-input no-border"
                        type="password"
                        placeholder="Nhập lại mật khẩu"
                        show-password
                    />
                </el-form-item>
                <div class="form-group-actions">
                    <div class="login-actions">
                        <button type="submit">
                            Đặt lại mật khẩu
                        </button>
                    </div>
                </div>
            </el-form>
        </div>
    </main>
</template>

<script setup>
import images from '@/assets/images';
import { reactive, ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import axiosInstance from '@/config/axios';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const route = useRoute();
const form = reactive({
    password: '',
    confirm_password: '',
    email: '',
    token: ''
});
const resetPasswordForm = ref(null);

const rules = {
    password: [
        {
            required: true,
            message: 'Vui lòng nhập mật khẩu mới',
            trigger: 'blur'
        },
        {
            pattern: /^(?=.*\d)(?=.*[A-Z]).{8,}$/,
            message:
                'Mật khẩu phải có ít nhất 8 ký tự và chứa ít nhất một số và một chữ cái viết hoa',
            trigger: 'blur'
        }
    ],
    confirm_password: [
        {
            required: true,
            message: 'Vui lòng nhập lại mật khẩu',
            trigger: 'blur'
        },
        {
            validator: (rule, value, callback) => {
                if (value !== form.password) {
                    callback(
                        new Error('Mật khẩu không khớp')
                    );
                } else {
                    callback();
                }
            },
            trigger: 'blur'
        }
    ]
};

/**
 * Handle submit reset password form
 *
 * @returns {void}
 */
const handleSubmit = async () => {
    await resetPasswordForm.value.validate(async (valid) => {
        if (valid) {
            try {
                const response = await axiosInstance.post(
                    'auth/reset-password',
                    {
                        email: form.email,
                        token: form.token,
                        password: form.password,
                        confirm_password: form.confirm_password
                    }
                );

                if (response.success) {
                    showNotificationSuccess(response.data.message);

                    router.push({ name: 'auth-login' });
                }
            } catch (error) {
                showNotificationError(error);
            }
        }
    });
};

/**
 * Validate reset password form when mounted
 *
 * @returns {void}
 */
onMounted(() => {
    const email = route.query.email;
    const token = route.query.token;

    if (email && token) {
        form.email = email;
        form.token = token;
    } else {
        showNotificationError('Liên kết không hợp lệ, Vui lòng thử lại');

        router.push({ name: 'auth-verify-email' });
    }
});
</script>

<style lang="scss">
@import '@/assets/scss/views/reset_password_view.scss';
</style>
