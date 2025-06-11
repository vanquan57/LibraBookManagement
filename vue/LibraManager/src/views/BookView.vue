<template>
    <div>
        <div
            v-if="props.site === 'list'"
            class="book-management-container"
        >
            <div class="book-management-breadcrumb-container">
                <BreadcrumbComponent
                    class="book-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
                <router-link
                    to="/book/create"
                    class="book-button"
                >
                    <el-button type="primary">
                        Thêm mới
                    </el-button>
                </router-link>
            </div>
            <div class="book-management-header-container">
                <h1>Danh sách sách</h1>
            </div>
            <div class="book-management-search">
                <SearchComponent
                    placeholder="Nhập tên sách"
                    :is-search-book="true"
                    :author-data="authorData"
                    :publisher-data="publisherData"
                    :category-data="categoryData"
                    :is-reset="true"
                    @search="handleSearch"
                />
            </div>
            <div class="book-management-content">
                <ListBooks
                    :books-data="booksData"
                    @handle-option-delete="handleOptionDelete"
                    @show-details-book="handleShowDetailsBook"
                />
                <DetailsBook :book="bookDetails" />
            </div>
            <div
                v-if="booksData.length > 0"
                class="book-management-pagination"
            >
                <PaginationComponent
                    :total="dataPagination.total"
                    :current-page="dataPagination.currentPage"
                    :page-size="dataPagination.limit"
                    @current-page="handlePageChange"
                />
            </div>
        </div>
        <div
            v-else-if="props.site === 'create'"
            class="book-management-container"
        >
            <div class="book-management-breadcrumb-container">
                <h1>Thêm sách</h1>
                <BreadcrumbComponent
                    class="book-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="book-management-content">
                <CreateBook
                    :author-data="authorData"
                    :publisher-data="publisherData"
                    :category-data="categoryData"
                    @get-books="getBooks"
                />
            </div>
        </div>
        <div
            v-else
            class="book-management-container"
        >
            <div class="book-management-breadcrumb-container">
                <h1>Cập nhật</h1>
                <BreadcrumbComponent
                    class="book-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="book-management-content">
                <EditBook
                    :id="props.id"
                    :author-data="authorData"
                    :publisher-data="publisherData"
                    :category-data="categoryData"
                    :current-page="dataPagination.currentPage"
                    :form-search="formSearch"
                    @get-books="getBooks"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import SearchComponent from '@/components/search/SearchComponent.vue';
import ListBooks from '@/components/book/ListBooks.vue';
import { onMounted, ref, watch, watchEffect } from 'vue';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import CreateBook from '@/components/book/CreateBook.vue';
import EditBook from '@/components/book/EditBook.vue';
import DetailsBook from '@/components/book/DetailsBook.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { ElNotification, ElMessageBox } from 'element-plus';
import { useRouter, useRoute } from 'vue-router';
import DEFAULT_CONSTANTS from '@/config/constants';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const route = useRoute();
const props = defineProps({
    site: {
        type: String,
        default: 'list'
    },
    id: {
        type: Number,
        required: false,
        default: 0
    }
});
const breadcrumbList = ref([
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Tác giả',
        path: '/author'
    }
]);
const booksData = ref([]);
const categoryData = ref([]);
const publisherData = ref([]);
const authorData = ref([]);
const dataPagination = ref({
    limit: 10,
    total: 0,
    currentPage: 1
});
const bookDetails = ref({});
const formSearch = ref({
    name: '',
    category_id: null,
    author_id: null,
    publisher_id: null
});

/**
 * The method get data initial
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    await getBooks();
    await getCategory();
    await getPublisher();
    await getAuthor();
});

watchEffect(() => {
    if (props.site === 'create') {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh sách',
                path: '/book'
            },
            {
                name: 'Thêm mới',
                path: '/book/create'
            }
        ];
    } else if (props.site === 'edit') {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh sách',
                path: '/book'
            },
            {
                name: 'Cập nhật',
                path: `/book/edit/${props.id}`
            }
        ];
    } else {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh sách',
                path: '/book'
            }
        ];
    }
});

/**
 * The method get books
 *
 * @param {number} page - The page
 *
 * @returns {Promise<void>}
 */
const getBooks = async (page = 1, column = null, order = null, formSearch = {}) => {
    try {
        const response = await axiosInstance.get('/book', {
            params: {
                page,
                limit: dataPagination.value.limit,
                column: column ?? DEFAULT_CONSTANTS.COLUMN,
                order: order ?? DEFAULT_CONSTANTS.ORDER,
                ...formSearch
            }
        });

        if (response.success) {
            if (!response.data) {
                booksData.value = [];
            } else {
                booksData.value = response.data.data;
                dataPagination.value.total = response.data.total;
                dataPagination.value.currentPage = response.data.current_page;
            }
        }
    } catch (error) {}
};

/**
 * The method get category
 *
 * @returns {Promise<void>}
 */
const getCategory = async () => {
    const response = await axiosInstance.get('/category', {
        params: {
            limit: 1000
        }
    });
    categoryData.value = response.data.data;
};

/**
 * The method get publisher
 *
 * @returns {Promise<void>}
 */
const getPublisher = async () => {
    const response = await axiosInstance.get('/publisher', {
        params: {
            limit: 1000
        }
    });
    publisherData.value = response.data.data;
};

/**
 * The method get author
 *
 * @returns {Promise<void>}
 */
const getAuthor = async () => {
    const response = await axiosInstance.get('/author', {
        params: {
            limit: 1000
        }
    });
    authorData.value = response.data.data;
};

/**
 * The method handle search
 *
 * @param {object} search - The search
 *
 * @returns {Promise<void>}
 */
const handleSearch = async (search) => {
    try {
        if (search !== '') {
            router.push({
                path: route.path,
                query: {
                    search: search.search || '',
                    category:
                        categoryData.value.find(
                            (item) => item.id === search.category_id
                        )?.slug || null,
                    author:
                        authorData.value.find(
                            (item) => item.id === search.author_id
                        )?.slug || null,
                    publisher:
                        publisherData.value.find(
                            (item) => item.id === search.publisher_id
                        )?.slug || null
                }
            });

            formSearch.value = {
                name: search.search.trim(),
                category_id: search.category_id ? search.category_id : null,
                author_id: search.author_id ? search.author_id : null,
                publisher_id: search.publisher_id
                    ? search.publisher_id
                    : null
            };

            await getBooks(1, null, null, formSearch.value);
        } else {
            await getBooks();
        }
    } catch (error) {
        showNotificationError(error);
    }
};

/**
 * The method handle page change
 *
 * @param {number} page - The page
 *
 * @returns {Promise<void>}
 */
const handlePageChange = async (page) => {
    dataPagination.value.currentPage = page;
    await getBooks(page, null, null, formSearch.value);
};

/**
 * The method handle option delete
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleOptionDelete = async (id) => {
    try {
        await ElMessageBox.confirm(
            'Bạn có chắc chắn muốn xóa sách này không?',
            'Xác nhận',
            {
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy',
                type: 'warning'
            }
        );

        const response = await axiosInstance.delete(`/book/${id}`);

        if (response.success) {
            showNotificationSuccess(response.data.message);

            booksData.value = booksData.value.filter((item) => item.id !== id);
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
const handleShowDetailsBook = async (id) => {
    try {
        const response = await axiosInstance.get(`/book/${id}`);
        if (response.success) {
            bookDetails.value = response.data;
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/book_view.scss';
</style>
