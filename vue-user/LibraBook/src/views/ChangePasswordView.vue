<template>
    <div class="account-container__right__update-info">
        <h1 class="account-container__right__update-info__title">
            Cập nhật mật khẩu
        </h1>
        <div class="account-container__right__update-info__form">
            <div
                v-if="errorMessages"
                class="error-message-container"
            >
                <p class="error-message">
                    {{ errorMessages }}
                </p>
            </div>
            <el-form
                ref="passwordFormRef"
                :model="passwordForm"
                :rules="rules"
                class="from-checkout"
                require-asterisk-position="right"
                @submit.prevent="handleChangePassword"
            >
                <el-row :gutter="20">
                    <el-col :span="24">
                        <el-form-item
                            label-position="top"
                            label="Mật khẩu cũ"
                            prop="current_password"
                        >
                            <el-input
                                v-model="passwordForm.current_password"
                                type="password"
                                show-password
                                @input="errorMessages = ''"
                            />
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                            label-position="top"
                            label="Mật khẩu mới"
                            prop="password"
                        >
                            <el-input
                                v-model="passwordForm.password"
                                type="password"
                                show-password
                            />
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                            label-position="top"
                            label="Nhập lại mật khẩu mới"
                            prop="confirm_password"
                        >
                            <el-input
                                v-model="passwordForm.confirm_password"
                                type="password"
                                show-password
                            />
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div class="group-button">
                <div>
                    <button
                        class="btn-cancel"
                        @click="cancelChangePassword"
                    >
                        Hủy
                    </button>
                    <button
                        class="btn-update"
                        @click="handleChangePassword"
                    >
                        Cập nhật
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import axiosInstance from '@/config/axios';
import { ref } from 'vue';
import { useAuthStore } from '@/stores/auth';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';

const authStore = useAuthStore();
const passwordFormRef = ref(null);
const passwordForm = ref({
    current_password: '',
    password: '',
    confirm_password: ''
});
const errorMessages = ref('');

const rules = ref({
    current_password: [
        {
            required: true,
            message: 'Vui lòng nhập mật khẩu cũ',
            trigger: 'blur'
        }
    ],
    password: [
        {
            required: true,
            message: 'Vui lòng nhập mật khẩu mới',
            trigger: 'blur'
        },
        {
            validator: (rule, value, callback) => {
                const regex =
                    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                if (!regex.test(value)) {
                    callback(
                        new Error(
                            'Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ in hoa, chữ thường, số và ký tự đặc biệt'
                        )
                    );
                } else {
                    callback();
                }
            },
            trigger: 'blur'
        }
    ],
    confirm_password: [
        {
            required: true,
            message: 'Vui lòng nhập lại mật khẩu mới',
            trigger: 'blur'
        },
        {
            validator: (rule, value, callback) => {
                if (value !== passwordForm.value.password) {
                    callback(new Error('Mật khẩu không khớp'));
                } else {
                    callback();
                }
            }
        }
    ]
});

/**
 * Handle change password
 *
 * @returns {Promise<void>}
 */
const handleChangePassword = async () => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    passwordFormRef.value.validate(async (valid) => {
        try {
            if (valid) {
                const response = await axiosInstance.put(
                    'auth/change-password',
                    {
                        current_password: passwordForm.value.current_password,
                        password: passwordForm.value.password,
                        confirm_password: passwordForm.value.confirm_password
                    }
                );

                if (response.success) {
                    showNotificationSuccess(response.data.message);

                    passwordForm.value = {
                        current_password: '',
                        password: '',
                        confirm_password: ''
                    };
                }
            }
        } catch (error) {
            showNotificationError(error);
        }
    });
};

/**
 * Cancel change password
 *
 * @returns {Promise<void>}
 */
const cancelChangePassword = () => {
    passwordForm.value = {
        current_password: '',
        password: '',
        confirm_password: ''
    };
};
</script>

<style lang="scss">
@import '@/assets/scss/views/change_password_view.scss';
</style>
