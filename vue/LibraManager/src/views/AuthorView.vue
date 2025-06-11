<template>
    <div>
        <div
            v-if="props.site === 'list'"
            class="author-management-container"
        >
            <div class="author-management-breadcrumb-container">
                <BreadcrumbComponent
                    class="author-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
                <router-link
                    to="/author/create"
                    class="author-button"
                >
                    <el-button type="primary">
                        Thêm mới
                    </el-button>
                </router-link>
            </div>
            <div class="author-management-header-container">
                <div class="author-management-search">
                    <h1>Danh sách tác giả</h1>
                    <SearchForm
                        placeholder="Nhập tên tác giả"
                        :style-input="styleInput"
                        @search="handleSearch"
                    />
                </div>
            </div>
            <div class="author-management-content">
                <ListAuthor
                    :table-data="tableData"
                    @handle-option-delete="handleOptionDelete"
                />
            </div>
            <div
                v-if="tableData.length > 0"
                class="author-management-pagination"
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
            class="author-management-container"
        >
            <div class="author-management-breadcrumb-container">
                <h1>Thêm tác giả</h1>
                <BreadcrumbComponent
                    class="author-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="author-management-content">
                <CreateAuthor @get-authors="getAuthors" />
            </div>
        </div>
        <div
            v-else
            class="author-management-container"
        >
            <div class="author-management-breadcrumb-container">
                <h1>Cập nhật tác giả</h1>
                <BreadcrumbComponent
                    class="author-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="author-management-content">
                <EditAuthor
                    :id="props.id"
                    :current-page="dataPagination.currentPage"
                    :name="name"
                    @get-authors="getAuthors"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import SearchForm from '@/components/search/SearchComponent.vue';
import ListAuthor from '@/components/author/ListAuthor.vue';
import { ref, onMounted, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import CreateAuthor from '@/components/author/CreateAuthor.vue';
import EditAuthor from '@/components/author/EditAuthor.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElNotification, ElMessageBox } from 'element-plus';
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
        name: 'Tác giả',
        path: '/author'
    }
]);
const styleInput = ref('width: 400px');
const dataPagination = ref({
    limit: 10,
    total: 0,
    currentPage: 1
});
const name = ref('');
const tableData = ref([]);

watchEffect(() => {
    if (props.site === 'create') {
        breadcrumbList.value = [
            {
                name: 'Trang chủ',
                path: '/'
            },
            {
                name: 'Danh sách',
                path: '/author'
            },
            {
                name: 'Thêm mới',
                path: '/author/create'
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
                path: '/author'
            },
            {
                name: 'Cập nhật',
                path: `/author/edit/${props.id}`
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
                path: '/author'
            }
        ];
    }
});

/**
 * Get authors
 *
 * @returns {Promise<void>}
 */
const getAuthors = async (page = 1, column = null, order = null, name = null) => {
    try {
        const response = await axiosInstance.get('/author', {
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
    await getAuthors();
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
        await getAuthors(dataPagination.value.currentPage, null, null, search.trim());
    } else {
        name.value = '';
        await getAuthors();
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
    getAuthors(page);
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
            'Bạn có chắc chắn muốn xóa tác giả này không?',
            'Xác nhận',
            {
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy',
                type: 'warning'
            }
        );

        const response = await axiosInstance.delete(`/author/${id}`);

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
@import '@/assets/scss/views/author_view.scss';
</style>
