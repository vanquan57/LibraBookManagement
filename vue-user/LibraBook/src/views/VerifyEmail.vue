<template>
    <div>
        <section class="verify-email">
            <main>
                <div class="logo">
                    <img
                        :src="images.logoVku"
                        alt="logo"
                    >
                </div>
                <h1>Xác thực email</h1>
                <el-form
                    ref="formRef"
                    :model="form"
                    :rules="rules"
                    label-position="top"
                    @submit.prevent="onSubmit"
                >
                    <div
                        v-if="errorMessage"
                        class="error-message-container"
                    >
                        <p class="error-message">
                            {{ errorMessage }}
                        </p>
                    </div>

                    <el-form-item prop="email">
                        <el-input
                            v-model="form.email"
                            placeholder="Nhập email của bạn"
                            clearable
                            class="input-field"
                            @input="errorMessage = ''"
                        />
                    </el-form-item>
                    <el-form-item>
                        <el-button
                            type="primary"
                            :loading="loading"
                            class="btn-submit"
                            @click="onSubmit"
                        >
                            Gửi yêu cầu
                        </el-button>
                    </el-form-item>
                </el-form>
            </main>
        </section>
    </div>
</template>

<script setup>
import { ref, reactive } from 'vue';
import images from '@/assets/images';
import axiosInstance from '@/config/axios';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const loading = ref(false);
const formRef = ref(null);

const errorMessage = ref('');
const form = reactive({
    email: ''
});

const rules = {
    email: [
        {
            required: true,
            message: 'Vui lòng nhập email',
            trigger: 'blur'
        },
        {
            type: 'email',
            message: 'Email không đúng định dạng',
            trigger: 'blur'
        },
        {
            validator: (_, value, callback) => {
                if (!value.includes('vku')) {
                    callback(new Error('Bạn không phải sinh viên của VKU?'));
                } else {
                    callback();
                }
            },
            trigger: 'blur'
        }
    ]
};

/**
 * Handle submit verify email form
 *
 * @returns {void}
 */
const onSubmit = () => {
    formRef.value.validate(async (valid) => {
        if (valid) {
            try {
                loading.value = true;

                const response = await axiosInstance.post(
                    '/auth/verify-email',
                    form
                );

                if (response.success) {
                    loading.value = false;

                    showNotificationSuccess(response.data.message);
                }
            } catch (error) {
                loading.value = false;

                showNotificationError(error);
            }
        }
    });
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/verify_email_view.scss';
</style>
