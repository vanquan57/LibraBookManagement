<template>
    <div class="wishlist-container">
        <div class="wishlist-header">
            <div class="breadcrumb-container">
                <h2>Danh sách yêu thích ( {{ wishlist.length }} )</h2>
            </div>
            <div class="wishlist-header__action">
                <button
                    class="btn btn-move-all-to-cart"
                    @click="handleMoveAllToCart"
                >
                    Thêm tất cả vào giỏ mượn
                </button>
            </div>
        </div>
        <div class="wishlist-body">
            <div class="wishlist-body__item">
                <BookCardComponent
                    v-for="item in wishlist"
                    :key="item.id"
                    :book="item"
                    :is-wishlist="true"
                    @remove-book-from-wishlist="handleRemoveBookFromWishlist"
                    @add-book-to-cart="handleAddBookToCart"
                />
            </div>
            <section class="top-book section-container">
                <div class="top-book__most-borrowed__today">
                    <span>Sách mới nhất</span>
                    <button
                        class="btn btn-move-all-to-cart"
                        @click="
                            handleRedirectToListBook({
                                isMostNewReleased: true,
                            })
                        "
                    >
                        Xem thêm
                    </button>
                </div>
                <div class="top-book__most-borrowed__list">
                    <BookCardComponent
                        v-for="book in newBooks"
                        :key="book.id"
                        :book="book"
                        :is-new-book="true"
                        @quick-view="handleQuickView"
                        @add-book-to-cart="handleAddBookToCart"
                        @add-book-to-wishlist="handleAddBookToWishlist"
                    />
                </div>
            </section>
        </div>
    </div>
</template>

<script setup>
import BookCardComponent from '@/components/book/BookCardComponent.vue';
import axiosInstance from '@/config/axios';
import { useAuthStore } from '@/stores/auth';
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useWishListStore } from '@/stores/wishList';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import DEFAULT_CONSTANTS from '@/config/constants';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';

const authStore = useAuthStore();
const router = useRouter();
const wishListStore = useWishListStore();
const counterCartAndWishList = useCounterCartAndWishList();
const wishlist = ref([]);
const newBooks = ref([]);

/**
 * Mounted
 *
 * @returns {Promise<void>}
*/
onMounted(async () => {
    if (!authStore.checkTokenValidity()) {
        router.push('/auth/login');
    } else {
        await getWishlist();
        await getCart();
        await getNewBooks();
    }
});

/**
 * Get wishlist
 *
 * @returns {Promise<void>}
*/
const getWishlist = async () => {
    const response = await axiosInstance.get('/wish-list');

    if (response.success) {
        wishlist.value = response.data;
        counterCartAndWishList.setWishList(wishlist.value.length);
    }
};

/**
 * Get cart
 *
 * @returns {Promise<void>}
*/
const getCart = async () => {
    const response = await axiosInstance.get('/cart');

    if (response.success) {
        counterCartAndWishList.setCart(response.data.length);
    }
};

/**
 * Handle add book to cart
 *
 * @param {number} id - The book id
 *
 * @returns {Promise<void>}
*/
const handleAddBookToCart = async (id) => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    try {
        const response = await axiosInstance.post('/cart', {
            cart: [
                {
                    book_id: id,
                    quantity: 1
                }
            ]
        });

        if (response.success) {
            await getCart();

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
};

/**
 * Handle move all to cart
 *
 * @returns {Promise<void>}
*/
const handleMoveAllToCart = async () => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    let outOfStockBooks = [];

    const dataAddToCart = wishlist.value
        .filter((item) => {
            if (item.quantity > 1) {
                return true;
            } else {
                outOfStockBooks.push(item.name);

                return false;
            }
        })
        .map((item) => ({
            book_id: item.id,
            quantity: 1
        }));

    if (outOfStockBooks.length > 0) {
        showNotificationError(`Các sách ${outOfStockBooks.join(', ')} đã hết.`);
    }

    if (dataAddToCart.length > 0) {
        try {
            const response = await axiosInstance.post('/cart', {
                cart: dataAddToCart
            });

            if (response.success) {
                await getCart();

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
    }
};

/**
 * Handle remove book from wishlist
 *
 * @param {number} bookId - The book id
 *
 * @returns {Promise<void>}
*/
const handleRemoveBookFromWishlist = async (bookId) => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    try {
        const response = await axiosInstance.delete(`/wish-list/${bookId}`);

        if (response.success) {
            wishlist.value = wishlist.value.filter((item) => item.id !== bookId);
            counterCartAndWishList.setWishList(wishlist.value.length);
            wishListStore.removeFromWishList(bookId);

            showNotificationSuccess(response.data.message);
        }
    } catch (error) {
        showNotificationError(error);
    }
};

/**
 * Get list new books
 *
 * @returns {Promise<void>}
*/
const getNewBooks = async (page = 1) => {
    try {
        const response = await axiosInstance.get('/book', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_BOOK,
                latest: DEFAULT_CONSTANTS.TRUE,
                order: DEFAULT_CONSTANTS.DEFAULT_ORDER,
                page: page
            }
        });

        if (response.success) {
            newBooks.value = response.data.data;
        }
    } catch (error) {}
};

/**
 * Handle redirect to list book
 *
 * @param {Object} props - The props
 *
 * @returns {Promise<void>}
*/
const handleRedirectToListBook = ({ ...props }) => {
    const query = Object.fromEntries(
        Object.entries(props).filter(
            ([key, value]) => value !== undefined && value !== null
        )
    );

    router.push({
        name: 'list-book',
        query: query
    });
};

/**
 * Handle quick view
 *
 * @param {number} id - The book id
 *
 * @returns {Promise<void>}
*/
const handleQuickView = (id) => {
    router.push({
        name: 'book.detail',
        params: {
            slug: id
        }
    });
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/wish_list_view.scss';
</style>
