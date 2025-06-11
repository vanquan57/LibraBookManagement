<template>
    <div class="cart-container">
        <div class="cart-header">
            <BreadcrumbComponent :breadcrumb-list="breadcrumbList" />
        </div>
        <div class="cart-body">
            <div class="cart-item-title">
                <h3 class="cart-item-title-column">
                    Sách
                </h3>
                <h3 class="cart-item-title-column">
                    Số lượng
                </h3>
                <h3 class="cart-item-title-column">
                    Ngày trả
                </h3>
            </div>
            <div
                v-for="(item, index) in cart"
                :key="index"
                class="cart-item"
            >
                <div class="cart-item-column image-column">
                    <img
                        :src="imageUrl(item.image)"
                        alt="Book Image"
                        class="book-image"
                    >
                    <div
                        class="cart-item-column-icon"
                        @click="removeFromCart(item.id)"
                    >
                        <IconRemoveCart />
                    </div>
                    <h3>{{ item.name }}</h3>
                </div>
                <div class="cart-item-column quantity-column">
                    <input
                        v-model.number="item.pivot.quantity"
                        type="number"
                        :max="item.quantity"
                        min="1"
                        @change="validateQuantity(item.id, item.pivot.quantity)"
                        @input="item.pivot.quantity = Math.min(Math.max(1, item.pivot.quantity), item.quantity)"
                    >
                </div>
                <div class="cart-item-column return-date-column">
                    <input
                        v-model="item.returnDate"
                        type="date"
                        @input="validateReturnDate(item.id, item.returnDate)"
                    >
                    <p
                        v-if="item.error"
                        class="return-date-column-error"
                    >
                        {{ item.error }}
                    </p>
                </div>
            </div>
        </div>
        <div class="cart-footer">
            <router-link to="/">
                <button class="cart-footer-button">
                    Trở về trang chủ
                </button>
            </router-link>
            <button
                class="cart-footer-button"
                @click="updateCart"
            >
                Cập nhật giỏ mượn
            </button>
        </div>
        <div class="cart-footer-checkout">
            <div class="cart-footer-checkout-container">
                <h1>Tổng giỏ mượn</h1>
                <div class="cart-footer-checkout-total">
                    <p>Tổng</p>
                    <p>{{ totalQuantity }}</p>
                </div>
                <div class="cart-footer-checkout-button">
                    <router-link to="/checkout">
                        Tiến hành mượn sách
                    </router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import axiosInstance from '@/config/axios';
import { onMounted, ref, computed } from 'vue';
import IconRemoveCart from '@/components/icons/IconRemoveCart.vue';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';
import { useAuthStore } from '@/stores/auth';
import { useRouter } from 'vue-router';

const authStore = useAuthStore();
const router = useRouter();
const counterCartAndWishList = useCounterCartAndWishList();
const breadcrumbList = [
    { name: 'Trang chủ', path: '/' },
    { name: 'Giỏ mượn', path: '/cart' }
];

const cart = ref([]);
const imageUrl = (url) => {
    return `${import.meta.env.VITE_URL_IMAGE}${url}`;
};

/**
 * Mounted
 *
 * @returns {Promise<void>}
*/
onMounted(async () => {
    await getWishList();
    await getCart();
});

/**
 * Update cart
 *
 * @returns {Promise<void>}
*/
async function updateCart() {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    localStorage.removeItem('cart');

    const dataCart = cart.value.map((item) => {
        return {
            book_id: item.id,
            quantity: item.pivot.quantity
        };
    });

    const isValid = cart.value.every((item) => item.error === '');

    if (dataCart.length > 0 && isValid) {
        try {
            const response = await axiosInstance.put('/cart', {
                cart: dataCart
            });

            if (response.success) {
                const dataStoreToLocalStorage = cart.value.map((item) => {
                    return {
                        book_id: item.id,
                        name: item.name,
                        image: item.image,
                        quantity: item.pivot.quantity,
                        return_date: item.returnDate
                    };
                });

                localStorage.setItem(
                    'cart',
                    JSON.stringify(dataStoreToLocalStorage)
                );

                const { success, error } = response.data.message;

                if (success) {
                    showNotificationSuccess(success);
                }

                if (error) {
                    const showError = () => {
                        showNotificationError(error);
                    };

                    success ? setTimeout(showError, 2000) : showError();
                }
            }
        } catch (error) {
            showNotificationError(error);
        }
    } else {
        showNotificationError('Vui lòng điền đầy đủ các trường và kiểm tra ngày trả');
    }
}

/**
 * Get wish list
 *
 * @returns {Promise<void>}
*/
async function getWishList() {
    try {
        const response = await axiosInstance.get('/wish-list');

        if (response.success) {
            counterCartAndWishList.setWishList(response.data.length);
        }
    } catch (error) {}
}

/**
 * Get cart
 *
 * @returns {Promise<void>}
*/
async function getCart() {
    try {
        localStorage.removeItem('cart');
        const response = await axiosInstance.get('/cart');

        if (response.success) {
            for (const item of response.data) {
                item.returnDate = new Date().toISOString().split('T')[0];
                item.error = '';
            }

            cart.value = response.data;

            counterCartAndWishList.setCart(response.data.length);
        }
    } catch (error) {}
}

/**
 * Remove from cart
 *
 * @param {number} id - The id of the item
 *
 * @returns {Promise<void>}
*/
async function removeFromCart(id) {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    try {
        const response = await axiosInstance.delete(`/cart/${id}`);

        if (response.success) {
            cart.value = cart.value.filter((item) => item.id !== id);
            counterCartAndWishList.setCart(cart.value.length);

            showNotificationSuccess(response.data.message);
        }
    } catch (error) {
        showNotificationError(error);
    }
}

/**
 * Validate return date
 *
 * @param {number} id - The id of the item
 *
 * @param {string} returnDate - The return date
 *
 * @returns {Promise<void>}
*/
function validateReturnDate(id, returnDate) {
    const newReturnDate = new Date(returnDate);
    const currentDate = new Date();

    if (newReturnDate < currentDate) {
        cart.value.find((item) => item.id === id).error =
            'Ngày trả không thể nhỏ hơn ngày hiện tại';
    } else {
        cart.value.find((item) => item.id === id).error = '';
    }
}

/**
 * Validate quantity
 *
 * @param {number} id - The id of the item
 *
 * @param {number} quantity - The quantity
 *
 * @returns {Promise<void>}
*/
function validateQuantity(id, quantity) {
    cart.value.find((item) => item.id === id).borrowQuantity = quantity;
}

const totalQuantity = computed(() => {
    return cart.value?.reduce((total, item) => total + item.pivot.quantity, 0);
});

</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/cart_view.scss';
</style>
