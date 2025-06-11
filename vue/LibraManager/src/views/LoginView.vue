<template>
    <div>
        <section class="login-admin">
            <main>
                <div class="logo">
                    <img
                        :src="images.logoVku"
                        alt="logo"
                    >
                </div>
                <h1>Đăng nhập Admin VKU-Library</h1>
                <div
                    v-if="errorMessages"
                    class="error-message-container"
                >
                    <p class="error-message">
                        {{ errorMessages }}
                    </p>
                </div>
                <el-form
                    ref="formRef"
                    :model="form"
                    :rules="rules"
                    label-position="top"
                >
                    <el-form-item prop="email">
                        <el-input
                            v-model="form.email"
                            placeholder="Nhập email"
                            clearable
                            class="input-field"
                            type="email"
                            @input="errorMessages = ''"
                        />
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input
                            v-model="form.password"
                            placeholder="Nhập mật khẩu"
                            clearable
                            class="input-field"
                            type="password"
                            show-password
                            @input="errorMessages = ''"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-button
                            type="primary"
                            :loading="loading"
                            class="btn-submit"
                            @click="onSubmit"
                        >
                            Đăng nhập
                        </el-button>
                    </el-form-item>
                </el-form>
            </main>
        </section>
    </div>
</template>

<script setup>
import { ref, reactive } from 'vue';
import images from '@/assets/images/index';
import { useRouter } from 'vue-router';
import HTTP_STATUS_CODE from '@/config/statusCode';
import axiosInstance from '@/config/axios';

const router = useRouter();
const loading = ref(false);
const formRef = ref(null);
const errorMessages = ref('');

// Model form data
const form = reactive({
    email: '',
    password: ''
});

// Validate email
const validateEmail = (_, value, callback) => {
    if (!value) {
        callback(new Error('Vui lòng nhập email'));
    } else if (!/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/.test(value)) {
        callback(new Error('Email không đúng định dạng'));
    } else if (!value.includes('vku')) {
        callback(new Error('Bạn không phải là sinh viên VKU'));
    } else {
        callback();
    }
};

// Validate password
const validatePassword = (_, value, callback) => {
    if (!value) {
        callback(new Error('Vui lòng nhập mật khẩu'));
    } else {
        callback();
    }
};

// rules validate form
const rules = {
    email: [{ validator: validateEmail, trigger: 'blur' }],
    password: [{ validator: validatePassword, trigger: 'blur' }]
};

// Handle submit form
const onSubmit = () => {
    formRef.value.validate(async (valid) => {
        if (valid) {
            try {
                loading.value = true;
                const response = await axiosInstance.post('/auth/login', {
                    email: form.email,
                    password: form.password
                });

                if (response.success) {
                    localStorage.setItem('token', response.data.access_token);
                    loading.value = false;
                    router.push({ name: 'home' });
                }
            } catch (error) {
                loading.value = false;
                const errors = error.data.errors;

                if (
                    error.status ===
                        HTTP_STATUS_CODE.HTTP_UNPROCESSABLE_ENTITY
                ) {
                    errorMessages.value = Object.values(errors)[0][0];
                } else if (
                    error.status === HTTP_STATUS_CODE.HTTP_UNAUTHORIZED
                ) {
                    errorMessages.value = errors.error_message;
                }
            }
        }
    });
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/login_view.scss';
</style>
