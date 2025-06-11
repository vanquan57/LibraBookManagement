<template>
    <div class="book-listing">
        <button
            class="toggle-sidebar"
            @click="toggleSidebar"
        >
            <IconHamb />
        </button>
        <aside class="sidebar">
            <div class="filter-section_container">
                <div class="sidebar-header">
                    <div class="sidebar-header-icon_container">
                        <IconGrid class="sidebar-header-icon" />
                    </div>
                    <h3>Danh mục</h3>
                </div>
                <div class="filter-section">
                    <div class="filter-list">
                        <label
                            v-for="category in categories"
                            :key="category.id"
                        >
                            <input
                                v-model="selectedCategory"
                                type="radio"
                                :value="category.id"
                            >
                            <span>{{ category.name }}</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Authors -->
            <div class="filter-section_container">
                <div class="sidebar-header">
                    <div class="sidebar-header-icon_container">
                        <IconAuthor class="sidebar-header-icon" />
                    </div>
                    <h3>Tác giả</h3>
                </div>
                <div class="filter-section">
                    <div class="filter-list">
                        <label
                            v-for="author in authors"
                            :key="author.id"
                        >
                            <input
                                v-model="selectedAuthors"
                                type="checkbox"
                                :value="author.id"
                            >
                            <span>{{ author.name }}</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Publishers -->
            <div class="filter-section_container">
                <div class="sidebar-header">
                    <div class="sidebar-header-icon_container">
                        <IconPublisher class="sidebar-header-icon" />
                    </div>
                    <h3>Nhà xuất bản</h3>
                </div>
                <div class="filter-section">
                    <div class="filter-list">
                        <label
                            v-for="publisher in publishers"
                            :key="publisher.id"
                        >
                            <input
                                v-model="selectedPublishers"
                                type="checkbox"
                                :value="publisher.id"
                            >
                            <span>{{ publisher.name }}</span>
                        </label>
                    </div>
                </div>
            </div>
        </aside>
        <aside
            class="sidebar-mobile"
            :class="{ active: isSidebarHidden }"
        >
            <div class="filter-section_container">
                <div class="sidebar-header">
                    <div class="sidebar-header-icon_container">
                        <IconGrid class="sidebar-header-icon" />
                    </div>
                    <h3>Danh mục</h3>
                    <div class="sidebar-mobile-header icon_close_container">
                        <IconClose
                            class="toggle-sidebar-mobile"
                            @click="toggleSidebar"
                        />
                    </div>
                </div>
                <div class="filter-section">
                    <div class="filter-list">
                        <label
                            v-for="category in categories"
                            :key="category.id"
                        >
                            <input
                                v-model="selectedCategory"
                                type="radio"
                                :value="category.id"
                            >
                            <span>{{ category.name }}</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Authors -->
            <div class="filter-section_container">
                <div class="sidebar-header">
                    <div class="sidebar-header-icon_container">
                        <IconAuthor class="sidebar-header-icon" />
                    </div>
                    <h3>Tác giả</h3>
                </div>
                <div class="filter-section">
                    <div class="filter-list">
                        <label
                            v-for="author in authors"
                            :key="author.id"
                        >
                            <input
                                v-model="selectedAuthors"
                                type="checkbox"
                                :value="author.id"
                            >
                            <span>{{ author.name }}</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- Publishers -->
            <div class="filter-section_container">
                <div class="sidebar-header">
                    <div class="sidebar-header-icon_container">
                        <IconPublisher class="sidebar-header-icon" />
                    </div>
                    <h3>Nhà xuất bản</h3>
                </div>
                <div class="filter-section">
                    <div class="filter-list">
                        <label
                            v-for="publisher in publishers"
                            :key="publisher.id"
                        >
                            <input
                                v-model="selectedPublishers"
                                type="checkbox"
                                :value="publisher.id"
                            >
                            <span>{{ publisher.name }}</span>
                        </label>
                    </div>
                </div>
            </div>
        </aside>

        <main class="main-content">
            <div class="top-filters">
                <button
                    v-for="filter in filters"
                    :key="filter.id"
                    :class="[
                        'filter-btn',
                        { active: activeFilter === filter.id },
                    ]"
                    @click="setActiveFilter(filter.id)"
                >
                    {{ filter.name }}
                </button>
            </div>

            <div class="book-grid">
                <book-card
                    v-for="book in books"
                    :key="book.id"
                    :book="book"
                    @quick-view="handleQuickView"
                    @add-book-to-cart="handleAddBookToCart"
                    @add-book-to-wishlist="handleAddBookToWishlist"
                    @remove-book-from-wishlist="handleRemoveBookFromWishlist"
                />
            </div>

            <div
                v-if="books.length > 0"
                class="book-management-pagination"
            >
                <PaginationComponent
                    :total="dataPagination.total"
                    :current-page="dataPagination.currentPage"
                    :page-size="dataPagination.limit"
                    @current-page="handlePageChange"
                />
            </div>
        </main>

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
import { ref, onMounted, onUnmounted, watch, watchEffect } from 'vue';
import BookCard from '@/components/book/BookCardComponent.vue';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import IconHamb from '@/components/icons/IconHamb.vue';
import axiosInstance from '@/config/axios';
import { useAuthStore } from '@/stores/auth';
import IconArrowUp from '@/components/icons/IconArrowUp.vue';
import { useRouter, useRoute } from 'vue-router';
import DEFAULT_CONSTANTS from '@/config/constants';
import { useWishListStore } from '@/stores/wishList';
import { useCounterCartAndWishList } from '@/stores/counterCartAndWishList';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';
import IconGrid from '@/components/icons/IconGrid.vue';
import IconAuthor from '@/components/icons/IconAuthor.vue';
import IconPublisher from '@/components/icons/IconPublisher.vue';
import IconClose from '@/components/icons/IconClose.vue';

const router = useRouter();
const route = useRoute();
const selectedCategory = ref(null);
const selectedAuthors = ref([]);
const selectedPublishers = ref([]);
const activeFilter = ref('most-borrowed');
const showScrollTop = ref(false);
const isSidebarHidden = ref(false);
const categories = ref([]);
const authors = ref([]);
const publishers = ref([]);
const books = ref([]);
const authStore = useAuthStore();
const dataSearch = ref({});
const searchQuery = ref('');
const wishListStore = useWishListStore();
const counterCartAndWishList = useCounterCartAndWishList();

const filters = ref([
    { id: DEFAULT_CONSTANTS.MOST_BORROWED, name: 'Mượn nhiều nhất' },
    { id: DEFAULT_CONSTANTS.MOST_VIEWED, name: 'Xem nhiều nhất' },
    { id: DEFAULT_CONSTANTS.MOST_LOVED, name: 'Yêu thích nhiều nhất' }
]);
const dataPagination = ref({
    limit: DEFAULT_CONSTANTS.LIMIT_BOOK_LIST,
    total: 0,
    currentPage: 1
});

/**
 * The method scroll to top
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
 * The method toggle sidebar
 *
 * @returns {Promise<void>}
 */
const toggleSidebar = () => {
    isSidebarHidden.value = !isSidebarHidden.value;
};

/**
 * The method handle scroll
 *
 * @returns {Promise<void>}
 */
const handleScroll = () => {
    showScrollTop.value = window.scrollY > 500;
};

/**
 * The method set active filter
 *
 * @param {string} filterId - The filter id
 *
 * @returns {Promise<void>}
 */
const setActiveFilter = async (filterId) => {
    // Get books if filter is most-borrowed
    if (filterId === DEFAULT_CONSTANTS.MOST_BORROWED) {
        activeFilter.value = DEFAULT_CONSTANTS.MOST_BORROWED;
        dataSearch.value.most_borrowed = DEFAULT_CONSTANTS.TRUE;
        delete dataSearch.value.most_viewed;
        delete dataSearch.value.most_loved;
        dataSearch.value.order = DEFAULT_CONSTANTS.DEFAULT_ORDER;
    }

    // Get books if filter is most-viewed
    if (filterId === DEFAULT_CONSTANTS.MOST_VIEWED) {
        activeFilter.value = DEFAULT_CONSTANTS.MOST_VIEWED;
        delete dataSearch.value.most_borrowed;
        delete dataSearch.value.most_loved;
        dataSearch.value.most_viewed = DEFAULT_CONSTANTS.TRUE;
        dataSearch.value.order = DEFAULT_CONSTANTS.DEFAULT_ORDER;
    }

    // Get books if filter is most_loved
    if (filterId === DEFAULT_CONSTANTS.MOST_LOVED) {
        activeFilter.value = DEFAULT_CONSTANTS.MOST_LOVED;
        delete dataSearch.value.most_borrowed;
        delete dataSearch.value.most_viewed;
        dataSearch.value.most_loved = DEFAULT_CONSTANTS.TRUE;
        dataSearch.value.order = DEFAULT_CONSTANTS.DEFAULT_ORDER;
    }

    await getBooks(1, dataSearch.value);
};

/**
 * The method mounted
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    window.addEventListener('scroll', handleScroll);
    window.scrollTo(0, 0);
    await getCategories();
    await getAuthors();
    await getPublishers();
    await getWishList();
    await getCart();

    // Get books if route is list-book
    if (route.fullPath === '/list-book') {
        await getBooks();
    }

    // Get books if query is search
    if (route.query.search) {
        dataSearch.value.name = route.query.search;
    }

    // Get books if query is category
    if (route.query.category && Number.isInteger(Number(route.query.category))) {
        dataSearch.value.category_id = route.query.category;
        selectedCategory.value = route.query.category;
    }

    // Get books if query is most-borrowed
    if (route.query.isMostBorrowed) {
        activeFilter.value = DEFAULT_CONSTANTS.MOST_BORROWED;
        delete dataSearch.value.most_viewed;
        delete dataSearch.value.most_loved;
        dataSearch.value.most_borrowed = DEFAULT_CONSTANTS.TRUE;
        dataSearch.value.order = DEFAULT_CONSTANTS.DEFAULT_ORDER;
    }

    // Get books if query is most-viewed
    if (route.query.isMostViewed) {
        activeFilter.value = DEFAULT_CONSTANTS.MOST_VIEWED;
        delete dataSearch.value.most_borrowed;
        delete dataSearch.value.most_loved;
        dataSearch.value.most_viewed = DEFAULT_CONSTANTS.TRUE;
        dataSearch.value.order = DEFAULT_CONSTANTS.DEFAULT_ORDER;
    }

    // Get books if query is most-new-released
    if (route.query.isMostNewReleased) {
        delete dataSearch.value.most_borrowed;
        delete dataSearch.value.most_viewed;
        delete dataSearch.value.most_loved;
        activeFilter.value = '';
        dataSearch.value.latest = DEFAULT_CONSTANTS.TRUE;
        dataSearch.value.order = DEFAULT_CONSTANTS.DEFAULT_ORDER;
    }

    await getBooks(1, dataSearch.value);
});

/**
 * The method unmounted
 *
 * @returns {Promise<void>}
 */
onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
});

/**
 * The method watch selected category
 *
 * @returns {Promise<void>}
 */
watch(selectedCategory, async () => {
    if (selectedCategory.value) {
        delete dataSearch.value.category_id;
        dataSearch.value.category_id = selectedCategory.value;

        await getBooks(1, dataSearch.value);

        router.push({
            path: '/list-book',
            query: {
                ...route.query,
                category: categories.value.find(category => category.id === selectedCategory.value).slug
            }
        });
    }
});

/**
 * The method watch selected authors
 *
 * @returns {Promise<void>}
 */
watch(selectedAuthors, async () => {
    if (selectedAuthors.value.length) {
        dataSearch.value.author_id = selectedAuthors.value;

        const selectedAuthorSlugs = selectedAuthors.value
            .map(authorId => {
                const author = authors.value.find(a => a.id === authorId);
                return author ? author.slug : null;
            })
            .filter(slug => slug);

        router.push({
            path: '/list-book',
            query: {
                ...route.query,
                author: selectedAuthorSlugs
            }
        });
    }

    if (selectedAuthors.value.length === 0) {
        delete dataSearch.value.author_id;

        const newQuery = { ...route.query };
        delete newQuery.author;

        router.push({
            path: '/list-book',
            query: newQuery
        });
    }

    await getBooks(1, dataSearch.value);
});

/**
 * The method watch selected publishers
 *
 * @returns {Promise<void>}
 */
watch(selectedPublishers, async () => {
    if (selectedPublishers.value.length) {
        dataSearch.value.publisher_id = selectedPublishers.value;

        const selectedPublisherSlugs = selectedPublishers.value
            .map(publisherId => {
                const publisher = publishers.value.find(p => p.id === publisherId);
                return publisher ? publisher.slug : null;
            })
            .filter(slug => slug);

        router.push({
            path: '/list-book',
            query: {
                ...route.query,
                publisher: selectedPublisherSlugs
            }
        });
    }

    if (selectedPublishers.value.length === 0) {
        delete dataSearch.value.publisher_id;

        const newQuery = { ...route.query };
        delete newQuery.publisher;

        router.push({
            path: '/list-book',
            query: newQuery
        });
    }

    await getBooks(1, dataSearch.value);
});

/**
 * The method watch search query
 *
 * @returns {Promise<void>}
 */
watch(searchQuery, async () => {
    if (searchQuery.value) {
        dataSearch.value.name = searchQuery.value;
        activeFilter.value = '';
        delete dataSearch.value.most_borrowed;
        delete dataSearch.value.most_viewed;
        delete dataSearch.value.most_loved;

        await getBooks(1, dataSearch.value);
    }
}, { immediate: true });

/**
 * The method get categories
 *
 * @returns {Promise<void>}
 */
const getCategories = async () => {
    try {
        const response = await axiosInstance.get('/categories', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_CATEGORY
            }
        });

        categories.value = response.data.data;
    } catch (error) {}
};

/**
 * The method get authors
 *
 * @returns {Promise<void>}
 */
const getAuthors = async () => {
    try {
        const response = await axiosInstance.get('/authors', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_AUTHOR
            }
        });

        authors.value = response.data.data;
    } catch (error) {}
};

/**
 * The method get publishers
 *
 * @returns {Promise<void>}
 */
const getPublishers = async () => {
    try {
        const response = await axiosInstance.get('/publishers', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_PUBLISHER
            }
        });

        publishers.value = response.data.data;
    } catch (error) {}
};

/**
 * The method get books
 *
 * @param {number} page - The page number
 *
 * @param {object} dataSearch - The data search
 */
const getBooks = async (page = 1, dataSearch = {}) => {
    try {
        const response = await axiosInstance.get('/book', {
            params: {
                limit: DEFAULT_CONSTANTS.LIMIT_BOOK_LIST,
                page: page,
                ...dataSearch
            }
        });

        if (response.success && response.data) {
            books.value = response.data.data;
            dataPagination.value.total = response.data.total;
            dataPagination.value.currentPage = response.data.current_page;
            dataPagination.value.limit = response.data.limit;
        } else {
            books.value = [];
        }
    } catch (error) {}
};

/**
 * The method get wish list
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
 * The method get cart
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
 * The method handle page change
 *
 * @param {number} page - The page number
 *
 * @returns {Promise<void>}
 */
const handlePageChange = (page) => {
    dataPagination.value.currentPage = page;

    getBooks(page, dataSearch.value);
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
            await getWishList();

            showNotificationSuccess(response.data.message);
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
const handleQuickView = (id) => {
    router.push({
        name: 'book.detail',
        params: {
            slug: id
        }
    });
};

/**
 * The method watch search query
 *
 * @returns {Promise<void>}
 */
watchEffect(async () => {
    if (route.fullPath === '/list-book') {
        selectedCategory.value = null;
        selectedPublishers.value = [];
        selectedAuthors.value = [];
        searchQuery.value = '';
        dataSearch.value = {};
        activeFilter.value = '';

        await getBooks();
    }

    if (route.query.search) {
        searchQuery.value = route.query.search;
    } else {
        searchQuery.value = '';
        delete dataSearch.value.name;

        await getBooks(1, dataSearch.value);
    }
});
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/list_book_view.scss';
</style>
