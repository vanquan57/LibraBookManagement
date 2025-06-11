<template>
    <div class="account-container__right__update-info">
        <h1 class="account-container__right__update-info__title">
            Cập nhật thông tin tài khoản
        </h1>
        <div class="account-container__right__update-info__form">
            <el-form
                ref="accountFormRef"
                :model="accountForm"
                :rules="rules"
                class="from-checkout"
                require-asterisk-position="right"
                @submit.prevent="updateUserInfo"
            >
                <el-row :gutter="gutterValue">
                    <el-col :span="12">
                        <el-form-item
                            label-position="top"
                            label="Email"
                            prop="email"
                        >
                            <el-input
                                v-model="accountForm.email"
                                disabled
                            />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item
                            label-position="top"
                            label="Mã sinh viên"
                            prop="employee_code"
                        >
                            <el-input
                                v-model="accountForm.employee_code"
                                disabled
                            />
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="gutterValue">
                    <el-col :span="12">
                        <el-form-item
                            label-position="top"
                            label="Họ tên"
                            prop="name"
                        >
                            <el-input v-model="accountForm.name" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item
                            label-position="top"
                            label="Tỉnh thành"
                            prop="province_id"
                        >
                            <el-select
                                v-model="accountForm.province_id"
                                placeholder="Chọn tỉnh thành"
                                filterable
                                no-data-text="Không tìm thấy tỉnh thành"
                                @change="getDistricts(accountForm.province_id)"
                            >
                                <el-option
                                    v-for="item in provinces"

                                    :key="item.id"
                                    :label="item.name"
                                    :value="item.id"
                                    :disabled="item.disabled"
                                />
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="gutterValue">
                    <el-col :span="12">
                        <el-form-item
                            label-position="top"
                            label="Quận huyện"
                            prop="district_id"
                        >
                            <el-select
                                v-model="accountForm.district_id"
                                placeholder="Chọn quận huyện"
                                filterable
                                no-data-text="Không tìm thấy quận huyện"
                                @change="getWards(accountForm.district_id)"
                            >
                                <el-option
                                    v-for="item in districts"

                                    :key="item.id"
                                    :label="item.name"
                                    :value="item.id"
                                    :disabled="item.disabled"
                                />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item
                            label-position="top"
                            label="Xã phường"
                            prop="ward_id"
                        >
                            <el-select
                                v-model="accountForm.ward_id"
                                placeholder="Chọn xã phường"
                                filterable
                                no-data-text="Không tìm thấy xã phường"
                            >
                                <el-option
                                    v-for="item in wards"
                                    :key="item.id"
                                    :label="item.name"
                                    :value="item.id"
                                    :disabled="item.disabled"
                                />
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20">
                    <el-col :span="24">
                        <el-form-item
                            label-position="top"
                            label="Địa chỉ"
                            prop="address"
                        >
                            <el-input v-model="accountForm.address" />
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
            <div class="group-button">
                <div>
                    <button
                        class="btn-cancel"
                        @click="cancelUpdateUserInfo"
                    >
                        Hủy
                    </button>
                    <button
                        class="btn-update"
                        @click="updateUserInfo"
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
import { computed, onMounted, onUnmounted, ref } from 'vue';
import { useAuthStore } from '@/stores/auth';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';

const authStore = useAuthStore();
const provinces = ref([]);
const districts = ref([]);
const wards = ref([]);
const accountFormRef = ref(null);
const accountForm = ref({
    name: '',
    employee_code: '',
    email: '',
    province_id: null,
    district_id: null,
    ward_id: null,
    address: ''
});
const defaultAddress = ref({
    name: '',
    province: '',
    district: '',
    ward: '',
    address: '',
    province_id: null,
    district_id: null,
    ward_id: null
});

const rules = ref({
    name: [
        {
            required: true,
            message: 'Vui lòng nhập họ tên của bạn',
            trigger: 'blur'
        }
    ],
    employee_code: [
        {
            required: true,
            message: 'Vui lòng nhập mã sinh viên của bạn'
        }
    ],
    email: [
        {
            required: true,
            message: 'Vui lòng nhập email của bạn'
        }
    ],
    province_id: [
        {
            required: true,
            message: 'Vui lòng chọn tỉnh thành của bạn',
            trigger: 'change'
        }
    ],
    district_id: [
        {
            required: true,
            message: 'Vui lòng chọn quận huyện của bạn',
            trigger: 'change'
        }
    ],
    ward_id: [
        {
            required: true,
            message: 'Vui lòng chọn xã phường của bạn',
            trigger: 'change'
        }
    ],
    address: [
        {
            required: true,
            message: 'Vui lòng nhập địa chỉ của bạn',
            trigger: 'blur'
        }
    ]
});

/**
 * Get provinces
 *
 * @returns {Promise<void>}
 */
const getProvinces = async () => {
    try {
        const response = await axiosInstance.get('/provinces');

        if (response.success) {
            provinces.value = response.data;
        }
    } catch (error) {}
};

/**
 * Get districts
 *
 * @param {number} provinceId - The province id
 *
 * @returns {Promise<void>}
 */
const getDistricts = async (provinceId) => {
    const provinceCode = provinces.value.find(
        (province) => province.id === provinceId
    ).code;

    try {
        const response = await axiosInstance.get(`/districts/${provinceCode}`);

        if (response.success) {
            districts.value = response.data;
        }
    } catch (error) {}
};

/**
 * Get wards
 *
 * @param {number} districtId - The district id
 *
 * @returns {Promise<void>}
 */
const getWards = async (districtId) => {
    const districtCode = districts.value.find(
        (district) => district.id === districtId
    ).code;

    try {
        const response = await axiosInstance.get(`/wards/${districtCode}`);

        if (response.success) {
            wards.value = response.data;
        }
    } catch (error) {}
};

/**
 * Mounted
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    await getProvinces();
    await getUserInfo();
    await getDistricts(defaultAddress.value.province_id);
    await getWards(defaultAddress.value.district_id);
});

/**
 * Get user info
 *
 * @returns {Promise<void>}
 */
const getUserInfo = async () => {
    try {
        const response = await axiosInstance.get('/profile');

        if (response.success) {
            accountForm.value.name = response.data.name;
            accountForm.value.employee_code = response.data.code;
            accountForm.value.email = response.data.email;
            accountForm.value.province_id = response.data.province_id;
            accountForm.value.district_id = response.data.district_id;
            accountForm.value.ward_id = response.data.ward_id;
            accountForm.value.address = response.data.address;
            // default address
            defaultAddress.value.name = response.data.name;
            defaultAddress.value.province = response.data.province.name;
            defaultAddress.value.district = response.data.district.name;
            defaultAddress.value.ward = response.data.ward.name;
            defaultAddress.value.address = response.data.address;
            defaultAddress.value.province_id = response.data.province_id;
            defaultAddress.value.district_id = response.data.district_id;
            defaultAddress.value.ward_id = response.data.ward_id;
        }
    } catch (error) {}
};

/**
 * Update user info
 *
 * @returns {Promise<void>}
 */
const updateUserInfo = async () => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });
        return;
    }

    try {
        accountFormRef.value.validate(async (valid) => {
            if (valid) {
                if (
                    accountForm.value.name !== defaultAddress.value.name ||
                    accountForm.value.province_id !==
                        defaultAddress.value.province_id ||
                    accountForm.value.district_id !==
                        defaultAddress.value.district_id ||
                    accountForm.value.ward_id !== defaultAddress.value.ward_id ||
                    accountForm.value.address !== defaultAddress.value.address
                ) {
                    const response = await axiosInstance.put('/profile', {
                        name: accountForm.value.name,
                        address: accountForm.value.address,
                        province_id: accountForm.value.province_id,
                        district_id: accountForm.value.district_id,
                        ward_id: accountForm.value.ward_id
                    });

                    if (response.success) {
                        showNotificationSuccess(response.data.message);

                        await getUserInfo();
                    }
                } else {
                    showNotificationError('Không có thay đổi nào được tìm thấy');
                }
            }
        });
    } catch (error) {
        showNotificationError(error);
    }
};

/**
 * Cancel update user info
 *
 * @returns {Promise<void>}
 */
const cancelUpdateUserInfo = async () => {
    await getUserInfo();
};

const windowWidth = ref(window.innerWidth);

const updateWidth = () => {
    windowWidth.value = window.innerWidth;
};

onMounted(() => {
    window.addEventListener('resize', updateWidth);
});

onUnmounted(() => {
    window.removeEventListener('resize', updateWidth);
});

const gutterValue = computed(() => (windowWidth.value < 478 ? 30 : 50));
</script>

<style lang="scss" scoped>

</style>
