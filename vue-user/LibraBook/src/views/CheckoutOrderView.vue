<template>
    <div>
        <div class="breadcrumb-container-checkout">
            <BreadcrumbLayout :breadcrumb-list="breadcrumbList" />
        </div>
        <section class="checkout-order-container">
            <div class="checkout-order-container-left">
                <el-form
                    ref="checkoutFormRef"
                    :model="checkoutForm"
                    :rules="rules"
                    class="from-checkout"
                    require-asterisk-position="right"
                >
                    <el-form-item
                        label-position="top"
                        label="Họ tên"
                        prop="name"
                    >
                        <el-input
                            v-model="checkoutForm.name"
                            disabled
                        />
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        label="Mã sinh viên"
                        prop="employee_code"
                    >
                        <el-input
                            v-model="checkoutForm.employee_code"
                            disabled
                        />
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        label="Email"
                        prop="email"
                    >
                        <el-input
                            v-model="checkoutForm.email"
                            disabled
                        />
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        label="Số điện thoại"
                        prop="phone"
                    >
                        <el-input v-model="checkoutForm.phone" />
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        label="Tỉnh thành"
                        prop="province_id"
                    >
                        <el-select
                            v-model="checkoutForm.province_id"
                            placeholder="Chọn tỉnh thành"
                            filterable
                            :no-data-text="'Không tìm thấy tỉnh thành'"
                            @change="getDistricts(checkoutForm.province_id)"
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
                    <el-form-item
                        label-position="top"
                        label="Quận huyện"
                        prop="district_id"
                    >
                        <el-select
                            v-model="checkoutForm.district_id"
                            placeholder="Chọn quận huyện"
                            filterable
                            :no-data-text="'Không tìm thấy quận huyện'"
                            @change="getWards(checkoutForm.district_id)"
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
                    <el-form-item
                        label-position="top"
                        label="Xã phường"
                        prop="ward_id"
                    >
                        <el-select
                            v-model="checkoutForm.ward_id"
                            placeholder="Chọn xã phường"
                            filterable
                            :no-data-text="'Không tìm thấy xã phường'"
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
                    <el-form-item
                        label-position="top"
                        label="Địa chỉ"
                        prop="address"
                    >
                        <el-input v-model="checkoutForm.address" />
                    </el-form-item>
                </el-form>
            </div>
            <div class="checkout-order-container-right">
                <div class="checkout-cart__title">
                    <h2>Sách</h2>
                    <h2>Số lượng</h2>
                    <h2>Ngày trả</h2>
                </div>
                <div class="checkout-cart__list">
                    <div
                        v-for="item in dataCart"
                        :key="item.id"
                        class="checkout-cart__item"
                    >
                        <div class="checkout-cart__item-info">
                            <div class="checkout-cart__item-info-image">
                                <img
                                    :src="imageUrl(item.image)"
                                    alt=""
                                    class="checkout-cart__item-image-img"
                                >
                                <p class="checkout-cart__item-info-name_book">{{ item.name }}</p>
                            </div>
                            <p class="checkout-cart__item-quantity">
                                {{ item.quantity }}
                            </p>
                            <p class="checkout-cart__item-return-date">
                                {{ item.return_date }}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="cart-footer-checkout">
                    <div class="cart-footer-checkout-container">
                        <div class="cart-footer-checkout-total">
                            <p>Tổng cộng</p>
                            <p>{{ dataCart.reduce((total, item) => total + item.quantity, 0) }}</p>
                        </div>
                    </div>
                </div>
                <div class="checkout-cart__button">
                    <button @click="handleSubmit">
                        Xác nhận đơn mượn
                    </button>
                </div>
            </div>
        </section>
    </div>
</template>

<script setup>
import BreadcrumbLayout from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import axiosInstance from '@/config/axios';
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';

const router = useRouter();
const counterCartAndWishList = useCounterCartAndWishList();
const breadcrumbList = [
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Giỏ mượn',
        path: '/cart'
    },
    {
        name: 'Mượn sách',
        path: '/checkout'
    }
];
const provinces = ref([]);
const districts = ref([]);
const wards = ref([]);
const imageUrl = (url) => {
    return `${import.meta.env.VITE_URL_IMAGE}${url}`;
};

onMounted(async () => {
    await getProvinces();
    await getInformationUser();
    await getDataCart();
    await getCounterWishList();
    await getCounterCart();
});

const checkoutForm = ref({
    name: '',
    employee_code: '',
    email: '',
    phone: '',
    province_id: null,
    district_id: null,
    ward_id: null,
    address: ''
});
const checkoutFormRef = ref(null);
const dataCart = ref([]);
const rules = ref({
    name: [
        {
            required: true,
            message: 'Vui lòng nhập họ tên của bạn',
        }
    ],
    employee_code: [
        {
            required: true,
            message: 'Vui lòng nhập mã sinh viên của bạn',
        }
    ],
    email: [
        {
            required: true,
            message: 'Vui lòng nhập email của bạn',
        }
    ],
    phone: [
        {
            required: true,
            message: 'Vui lòng nhập số điện thoại của bạn',
            trigger: 'blur'
        },
        {
            pattern: /^[0-9]*$/,
            message: 'Vui lòng nhập số điện thoại hợp lệ',
            trigger: 'blur'
        },
        {
            min: 10,
            max: 11,
            message: 'Vui lòng nhập số điện thoại hợp lệ',
            trigger: 'blur'
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
 * Get information user
 *
 * @returns {Promise<void>}
 */
const getInformationUser = async () => {
    try {
        const response = await axiosInstance.get('profile');

        if (response.success) {
            checkoutForm.value.name = response.data.name;
            checkoutForm.value.employee_code = response.data.code;
            checkoutForm.value.email = response.data.email;
        }
    } catch (error) {}
};

/**
 * Get data cart
 *
 * @returns {Promise<void>}
 */
const getDataCart = async () => {
    try {
        const cart = JSON.parse(localStorage.getItem('cart'));

        if (cart) {
            dataCart.value = cart;
        }
    } catch (error) {}
};

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
 * Get counter cart
 *
 * @returns {Promise<void>}
 */
const getCounterCart = async () => {
    try {
        const response = await axiosInstance.get('/cart');

        if (response.success) {
            counterCartAndWishList.setCart(response.data.length);
        }
    } catch (error) {}
};

/**
 * Get counter wish list
 *
 * @returns {Promise<void>}
 */
const getCounterWishList = async () => {
    try {
        const response = await axiosInstance.get('/wish-list');

        if (response.success) {
            counterCartAndWishList.setWishList(response.data.length);
        }
    } catch (error) {}
};

/**
 * Handle submit form checkout order
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async () => {
    const valid = await checkoutFormRef.value.validate();

    if (valid) {
        try {
            const dataCart = JSON.parse(localStorage.getItem('cart'));

            if (!dataCart) {
                showNotificationError('Vui lòng cập nhật giỏ mượn');

                return;
            }

            const dataCartStore = dataCart.map((item) => {
                return {
                    book_id: item.book_id,
                    quantity: item.quantity,
                    return_date: item.return_date
                };
            });

            const response = await axiosInstance.post('/order', {
                name: checkoutForm.value.name,
                email: checkoutForm.value.email,
                phone: checkoutForm.value.phone,
                province_id: checkoutForm.value.province_id,
                district_id: checkoutForm.value.district_id,
                ward_id: checkoutForm.value.ward_id,
                address: checkoutForm.value.address,
                order_details: dataCartStore
            });

            if (response.success) {
                localStorage.removeItem('cart');
                showNotificationSuccess(response.data.message);
                router.push('/my-account/orders');
            }
        } catch (error) {
            showNotificationError(error);
        }
    }
};
</script>

<style lang="scss">
@import '@/assets/scss/views/checkout_order_view.scss';
</style>
