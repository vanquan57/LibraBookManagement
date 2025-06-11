<template>
    <div>
        <div
            v-if="props.site === 'list'"
            class="publisher-management-container"
        >
            <div class="publisher-management-breadcrumb-container">
                <BreadcrumbComponent
                    class="publisher-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
                <router-link
                    to="/publisher/create"
                    class="publisher-button"
                >
                    <el-button type="primary">
                        Thêm mới
                    </el-button>
                </router-link>
            </div>
            <div class="publisher-management-header-container">
                <div class="publisher-management-search">
                    <h1>Danh sách nhà xuất bản</h1>
                    <SearchForm
                        placeholder="Nhập tên nhà xuất bản"
                        :style-input="styleInput"
                        @search="handleSearch"
                    />
                </div>
            </div>
            <div class="publisher-management-content">
                <ListPublishers
                    :table-data="tableData"
                    @handle-option-delete="handleOptionDelete"
                />
            </div>
            <div
                v-if="tableData.length > 0"
                class="publisher-management-pagination"
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
            class="publisher-management-container"
        >
            <div class="publisher-management-breadcrumb-container">
                <h1>Thêm nhà xuất bản</h1>
                <BreadcrumbComponent
                    class="publisher-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="publisher-management-content">
                <CreatePublisher @get-publishers="getPublishers" />
            </div>
        </div>
        <div
            v-else
            class="publisher-management-container"
        >
            <div class="publisher-management-breadcrumb-container">
                <h1>Cập nhật nhà xuất bản</h1>
                <BreadcrumbComponent
                    class="publisher-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="publisher-management-content">
                <EditPublisher
                    :id="props.id"
                    :current-page="dataPagination.currentPage"
                    :name="name"
                    @get-publishers="getPublishers"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import SearchForm from '@/components/search/SearchComponent.vue';
import ListPublishers from '@/components/publisher/ListPublishers.vue';
import { ref, onMounted, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import CreatePublisher from '@/components/publisher/CreatePublisher.vue';
import EditPublisher from '@/components/publisher/EditPublisher.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElMessageBox, ElNotification } from 'element-plus';
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
        name: 'Danh mục',
        path: '/category'
    }
]);
const name = ref('');
const dataPagination = ref({
    limit: 10,
    total: 0,
    currentPage: 1
});
const tableData = ref([]);
const styleInput = ref('width: 400px');

/**
 * Get publishers
 *
 * @returns {Promise<void>}
 */
const getPublishers = async (page = 1, column = null, order = null, name = null) => {
    try {
        const response = await axiosInstance.get('/publisher', {
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
    } catch (error) {
    }
};

/**
 * The method handle mount
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    await getPublishers();
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
                path: '/publisher'
            },
            {
                name: 'Thêm mới',
                path: '/publisher/create'
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
                path: '/publisher'
            },
            {
                name: 'Cập nhật',
                path: `/publisher/edit/${props.id}`
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
                path: '/publisher'
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
        await getPublishers(dataPagination.value.currentPage, null, null, search.trim());
    } else {
        name.value = '';
        await getPublishers();
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
    getPublishers(page);
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
        await ElMessageBox.confirm('Bạn có chắc chắn muốn xóa nhà xuất bản này không?', 'Xác nhận', {
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy',
            type: 'warning'
        });

        const response = await axiosInstance.delete(`/publisher/${id}`);

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
@import '@/assets/scss/views/publisher_view.scss';
</style>
