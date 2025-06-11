<template>
    <div class="details-container">
        <BreadcrumbComponent
            class="breadcrumb-container"
            :breadcrumb-list="breadcrumbs"
        />
        <div class="details-content">
            <div class="details-content-left">
                <div class="detail-image-carousel">
                    <img
                        v-for="image in book.images"
                        :key="image"
                        :src="urlImage(image.url)"
                        alt=""
                        class="image-carousel__item"
                        @click="handleClickImage(image.url)"
                    >
                </div>
                <div class="detail-main-image">
                    <img
                        :src="mainImage"
                        alt=""
                        class="main-image"
                    >
                </div>
            </div>
            <div class="details-content-right">
                <h2 class="book-name">
                    {{ book.name }}
                </h2>
                <div class="book__info">
                    <div class="book__info__rating">
                        <div class="book__info__feedback">
                            <div class="book__info__rating">
                                <div
                                    v-for="i in 5"
                                    :key="i"
                                    :class="[
                                        'book__info__rating__item',
                                        { active: i <= book.average_star },
                                    ]"
                                >
                                    <IconStar />
                                </div>
                                <span class="book__info__total-feedbacks">
                                    ( {{ feedbacks.length }} Nhận xét)
                                </span>
                            </div>
                        </div>
                        <div
                            class="info-book-in-card"
                            :class="[
                                'info-book-in-card',
                                { 'out-of-stock': book.quantity === 0 },
                            ]"
                        >
                            {{ book.quantity > 0 ? "Còn sách" : "Hết sách" }}
                        </div>
                    </div>
                    <div class="book__info__categories">
                        <h3>Thể loại:</h3>
                        <p>
                            {{ computedCategoryName }}
                        </p>
                    </div>
                    <p
                        class="book__info__description"
                        v-html="book.mini_description"
                    />
                </div>
                <div class="book__group-action">
                    <div class="book__group-action__quantity">
                        <span
                            class="book__group-action__quantity__decrement"
                            @click="handleDecrementQuantity"
                        >-</span>
                        <span class="book__group-action__quantity__number">{{
                            quantityBookAddToCart
                        }}</span>
                        <span
                            class="book__group-action__quantity__increment"
                            @click="handleIncrementQuantity"
                        >+</span>
                    </div>
                    <button
                        class="book__group-action__add-cart"
                        @click="handleAddBookToCart(book.id)"
                    >
                        Thêm vào giỏ mượn
                    </button>
                    <button
                        class="book__group-action__wishlist"
                        :class="{'active': wishListStore.wishList.includes(book.id)}"
                        @click="toggleWishlist(book.id)"
                    >
                        <IconHeart />
                    </button>
                </div>
                <div class="book_group-policy">
                    <div class="book_group-policy__delivery">
                        <IconDeliveryDetail />
                        <div class="book_group-policy__delivery__content">
                            <h3>Giao hàng miễn phí</h3>
                            <span><u>Giao hàng trong vòng 24h</u></span>
                        </div>
                    </div>
                    <div class="book_group-policy__return">
                        <IconReturn />
                        <div class="book_group-policy__return__content">
                            <h3>Đổi trả trong 7 ngày</h3>
                            <span>Đổi trả trong vòng <u>7 ngày</u></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="book__description">
            <h2>Mô tả sách</h2>
            <div
                class="details_description"
                v-html="book.details_description"
            />
        </div>
        <div class="details-info_book">
            <h2>Thông tin chi tiêt sách</h2>
            <div class="details-info_book__content">
                <div class="details-info_book__content__item">
                    <p>Nhà xuất bản</p>
                    <p>{{ book.publisher?.name }}</p>
                </div>
                <div class="details-info_book__content__item">
                    <p>Năm xuất bản</p>
                    <p>{{ getYear(book.publication_date) }}</p>
                </div>
                <div class="details-info_book__content__item">
                    <p>Tác giả</p>
                    <p>{{ book.author?.name }}</p>
                </div>
                <div class="details-info_book__content__item">
                    <p>Kích thước</p>
                    <p>{{ book.size }}</p>
                </div>
                <div class="details-info_book__content__item">
                    <p>Số trang</p>
                    <p>{{ book.page }}</p>
                </div>
                <div class="details-info_book__content__item">
                    <p class="last-item">
                        Loại bìa
                    </p>
                    <p class="last-item">
                        {{ coverType[book.cover_type] }}
                    </p>
                </div>
            </div>
        </div>
        <div class="book__feedback">
            <h2>Người mượn đánh giá</h2>
            <div class="book__review__form">
                <div class="book__rating">
                    <label>Đánh giá : {{ selectedStar }} sao</label>
                    <div class="book__info__rating">
                        <div
                            v-for="i in 5"
                            :key="i"
                            :class="[
                                'book__info__rating__item',
                                { active: i <= selectedStar },
                            ]"
                            @click="selectStar(i)"
                        >
                            <IconStar />
                        </div>
                        <p
                            v-if="errorFeedback.star"
                            class="warning"
                        >
                            {{ errorFeedback.star }}
                        </p>
                    </div>
                </div>

                <div class="book__feedback__content">
                    <label for="feedbackContent">Nội dung đánh giá:</label>
                    <textarea
                        id="feedbackContent"
                        v-model="feedbackContent"
                        placeholder="Nhập nội dung đánh giá..."
                        required
                        @input="errorFeedback.content = ''"
                    />
                    <p
                        v-if="errorFeedback.content"
                        class="warning"
                    >
                        {{ errorFeedback.content }}
                    </p>
                </div>

                <button
                    class="submit__button"
                    :disabled="!feedbackContent.trim()"
                    @click="submitFeedback"
                >
                    Gửi đánh giá
                </button>
            </div>
            <div class="book__feedback__list">
                <div
                    v-for="feedback in feedbacks"
                    :key="feedback.id"
                    class="book__feedback__list__item"
                >
                    <div class="book__feedback__list__item__user">
                        <img
                            class="book__feedback__list__item__user__avatar"
                            :src="
                                feedback.avatar ||
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgsaRe2zqH_BBicvUorUseeTaE4kxPL2FmOQ&s'
                            "
                            alt=""
                        >
                        <h2 class="book__feedback__list__item__user__name">
                            {{ feedback.name }}
                        </h2>
                    </div>
                    <div class="book__feedback__list__item__content">
                        <div class="book__info__rating">
                            <div
                                v-for="i in 5"
                                :key="i"
                                :class="[
                                    'book__info__rating__item',
                                    { active: i <= feedback.pivot.star },
                                ]"
                            >
                                <IconStar />
                            </div>
                        </div>
                        <p class="book__feedback__list__item__content__text">
                            {{ feedback.pivot.content }}
                        </p>
                        <p class="book__feedback__list__item__date">
                            {{ formatDate(feedback.pivot.created_at) }}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <section class="top-book section-container">
            <div class="top-book__most-borrowed__today">
                <span>Sách cùng thể loại</span>
            </div>
            <div class="top-book__most-borrowed__list">
                <BookCardComponent
                    v-for="book in listBookSameCategory"
                    :key="book.id"
                    :book="book"
                    @quick-view="handleQuickView"
                    @add-book-to-cart="handleAddBookToCart"
                    @add-book-to-wishlist="handleAddBookToWishlist"
                    @remove-book-from-wishlist="handleRemoveBookFromWishlist"
                />
            </div>
        </section>
    </div>
</template>

<script setup>
import BookCardComponent from '@/components/book/BookCardComponent.vue';
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import IconStar from '@/components/icons/IconStar.vue';
import IconDeliveryDetail from '@/components/icons/IconDeliveryDetail.vue';
import IconReturn from '@/components/icons/IconReturn.vue';
import axiosInstance from '@/config/axios';
import { onMounted, ref, computed } from 'vue';
import { useRoute } from 'vue-router';
import IconHeart from '@/components/icons/IconHeart.vue';
import { useAuthStore } from '@/stores/auth';
import { useRouter } from 'vue-router';
import { useWishListStore } from '@/stores/wishList';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';
import DEFAULT_CONSTANTS from '@/config/constants';

const authStore = useAuthStore();
const wishListStore = useWishListStore();
const counterCartAndWishList = useCounterCartAndWishList();
const router = useRouter();
const route = useRoute();
const slug = route.params.slug;
const book = ref({});
const feedbacks = ref([]);
const mainImage = ref('');
const quantityBookAddToCart = ref(1);
const listBookSameCategory = ref([]);
const breadcrumbs = ref([
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Sách',
        path: '/list-book'
    },
    {
        name: '',
        path: `/book/${slug}`
    }
]);
const selectedStar = ref(0);
const feedbackContent = ref('');
const errorFeedback = ref({
    content: '',
    star: ''
});
const coverType = {
    [DEFAULT_CONSTANTS.TYPE_SOFT_COVER]: 'Bìa mềm',
    [DEFAULT_CONSTANTS.TYPE_HARD_COVER]: 'Bìa cứng'
};

/**
 * The method handle get url image
 *
 * @param {string} url - The url
 *
 * @returns {string}
 */
const urlImage = (url) => {
    return import.meta.env.VITE_URL_IMAGE + url;
};

/**
 * The method handle mounted
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    await getBook(slug);
    await getFeedbacks();
    await getListBookSameCategory();
    await getWishList();
    await getCart();
    window.addEventListener('scroll', handleScroll);
});

/**
 * The method handle get wish list
 *
 * @returns {Promise<void>}
 */
const getWishList = async () => {
    try {
        const response = await axiosInstance.get('/wish-list');

        if (response.success) {
            const booksInWishList = response.data;

            if (booksInWishList) {
                booksInWishList.forEach((book) => {
                    wishListStore.addToWishList(book.id);
                });

                counterCartAndWishList.setWishList(booksInWishList.length);
            } else {
                counterCartAndWishList.setWishList(0);
            }
        }
    } catch (error) {}
};

/**
 * The method handle get cart
 *
 * @returns {Promise<void>}
 */
const getCart = async () => {
    try {
        const response = await axiosInstance.get('/cart');

        if (response.success) {
            counterCartAndWishList.setCart(response.data.length);
        }
    } catch (error) {}
};

/**
 * The method handle get year
 *
 * @param {string} date - The date
 *
 * @returns {string}
 */
const getYear = (date) => {
    return new Date(date).getFullYear();
};

/**
 * The method handle format date
 *
 * @param {string} date - The date
 *
 * @returns {string}
 */
const formatDate = (date) => {
    return new Date(date).toLocaleDateString('vi-VN', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: 'numeric',
        minute: 'numeric'
    });
};

/**
 * The method handle get book
 *
 * @param {string} slug - The slug
 *
 * @returns {Promise<void>}
 */
const getBook = async (slug) => {
    try {
        const response = await axiosInstance.get(`book/${slug}`);

        if (response.success) {
            book.value = response.data;
            const isMobile = window.innerWidth < 768;
            breadcrumbs.value[2].name = isMobile && book.value.name.length > 20 ?
                book.value.name.substring(0, 20) + '...' :
                book.value.name;
            mainImage.value = urlImage(book.value.image);
        }
    } catch (error) {}
};

/**
 * The method handle get feedbacks
 *
 * @returns {Promise<void>}
 */
const getFeedbacks = async () => {
    try {
        const response = await axiosInstance.get('feedbacks', {
            params: {
                book_id: book.value?.id,
                column: 'created_at',
                order: 'desc'
            }
        });

        if (response.success) {
            feedbacks.value = response.data.data;
        }
    } catch (error) {}
};

/**
 * The method handle get list book same category
 *
 * @returns {Promise<void>}
 */
const getListBookSameCategory = async () => {
    try {
        const response = await axiosInstance.get('book', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_BOOK,
                category_id: book.value?.categories[0]?.id
            }
        });

        if (response.success) {
            listBookSameCategory.value = response.data.data;
        }
    } catch (error) {}
};

/**
 * The method handle click image
 *
 * @param {string} url - The url
 *
 * @returns {Promise<void>}
 */
const handleClickImage = (url) => {
    mainImage.value = urlImage(url);
};

/**
 * The method handle decrement quantity
 *
 * @returns {void}
 */
const handleDecrementQuantity = () => {
    if (quantityBookAddToCart.value > 0) {
        quantityBookAddToCart.value--;
    }
};

/**
 * The method handle increment quantity
 *
 * @returns {void}
 */
const handleIncrementQuantity = () => {
    if (quantityBookAddToCart.value < book.value.quantity) {
        quantityBookAddToCart.value++;
    }

    if (quantityBookAddToCart.value > book.value.quantity) {
        showNotificationError('Số lượng sách không đủ');
    }
};

/**
 * The method handle add book to cart
 *
 * @param {number} id - The id
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
                    quantity: quantityBookAddToCart.value
                }
            ]
        });
        if (response.success) {
            await getCart();

            quantityBookAddToCart.value = 1;

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
 * The method handle add book to wishlist
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleAddBookToWishlist = async (id) => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    }

    try {
        const response = await axiosInstance.post('/wish-list', {
            book_id: id
        });

        if (response.success) {
            showNotificationSuccess(response.data.message);

            wishListStore.addToWishList(id);
            await getWishList();
        }
    } catch (error) {
        showNotificationError(error);
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
            wishListStore.removeFromWishList(bookId);

            await getWishList();

            showNotificationSuccess(response.data.message);
        }
    } catch (error) {
        showNotificationError(error);
    }
};

/**
 * The method handle show details book
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleQuickView = async (id) => {
    router.push({
        name: 'book.detail',
        params: {
            slug: id
        }
    });

    await getBook(id);
};

/**
 * The method handle select star
 *
 * @param {number} star - The star
 *
 * @returns {void}
 */
const selectStar = (star) => {
    selectedStar.value = star;
    errorFeedback.value.star = '';
};

/**
 * The method handle submit feedback
 *
 * @returns {Promise<void>}
 */
const submitFeedback = async () => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });

        return;
    } else {
        if (feedbackContent.value.trim() === '') {
            errorFeedback.value.content =
                'Nội dung đánh giá không được để trống';

            return;
        }

        if (feedbackContent.value.length > 255) {
            errorFeedback.value.content =
                'Nội dung đánh giá không được quá 255 ký tự';

            return;
        }

        if (selectedStar.value === 0) {
            errorFeedback.value.star = 'Chọn số sao đánh giá';

            return;
        }

        if (!errorFeedback.value.star && !errorFeedback.value.content) {
            try {
                const response = await axiosInstance.post('/feedback', {
                    book_id: book.value?.id,
                    content: feedbackContent.value,
                    star: selectedStar.value
                });

                if (response.success) {
                    feedbackContent.value = '';
                    selectedStar.value = 0;

                    showNotificationSuccess(response.data.message);
                }
            } catch (error) {
                showNotificationError(error);
            }
        }
    }
};

/**
 * The method computed category name
 *
 * @returns {string}
*/
const computedCategoryName = computed(() => {
    return book.value.categories?.map(category => category.name).join(', ');
});

/**
 * The method handle toggle wishlist
 *
 * @param {number} bookId - The book id
 *
 * @returns {void}
 */
const toggleWishlist = async (bookId) => {
    if (wishListStore.wishList.includes(bookId)) {
        await handleRemoveBookFromWishlist(bookId);
    } else {
        await handleAddBookToWishlist(bookId);
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/details_view.scss';
</style>
