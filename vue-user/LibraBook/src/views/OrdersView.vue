<template>
    <section>
        <div class="search-form-container">
            <el-form
                ref="searchFormRef"
                :model="searchForm"
                class="search-form"
                @submit.prevent="handleSearch"
            >
                <el-form-item prop="dateRange">
                    <el-date-picker
                        v-model="searchForm.start_date"
                        type="date"
                        :placeholder="`Chọn ngày bắt đầu`"
                        format="DD/MM/YYYY"
                        value-format="YYYY-MM-DD"
                    />
                </el-form-item>
                <el-form-item prop="dateRange">
                    <el-date-picker
                        v-model="searchForm.end_date"
                        type="date"
                        :placeholder="`Chọn ngày kết thúc`"
                        format="DD/MM/YYYY"
                        value-format="YYYY-MM-DD"
                    />
                </el-form-item>
                <el-form-item prop="status">
                    <el-select
                        v-model="searchForm.status"
                        :placeholder="`Chọn trạng thái`"
                    >
                        <el-option
                            v-for="item in statusOptions"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value"
                        />
                    </el-select>
                </el-form-item>
                <el-form-item justify="center">
                    <el-button
                        type="primary"
                        class="search-button"
                        native-type="submit"
                    >
                        Tìm kiếm
                    </el-button>
                </el-form-item>
            </el-form>
        </div>
        <div class="list-order-container">
            <el-table
                :data="tableData"
                class="table-order"
                :scrolling="true"
                empty-text="Không tìm thấy đơn mượn"
            >
                <el-table-column
                    label="STT"
                    width="80"
                    align="center"
                    type="index"
                />
                <el-table-column
                    prop="code"
                    label="Mã đơn mượn"
                    width="150"
                    align="center"
                    show-overflow-tooltip
                />
                <el-table-column
                    prop="order_details_count"
                    label="Số lượng"
                    width="100"
                    align="center"
                />
                <el-table-column
                    prop="status"
                    label="Trạng thái"
                    width="130"
                >
                    <template #default="{ row }">
                        <span
                            :class="{
                                'status-overdue':
                                    row.status === STATUS_CODE_ORDER.OVERDUE,
                                'status-borrowing':
                                    row.status === STATUS_CODE_ORDER.BORROWING,
                                'status-missing':
                                    row.status === STATUS_CODE_ORDER.MISSING,
                                'status-returned':
                                    row.status === STATUS_CODE_ORDER.RETURNED,
                            }"
                        >
                            {{
                                row.status === STATUS_CODE_ORDER.OVERDUE
                                    ? "Quá hạn"
                                    : row.status === STATUS_CODE_ORDER.BORROWING
                                        ? "Đang mượn"
                                        : row.status === STATUS_CODE_ORDER.MISSING
                                            ? "Mất sách"
                                            : "Đã trả"
                            }}
                        </span>
                    </template>
                </el-table-column>
                <el-table-column
                    prop="created_at"
                    label="Ngày mượn"
                    width="180"
                    align="center"
                >
                    <template #default="{ row }">
                        {{ formatDate(row.created_at) }}
                    </template>
                </el-table-column>
                <el-table-column
                    label="Tính năng"
                    width="180"
                    align="center"
                >
                    <template #default="{ row }">
                        <el-button
                            type="primary"
                            @click="handleViewDetails(row.id)"
                        >
                            Xem chi tiết
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div
                v-if="tableData.length > 0"
                class="order-pagination"
            >
                <PaginationComponent
                    :total="dataPagination.total"
                    :current-page="dataPagination.currentPage"
                    :page-size="dataPagination.limit"
                    @current-page="handlePageChange"
                />
            </div>
        </div>
        <OrderDetails
            :order-details="orderDetails"
            @update-status-order-details="handleUpdateStatusOrderDetails"
        />
    </section>
</template>

<script setup>
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import OrderDetails from '@/components/order/OrderDetails.vue';
import { onMounted, ref } from 'vue';
import STATUS_CODE_ORDER from '@/config/statusOrder';
import axiosInstance from '@/config/axios';
import { useAuthStore } from '@/stores/auth';
import { useRouter } from 'vue-router';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';
import DEFAULT_CONSTANTS from '@/config/constants';

const router = useRouter();
const authStore = useAuthStore();
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
const searchFormRef = ref(null);
const searchForm = ref({
    start_date: '',
    end_date: '',
    status: ''
});
const tableData = ref([]);
const dataPagination = ref({
    limit: DEFAULT_CONSTANTS.LIMIT_HISTORY_ORDER,
    total: 0,
    currentPage: 1
});
const orderDetails = ref({});

/**
 * Handle search
 *
 * @returns {Promise<void>}
 */
const handleSearch = async () => {
    await searchFormRef.value.validate((valid) => {
        if (valid) {
            getListOrder(1, dataPagination.value.limit);
        }
    });
};

/**
 * Handle page change
 *
 * @param {number} page - The page
 *
 * @returns {Promise<void>}
 */
const handlePageChange = (page) => {
    dataPagination.value.currentPage = page;
    getListOrder(page, dataPagination.value.limit);
};

/**
 * Get list order
 *
 * @param {number} page - The page
 *
 * @param {number} limit - The limit
 */
const getListOrder = async (page = 1, limit = 10) => {
    try {
        const response = await axiosInstance.get('/order', {
            params: {
                page,
                limit,
                column: 'created_at',
                order: 'desc',
                ...searchForm.value
            }
        });

        if (response.success && response.data) {
            tableData.value = response.data.data;
        } else {
            tableData.value = [];
        }
    } catch (error) {}
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

/**
 * Handle update status order details
 *
 * @param {number} orderId - The id order
 *
 * @param {number} bookId - The id book
 *
 * @param {number} status - The status
 *
 * @param {string} note - The note
 *
 * @returns {Promise<void>}
 */
const handleUpdateStatusOrderDetails = async (orderId, bookId, status, note = null) => {
    try {
        if (status === STATUS_CODE_ORDER.MISSING) {
            const response = await axiosInstance.put(`/order/${orderId}`, {
                book_id: bookId,
                note,
                status: STATUS_CODE_ORDER.MISSING
            });

            if (response.success) {
                getListOrder(dataPagination.value.currentPage);

                showNotificationSuccess(response.data.message);
            }
        } else {
            const response = await axiosInstance.put(`/order/${orderId}`, {
                book_id: bookId,
                status: status
            });

            if (response.success) {
                getListOrder(dataPagination.value.currentPage);

                showNotificationSuccess(response.data.message);
            }
        }

        handleViewDetails(orderId);
    } catch (error) {
        showNotificationError(error);
    }
};

/**
 * Mounted
 *
 * @returns {Promise<void>}
 */
onMounted(async () => {
    if (!await authStore.checkTokenValidity()) {
        router.push({ name: 'auth-login' });
    } else {
        await getListOrder();
    }
});

/**
 * Format date
 *
 * @param {string} inputDate - The input date
 *
 * @returns {string}
 */
const formatDate = (inputDate) => {
    if (!inputDate) return '';

    const date = new Date(inputDate);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();

    return `${day}/${month}/${year}`;
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/orders_view.scss';
</style>
