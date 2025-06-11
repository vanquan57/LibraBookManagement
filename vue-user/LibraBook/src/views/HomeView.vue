<template>
    <div class="home-container">
        <section class="sidebar-carousel">
            <div class="category">
                <ul class="category-list">
                    <li
                        v-for="(category, index) in categories"
                        :key="index"
                        class="category-list_item"
                    >
                        <router-link :to="`/list-book?category=${category.id}`">
                            {{ category.name }}
                        </router-link>
                    </li>
                </ul>
            </div>
            <CarouselItem class="carousel" />
        </section>
        <section class="top-book section-container">
            <div class="top-book__most-borrowed">
                <div class="top-book__most-borrowed__today">
                    <span>Top Sách</span>
                </div>
                <div class="top-book__most-borrowed__title">
                    <h2>Top sách mượn nhiều</h2>
                    <div class="carousel-controls">
                        <button
                            class="carousel-controls__prev"
                            @click="handlePrev"
                        >
                            <IconArrowLeft />
                        </button>
                        <button
                            class="carousel-controls__next"
                            @click="handleNext"
                        >
                            <IconArrowRight />
                        </button>
                    </div>
                </div>
                <div
                    ref="carouselRef"
                    class="carousel-container"
                >
                    <div
                        class="carousel-wrapper"
                        :style="{ transform: `translateX(-${currentSlide * 100}%)` }"
                    >
                        <div
                            v-for="(slideBooks, index) in chunkedBooksMostBorrowed"
                            :key="index"
                            class="carousel-slide"
                        >
                            <div class="top-book__most-borrowed__list">
                                <BookCardComponent
                                    v-for="book in slideBooks"
                                    :key="book.id"
                                    :book="book"
                                    @quick-view="handleQuickView"
                                    @add-book-to-cart="handleAddBookToCart"
                                    @add-book-to-wishlist="handleAddBookToWishlist"
                                    @remove-book-from-wishlist="handleRemoveBookFromWishlist"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="btn-container">
                <button
                    class="top-book__most-borrowed__btn-view-all red-btn"
                    @click="
                        handleRedirectToListBook({
                            isMostBorrowed: true,
                        })
                    "
                >
                    Xem thêm
                </button>
            </div>
        </section>
        <section class="list-category section-container">
            <div class="top-book__most-borrowed__today">
                <span>Thể loại</span>
            </div>
            <div class="top-book__most-borrowed__title">
                <h2>Thể loại</h2>
                <div class="carousel-controls">
                    <button
                        class="carousel-controls__prev"
                        @click="handlePrevCategory"
                    >
                        <IconArrowLeft />
                    </button>
                    <button
                        class="carousel-controls__next"
                        @click="handleNextCategory"
                    >
                        <IconArrowRight />
                    </button>
                </div>
            </div>
            <div
                ref="carouselRef"
                class="carousel-container"
            >
                <div
                    class="carousel-wrapper"
                    :style="{ transform: `translateX(-${currentSlideCategory * 100}%)` }"
                >
                    <div
                        v-for="(slideCategory, index) in chunkedCategories"
                        :key="index"
                        class="carousel-slide"
                    >
                        <div class="list-category__list">
                            <CategoryCardComponent
                                v-for="category in slideCategory"
                                :key="category.id"
                                :category="category"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="section-container top-book__most-viewed">
            <div class="top-book__most-borrowed__today">
                <span>Sách được xem nhiều</span>
            </div>
            <div class="top-book__most-borrowed__title">
                <h2>Top sách được xem nhiều</h2>
                <div>
                    <button
                        class="btn-view-all"
                        @click="
                            handleRedirectToListBook({
                                isMostViewed: true,
                            })
                        "
                    >
                        Xem thêm
                    </button>
                </div>
            </div>
            <div class="top-book__most-borrowed__list">
                <BookCardComponent
                    v-for="book in topBooksMostViewed"
                    :key="book.id"
                    :book="book"
                    @quick-view="handleQuickView"
                    @add-book-to-cart="handleAddBookToCart"
                    @add-book-to-wishlist="handleAddBookToWishlist"
                    @remove-book-from-wishlist="handleRemoveBookFromWishlist"
                />
            </div>
            <div class="btn-container">
                <button
                    class="top-book__most-borrowed__btn-view-all"
                    @click="
                        handleRedirectToListBook({
                            isMostViewed: true,
                        })
                    "
                >
                    Xem thêm
                </button>
            </div>
        </section>
        <section class="banner section-container">
            <img
                class="banner__img"
                :src="images.banner"
                alt="banner"
            >
        </section>
        <section class="section-container top-book__most-new-released">
            <div class="top-book__most-borrowed__today">
                <span>Sách mới</span>
            </div>
            <div class="top-book__most-borrowed__title">
                <h2>Sách mới</h2>
                <div class="carousel-controls">
                    <button
                        class="carousel-controls__prev"
                        @click="handlePrevMostNewReleased"
                    >
                        <IconArrowLeft />
                    </button>
                    <button
                        class="carousel-controls__next"
                        @click="handleNextMostNewReleased"
                    >
                        <IconArrowRight />
                    </button>
                </div>
            </div>
            <div
                ref="carouselRef"
                class="carousel-container"
            >
                <div
                    class="carousel-wrapper"
                    :style="{ transform: `translateX(-${currentSlideNewReleased * 100}%)` }"
                >
                    <div
                        v-for="(slideBooks, index) in chunkedBooksNewReleased"
                        :key="index"
                        class="carousel-slide"
                    >
                        <div class="top-book__most-borrowed__list">
                            <BookCardComponent
                                v-for="book in slideBooks"
                                :key="book.id"
                                :book="book"
                                @quick-view="handleQuickView"
                                @add-book-to-cart="handleAddBookToCart"
                                @add-book-to-wishlist="handleAddBookToWishlist"
                                @remove-book-from-wishlist="handleRemoveBookFromWishlist"
                            />
                        </div>
                    </div>
                </div>
            </div>
            <div class="btn-container">
                <button
                    class="top-book__most-borrowed__btn-view-all"
                    @click="
                        handleRedirectToListBook({
                            isMostNewReleased: true,
                        })
                    "
                >
                    Xem thêm
                </button>
            </div>
        </section>
        <section class="book_viral section-container">
            <div class="top-book__most-borrowed__today">
                <span>Sách viral</span>
            </div>
            <div class="top-book__most-borrowed__title">
                <h2>Sách viral</h2>
            </div>
            <div class="book_viral__container">
                <div class="book_viral__left">
                    <img
                        :src="images.viralLeft"
                        alt="book viral left"
                    >
                </div>
                <div class="book_viral__right">
                    <div class="book_viral__right__top">
                        <img
                            :src="images.viralRightTop"
                            alt="book viral right top"
                        >
                    </div>
                    <div class="book_viral__right__bottom">
                        <div class="book_viral__right__bottom__left">
                            <img
                                :src="images.viralBottomLeft"
                                alt="book viral right bottom left"
                            >
                        </div>
                        <div class="book_viral__right__bottom__right">
                            <img
                                :src="images.viralBottomRight"
                                alt="book viral right bottom right"
                            >
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="section-container">
            <div class="about-service">
                <div class="card-group-service">
                    <StatsOverviewComponent
                        v-for="fullService in fullServices"
                        :key="fullService.value"
                        :value="fullService.value"
                        :content="fullService.content"
                        :icon="fullService.icon"
                        :full-service="true"
                        :has-border="false"
                    />
                </div>
            </div>
        </section>
        <button
            v-show="showScrollTop"
            class="scroll-top"
            @click="scrollToTop"
        >
            <IconArrowUp />
        </button>
    </div>
</template>

<script setup>
import images from '@/assets/images';
import CarouselItem from '@/components/carousel/CarouselComponent.vue';
import axiosInstance from '@/config/axios';
import { onMounted, ref, computed } from 'vue';
import IconArrowLeft from '@/components/icons/IconArrowLeft.vue';
import IconArrowRight from '@/components/icons/IconArrowRight.vue';
import BookCardComponent from '@/components/book/BookCardComponent.vue';
import DEFAULT_CONSTANTS from '@/config/constants';
import CategoryCardComponent from '@/components/book/category/CategoryCardComponent.vue';
import IconCustomerService from '@/components/icons/IconCustomerService.vue';
import IconDelivery from '@/components/icons/IconDelivery.vue';
import IconSecure from '@/components/icons/IconSecure.vue';
import StatsOverviewComponent from '@/components/StatsOverviewComponent.vue';
import { markRaw } from 'vue';
import { useRouter} from 'vue-router';
import IconArrowUp from '@/components/icons/IconArrowUp.vue';
import { useAuthStore } from '@/stores/auth';
import { useWishListStore } from '@/stores/wishList';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const categories = ref([]);
const topBooksMostBorrowed = ref([]);
const topBooksMostViewed = ref([]);
const listNewBooks = ref([]);
const showScrollTop = ref(false);
const authStore = useAuthStore();
const wishListStore = useWishListStore();
const counterCartAndWishList = useCounterCartAndWishList();
const carouselRef = ref(null);
const currentSlide = ref(0);
const currentSlideCategory = ref(0);
const currentSlideNewReleased = ref(0);
const booksPerSlide = ref(DEFAULT_CONSTANTS.LIMIT_BOOK);
const categoryPerSlide = ref(DEFAULT_CONSTANTS.LIMIT_SLIDE_CATEGORY);
const booksPerSlideNewReleased = ref(DEFAULT_CONSTANTS.LIMIT_NEW_BOOK);

const listImageCategory = [
    images.categoryCamera,
    images.categoryCellPhone,
    images.categoryComputer,
    images.categoryGamepad,
    images.categoryHeadphone,
    images.categorySmartWatch
];

const fullServices = ref([
    {
        icon: markRaw(IconDelivery),
        value: 'SÁCH',
        content: 'Sách đa dạng'
    },
    {
        icon: markRaw(IconCustomerService),
        value: 'GIỜ LÀM VIỆC',
        content: 'Từ thứ 2 đến thứ 7, 9 AM - 6 PM'
    },
    {
        icon: markRaw(IconSecure),
        value: 'THAM GIA',
        content: 'Khuyến mãi độc quyền và sự kiện'
    }
]);

/**
 * Get categories
 *
 * @returns {Promise<void>}
*/
const getCategories = async (limit = DEFAULT_CONSTANTS.LIMIT_CATEGORY) => {
    try {
        const response = await axiosInstance.get('/categories', {
            params: {
                limit: limit
            }
        });

        if (response.success) {
            categories.value = response.data.data.map((category) => {
                return {
                    ...category,
                    icon: listImageCategory[
                        Math.floor(Math.random() * listImageCategory.length)
                    ]
                };
            });
        }
    } catch (error) {}
};

/**
 * Get top books most borrowed
 *
 * @param {number} page - The page number
 *
 * @returns {Promise<void>}
*/
const getTopBooksMostBorrowed = async (page = 1) => {
    try {
        const response = await axiosInstance.get('/book', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_BOOK,
                most_borrowed: DEFAULT_CONSTANTS.TRUE,
                order: DEFAULT_CONSTANTS.DEFAULT_ORDER,
                page: page
            }
        });

        if (response.success && response.data.last_page > page) {
            topBooksMostBorrowed.value.push(...response.data.data);
        }
    } catch (error) {}
};

/**
 * Get top books most viewed
 *
 * @param {number} page - The page number
 *
 * @returns {Promise<void>}
*/
const getTopBooksMostViewed = async (page = 1) => {
    try {
        const response = await axiosInstance.get('/book', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_BOOK,
                most_viewed: DEFAULT_CONSTANTS.TRUE,
                page: page,
                order: DEFAULT_CONSTANTS.DEFAULT_ORDER
            }
        });

        if (response.success && response.data.last_page > page) {
            topBooksMostViewed.value.push(...response.data.data);
        }
    } catch (error) {}
};

/**
 * Get list new books
 *
 * @returns {Promise<void>}
*/
const getListNewBooks = async (page = 1) => {
    try {
        const response = await axiosInstance.get('/book', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_NEW_BOOK,
                latest: DEFAULT_CONSTANTS.TRUE,
                order: DEFAULT_CONSTANTS.DEFAULT_ORDER,
                page: page
            }
        });

        if (response.success && response.data.last_page > page) {
            listNewBooks.value.push(...response.data.data);
        }
    } catch (error) {}
};

/**
 * Handle add book to cart
 *
 * @param {number} id - The book id
 *
 * @returns {Promise<void>}
*/
const handleAddBookToCart = async (id) => {
    if (await authStore.checkTokenValidity()) {
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
                const { success, error } = response.data.message;

                await getCart();

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
        router.push({ name: 'auth-login' });
    }
};

/**
 * Handle add book to wishlist
 *
 * @param {number} id - The book id
 *
 * @returns {Promise<void>}
*/
const handleAddBookToWishlist = async (id) => {
    if (await authStore.checkTokenValidity()) {
        try {
            const response = await axiosInstance.post('/wish-list', {
                book_id: id
            });

            if (response.success) {
                wishListStore.addToWishList(id);
                await getWishList();

                showNotificationSuccess(response.data.message);
            }
        } catch (error) {
            showNotificationError(error);
        }
    } else {
        router.push({ name: 'auth-login' });
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
 * Get wish list
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
 * Get cart
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
 * Mounted
 *
 * @returns {Promise<void>}
*/
onMounted(async () => {
    await getCategories();
    await getTopBooksMostBorrowed();
    await getTopBooksMostViewed();
    await getListNewBooks();
    await getWishList();
    await getCart();
    window.addEventListener('scroll', handleScroll);
});

/**
 * Handle prev
 *
 * @returns {Promise<void>}
*/
const handlePrev = () => {
    if (currentSlide.value > 0) {
        currentSlide.value--;
    }
};

/**
 * Handle next
 *
 * @returns {Promise<void>}
*/
const handleNext = () => {
    if (currentSlide.value < totalSlidesMostBorrowed.value - 1) {
        currentSlide.value++;
    } else if (currentSlide.value === totalSlidesMostBorrowed.value - 1) {
        getTopBooksMostBorrowed(currentSlide.value == 0 ? 2 : currentSlide.value + 1);

        currentSlide.value++;
    }
};

/**
 * Handle prev category
 *
 * @returns {Promise<void>}
*/
const handlePrevCategory = () => {
    if (currentSlideCategory.value > 0) {
        currentSlideCategory.value--;
    }
};

/**
 * Handle next category
 *
 * @returns {Promise<void>}
*/
const handleNextCategory = () => {
    if (currentSlideCategory.value < totalSlidesCategory.value - 1) {
        currentSlideCategory.value++;
    }
};

/**
 * Handle prev most new released
 *
 * @returns {Promise<void>}
*/
const handlePrevMostNewReleased = () => {
    if (currentSlideNewReleased.value > 0) {
        currentSlideNewReleased.value--;
    }
};

/**
 * Handle next most new released
 *
 * @returns {Promise<void>}
*/
const handleNextMostNewReleased = () => {
    if (currentSlideNewReleased.value < totalSlidesNewReleased.value - 1) {
        currentSlideNewReleased.value++;
    } else if (currentSlideNewReleased.value === totalSlidesNewReleased.value - 1) {
        getListNewBooks(currentSlideNewReleased.value == 0 ? 2 : currentSlideNewReleased.value + 1);

        currentSlideNewReleased.value++;
    }
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

/**
 * Scroll to top
 *
 * @returns {Promise<void>}
*/
const scrollToTop = () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
};

/**
 * Handle scroll
 *
 * @returns {Promise<void>}
*/
const handleScroll = () => {
    showScrollTop.value = window.scrollY > 500;
};

/**
 * Chunked books most borrowed
 *
 * @returns {Promise<void>}
*/
const chunkedBooksMostBorrowed = computed(() => {
    const result = [];

    for (let i = 0; i < topBooksMostBorrowed.value.length; i += booksPerSlide.value) {
        result.push(topBooksMostBorrowed.value.slice(i, i + booksPerSlide.value));
    }

    return result;
});

/**
 * Chunked categories
 *
 * @returns {Promise<void>}
*/
const chunkedCategories = computed(() => {
    const result = [];

    for (let i = 0; i < categories.value.length; i += categoryPerSlide.value) {
        result.push(categories.value.slice(i, i + categoryPerSlide.value));
    }

    return result;
});

/**
 * Chunked books new released
 *
 * @returns {Promise<void>}
*/
const chunkedBooksNewReleased = computed(() => {
    const result = [];

    for (let i = 0; i < listNewBooks.value.length; i += booksPerSlideNewReleased.value) {
        result.push(listNewBooks.value.slice(i, i + booksPerSlideNewReleased.value));
    }

    return result;
});

/**
 * Total slides most borrowed
 *
 * @returns {Promise<void>}
*/
const totalSlidesMostBorrowed = computed(() => chunkedBooksMostBorrowed.value.length);

/**
 * Total slides category
 *
 * @returns {Promise<void>}
*/
const totalSlidesCategory = computed(() => chunkedCategories.value.length);

/**
 * Total slides new released
 *
 * @returns {Promise<void>}
*/
const totalSlidesNewReleased = computed(() => chunkedBooksNewReleased.value.length);
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/home_view.scss';
</style>
