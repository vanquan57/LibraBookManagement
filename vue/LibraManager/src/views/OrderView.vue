<template>
    <div class="order-management-container">
        <div class="order-management-breadcrumb-container">
            <h1> Quản lý mượn sách </h1>
            <BreadcrumbComponent
                class="order-management-breadcrumb"
                :breadcrumb-list="breadcrumbList"
            />
        </div>
        <div class="order-management-search">
            <SearchComponent
                placeholder="Nhập email hoặc tên người dùng"
                :is-has-date="true"
                :status-options="statusOptions"
                @search="handleSearch"
            />
        </div>
        <div class="order-management-content">
            <ListOrders
                :table-data="tableData"
                @handle-view-details="handleViewDetails"
            />
            <OrderDetails
                :order-details="orderDetails"
                @update-status-order-details="handleUpdateStatusOrderDetails"
            />
        </div>
        <div
            v-if="tableData.length > 0"
            class="order-management-pagination"
        >
            <PaginationComponent
                :total="dataPagination.total"
                :current-page="dataPagination.currentPage"
                :page-size="dataPagination.limit"
                @current-page="handlePageChange"
            />
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import SearchComponent from '@/components/search/SearchComponent.vue';
import ListOrders from '@/components/order/ListOrders.vue';
import { onMounted, ref, watch } from 'vue';
import { useRoute } from 'vue-router';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { ElNotification } from 'element-plus';
import { useRouter } from 'vue-router';
import STATUS_CODE_ORDER from '@/config/statusOrder';
import { ElMessage } from 'element-plus';
import OrderDetails from '@/components/order/OrderDetails.vue';
import DEFAULT_CONSTANTS from '@/config/constants';
import { showNotificationSuccess, showNotificationError } from '@/helpers/notification';

const router = useRouter();
const route = useRoute();
const tableData = ref([]);
const orderDetails = ref({});
const dataSearch = ref({
    key_word: null,
    start_date: null,
    end_date: null,
    status: null
});
const dataPagination = ref({
    limit: 10,
    total: 0,
    currentPage: 1
});
const statusOptions = [
    {
        value: STATUS_CODE_ORDER.OVERDUE,
        label: 'Quá hạn'
    },
    {
        value: STATUS_CODE_ORDER.BORROWING,
        label: 'Đang mượn'
    },
    {
        value: STATUS_CODE_ORDER.MISSING,
        label: 'Mất sách'
    },
    {
        value: STATUS_CODE_ORDER.RETURNED,
        label: 'Đã trả'
    }
];

const breadcrumbList = ref([
    {
        name: 'Trang chủ',
        path: '/'
    },
    {
        name: 'Danh sách',
        path: '/order'
    }
]);

onMounted(async () => {
    await getOrders();
});

/**
 * The method get data users
 *
 * @param {number} page - The page number
 *
 * @returns {Promise<void>}
 */
const getOrders = async (page = 1, column = null, order = null, dataSearch = {}) => {
    try {
        const response = await axiosInstance.get('/order', {
            params: {
                ...dataSearch,
                limit: dataPagination.value.limit,
                page: page,
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
 * The method handle search
 *
 * @param {string} search - The search
 *
 * @returns {Promise<void>}
 */
const handleSearch = async (search) => {
    const queryParams = {};

    if (search.search) {
        queryParams.key_word = search.search;
    }

    if (search.startDate) {
        queryParams.start_date = search.startDate;
    }

    if (search.endDate) {
        queryParams.end_date = search.endDate;
    }

    if (search.status) {
        queryParams.status = search.status;
    }

    if (Object.keys(queryParams).length > 0) {
        router.push({
            path: route.path,
            query: queryParams
        });
        dataSearch.value = queryParams;

        await getOrders(1, null, null, dataSearch.value);
    } else {
        await getOrders();
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
    getOrders(page, null, null, dataSearch.value);
};

/**
 * The method handle view details
 *
 * @param {number} idOrder - The id order
 *
 * @returns {Promise<void>}
 */
const handleViewDetails = async (idOrder) => {
    try {
        const response = await axiosInstance.get(`/order/${idOrder}`);

        if (response.success) {
            orderDetails.value = response.data;
        }
    } catch (error) {
        showNotificationError(error);
    }
};

const handleUpdateStatusOrderDetails = async (
    orderId,
    bookId,
    status,
    note = null
) => {
    try {
        let response;
        if (status === STATUS_CODE_ORDER.MISSING) {
            response = await axiosInstance.put(`/order/${orderId}`, {
                book_id: bookId,
                status: status,
                note: note
            });
        } else {
            response = await axiosInstance.put(`/order/${orderId}`, {
                book_id: bookId,
                status: status
            });
        }
        if (response.success) {
            showNotificationSuccess(response.data.message);
            handleViewDetails(orderId);
            getOrders(dataPagination.value.currentPage, null, null, dataSearch.value);
        }
    } catch (error) {
        showNotificationError(error);
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/order_view.scss';
</style>
