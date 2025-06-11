<template>
    <main class="login-container">
        <div class="login-container__wrapper">
            <div class="side-image">
                <img
                    :src="images.heroImage"
                    alt=""
                    loading="lazy"
                >
            </div>
            <div class="login-form">
                <el-form
                    ref="loginForm"
                    :model="form"
                    :rules="rules"
                    class="form-control"
                    @submit.prevent="handleSubmit"
                >
                    <div class="form-header">
                        <h2>Đăng nhập VKU-Libra</h2>
                        <p>Nhập thông tin của bạn bên dưới</p>
                    </div>
                    <div
                        v-if="errorMessage"
                        class="error-message-container"
                    >
                        <p class="error-message">
                            {{ errorMessage }}
                        </p>
                    </div>
                    <el-form-item
                        prop="email"
                        class="form-group"
                    >
                        <el-input
                            v-model="form.email"
                            class="form-input no-border"
                            type="email"
                            placeholder="Email"
                            @input="errorMessage = ''"
                        />
                    </el-form-item>

                    <el-form-item
                        prop="password"
                        class="form-group"
                    >
                        <el-input
                            v-model="form.password"
                            class="form-input no-border"
                            type="password"
                            placeholder="Mật khẩu"
                            show-password
                            @input="errorMessage = ''"
                        />
                    </el-form-item>
                    <div class="form-group-actions">
                        <div class="login-google">
                            <button
                                class="btn-login_google"
                                type="button"
                                @click="handleLoginGoogle"
                            >
                                <IconGoogle />
                                Đăng nhập với Google
                            </button>
                        </div>
                        <div class="login-actions">
                            <el-button
                                type="submit"
                                :loading="isLoading"
                                @click="handleSubmit"
                            >
                                Đăng nhập
                            </el-button>
                            <router-link to="/auth/verify-email">
                                Quên mật khẩu?
                            </router-link>
                        </div>
                    </div>
                </el-form>
            </div>
        </div>
    </main>
</template>

<script setup>
import images from '@/assets/images';
import { reactive, ref } from 'vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import IconGoogle from '@/components/icons/IconGoogle.vue';
import { googleTokenLogin } from 'vue3-google-login';
import { showNotificationError } from '@/helpers/notification';

const router = useRouter();
const form = reactive({
    email: '',
    password: ''
});
const loginForm = ref(null);
const errorMessage = ref('');
const isLoading = ref(false);
const rules = {
    email: [
        {
            required: true,
            message: 'Vui lòng nhập email của bạn',
            trigger: 'blur'
        },
        {
            type: 'email',
            message: 'Vui lòng nhập đúng định dạng email',
            trigger: 'blur'
        },
        {
            validator: (rule, value, callback) => {
                if (value && !value.includes('vku')) {
                    callback(new Error('Bạn không phải là sinh viên của VKU?'));
                } else {
                    callback();
                }
            },
            trigger: 'blur'
        }
    ],
    password: [
        {
            required: true,
            message: 'Vui lòng nhập mật khẩu của bạn',
            trigger: 'blur'
        },
        {
            pattern: /^(?=.*\d)(?=.*[A-Z]).{8,}$/,
            message:
                'Mật khẩu phải có ít nhất 8 ký tự và phải có ít nhất một chữ số và một chữ cái viết hoa',
            trigger: 'blur'
        }
    ]
};

/**
 * Google login callback
 *
 * @param {Object} response - Google response
 *
 * @returns {void}
 */
const handleLoginGoogle = async (response) => {
    googleTokenLogin().then(async (response) => {
        try {
            const authResponse = await axiosInstance.post('auth/google/callback', {
                access_token: response.access_token
            });

            if (authResponse.success) {
                localStorage.setItem('token', authResponse.data.access_token);
                router.push('/');
            }
        } catch (error) {
            showNotificationError(error);
        }
    });
};

/**
 * Handle submit login form
 *
 * @returns {void}
 */
const handleSubmit = async () => {
    await loginForm.value.validate(async (valid) => {
        if (valid) {
            isLoading.value = true;

            try {
                const response = await axiosInstance.post('/auth/login', form);

                if (response.success) {
                    isLoading.value = false;
                    localStorage.setItem('token', response.data.access_token);
                    router.push('/');
                }
            } catch (error) {
                isLoading.value = false;
                const errors = error.data.errors;

                if (error.status === HTTP_STATUS_CODE.HTTP_UNPROCESSABLE_ENTITY ) {
                    showNotificationError(error);
                } else {
                    errorMessage.value = errors.error_message;
                }
            }
        }
    });
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/login_view.scss';
</style>
