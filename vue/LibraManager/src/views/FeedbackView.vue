<template>
    <div>
        <div class="feedback-management-container">
            <div class="feedback-management-breadcrumb-container">
                <h1>Quản lý phản hồi</h1>
                <BreadcrumbComponent
                    class="feedback-management-breadcrumb"
                    :breadcrumb-list="breadcrumbList"
                />
            </div>
            <div class="feedback-management-search">
                <SearchForm
                    placeholder="Nhập tên sách"
                    :is-has-date="true"
                    @search="handleSearch"
                />
            </div>
            <div class="feedback-management-content">
                <ListFeedback
                    :table-data="tableData"
                    @handle-option-delete="handleOptionDelete"
                    @handle-option-update="handleOptionUpdate"
                />
            </div>
            <div
                v-if="tableData.length > 0"
                class="feedback-management-pagination"
            >
                <PaginationComponent
                    :total="dataPagination.total"
                    :current-page="dataPagination.currentPage"
                    :page-size="dataPagination.limit"
                    @current-page="handlePageChange"
                />
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import SearchForm from '@/components/search/SearchComponent.vue';
import ListFeedback from '@/components/feedback/ListFeedback.vue';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { useRouter } from 'vue-router';
import { ElMessage, ElNotification } from 'element-plus';
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
        path: '/feedback'
    }
]);


const dataPagination = ref({
    limit: 10,
    total: 0,
    currentPage: 1
});
const tableData = ref([]);
const dataSearch = ref({
    key_word: null,
    start_date: null,
    end_date: null,
    status: null
});

/**
 * Get feedbacks
 *
 * @returns {Promise<void>}
 */
const getFeedbacks = async (page = 1, order = null, column = null, dataSearch = {}) => {
    try {
        const response = await axiosInstance.get('/feedback', {
            params: {
                page,
                limit: dataPagination.value.limit,
                column: column ?? DEFAULT_CONSTANTS.COLUMN,
                order: order ?? DEFAULT_CONSTANTS.ORDER,
                ...dataSearch
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
    await getFeedbacks(dataPagination.value.currentPage, 'asc', 'status');
});

/**
 * The method handle search
 *
 * @param {string} search - The search
 *
 * @returns {Promise<void>}
 */
const handleSearch = async (search) => {
    const queryParams = {};

    if (search.search) {
        queryParams.name = search.search;
    }

    if (search.startDate) {
        queryParams.start_date = search.startDate;
    }

    if (search.endDate) {
        queryParams.end_date = search.endDate;
    }

    queryParams.order = DEFAULT_CONSTANTS.FEEDBACK_ORDER;
    queryParams.column = DEFAULT_CONSTANTS.FEEDBACK_COLUMN;

    if (Object.keys(queryParams).length > 0) {
        router.push({
            path: route.path,
            query: queryParams
        });
        dataSearch.value = queryParams;

        await getFeedbacks(dataPagination.value.currentPage, null, null, dataSearch.value);
    } else {
        await getFeedbacks();
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
    getFeedbacks(page, 'asc', 'status', dataSearch.value);
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
        const response = await axiosInstance.delete(`/feedback/${id}`);

        if (response.success) {
            showNotificationSuccess(response.data.message);

            tableData.value = tableData.value.filter((item) => item.id !== id);
        }
    } catch (error) {
        showNotificationError(error);
    }
};

/**
 * The method handle option update
 *
 * @param {number} id - The id
 * @param {number} newStatus - The new status
 * @returns {Promise<void>}
 */
const handleOptionUpdate = async (id, newStatus) => {
    try {
        const response = await axiosInstance.put(`/feedback/${id}`, {
            status: newStatus
        });

        if (response.success) {
            showNotificationSuccess(response.data.message);

            tableData.value = tableData.value.map((item) => {
                if (item.id === id) {
                    item.status = newStatus;
                }
                return item;
            });
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/feedback_view.scss';
</style>
