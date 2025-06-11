<template>
    <div>
        <div
            v-if="props.site === 'list'"
            class="category-management-container"
        >
            <div class="category-management-breadcrumb-container">
                <BreadcrumbComponent
                    class="category-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
                <router-link
                    to="/category/create"
                    class="category-button"
                >
                    <el-button type="primary">
                        Thêm mới
                    </el-button>
                </router-link>
            </div>
            <div class="category-management-header-container">
                <div class="category-management-search">
                    <h1>Danh sách danh mục</h1>
                    <SearchForm
                        placeholder="Nhập tên danh mục"
                        :style-input="styleInput"
                        @search="handleSearch"
                    />
                </div>
            </div>
            <div class="category-management-content">
                <ListCategories
                    :table-data="tableData"
                    @handle-option-delete="handleOptionDelete"
                />
            </div>
            <div
                v-if="tableData.length > 0"
                class="category-management-pagination"
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
            class="category-management-container"
        >
            <div class="category-management-breadcrumb-container">
                <h1>Thêm danh mục</h1>
                <BreadcrumbComponent
                    class="category-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="category-management-content">
                <CreateCategory @get-categories="getCategories" />
            </div>
        </div>
        <div
            v-else
            class="category-management-container"
        >
            <div class="category-management-breadcrumb-container">
                <h1>Cập nhật danh mục</h1>
                <BreadcrumbComponent
                    class="category-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="category-management-content">
                <EditCategory
                    :id="props.id"
                    :current-page="dataPagination.currentPage"
                    :name="name"
                    @get-categories="getCategories"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
import SearchForm from '@/components/search/SearchComponent.vue';
import ListCategories from '@/components/category/ListCategories.vue';
import { ref, onMounted, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import CreateCategory from '@/components/category/CreateCategory.vue';
import EditCategory from '@/components/category/EditCategory.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElNotification, ElMessageBox } from 'element-plus';
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
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
        default: null
    }
});

const breadcrumbList = ref([
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Danh sách',
        path: '/category'
    }
]);
const styleInput = ref('width: 400px');

const dataPagination = ref({
    limit: 10,
    total: 1,
    currentPage: 1
});
const tableData = ref([]);
const name = ref('');

/**
 * Get categories
 *
 * @returns {Promise<void>}
 */
const getCategories = async (page = 1, column = null, order = null, name = null) => {
    try {
        const response = await axiosInstance.get('/category', {
            params: {
                name: name,
                page,
                limit: dataPagination.value.limit,
                column: column ?? DEFAULT_CONSTANTS.COLUMN,
                order: order ?? DEFAULT_CONSTANTS.ORDER
            }
        });

        if (response.success) {
            if (!response.data) {
                tableData.value = [];
            } else {
                tableData.value = response.data.data;
                dataPagination.value.total = response.data.total;
                dataPagination.value.currentPage = response.data.current_page;
            }
        }
    } catch (error) {}
};

/**
 * The method handle mount
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    await getCategories();
});

watchEffect(() => {
    if (props.site === 'create') {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh mục',
                path: '/category'
            },
            {
                name: 'Thêm danh mục',
                path: '/category/create'
            }
        ];
    } else if (props.site === 'edit') {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh mục',
                path: '/category'
            },
            {
                name: 'Cập nhật danh mục',
                path: `/category/edit/${props.id}`
            }
        ];
    } else {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh mục',
                path: '/category'
            }
        ];
    }
});

/**
 * The method handle search
 *
 * @param {string} search - The search
 *
 * @returns {Promise<void>}
 */
const handleSearch = async (search) => {
    const query = search === '' ? {} : { search: search.trim() };

    router.push({
        path: route.path,
        query
    });

    if (search !== '') {
        name.value = search.trim();
        await getCategories(dataPagination.value.currentPage, null, null, search.trim());
    } else {
        name.value = '';
        await getCategories();
    }
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
    getCategories(page);
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
            'Bạn có chắc chắn muốn xóa danh mục này không?',
            'Xác nhận',
            {
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy',
                type: 'warning'
            }
        );

        const response = await axiosInstance.delete(`/category/${id}`);

        if (response.success) {
            showNotificationSuccess(response.data.message);

            tableData.value = tableData.value.filter((item) => item.id !== id);
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/category_view.scss';
</style>
