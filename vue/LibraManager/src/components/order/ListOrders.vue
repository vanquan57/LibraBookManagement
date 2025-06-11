<template>
    <div class="list-order-container">
        <el-table
            :data="tableData"
            class="table-order"
            :scrolling="true"
            :empty-text="'Không tìm thấy đơn mượn'"
        >
            <el-table-column
                label="STT"
                width="80"
                fixed
                align="center"
                type="index"
            />
            <el-table-column
                prop="code"
                label="Mã đơn mượn"
                width="150"
                fixed
                align="center"
                show-overflow-tooltip
            />
            <el-table-column
                prop="user.name"
                label="Tên người dùng"
                width="200"
                fixed
            />
            <el-table-column
                prop="email"
                label="Email"
                min-width="200"
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
                            'status-overdue': row.status === STATUS_CODE_ORDER.OVERDUE,
                            'status-borrowing': row.status === STATUS_CODE_ORDER.BORROWING,
                            'status-missing': row.status === STATUS_CODE_ORDER.MISSING,
                            'status-returned': row.status === STATUS_CODE_ORDER.RETURNED
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
                label="Action"
                width="180"
                fixed="right"
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
    </div>
</template>

<script setup>
import STATUS_CODE_ORDER from '@/config/statusOrder';

const emit = defineEmits(['handleViewDetails']);
const props = defineProps({
    tableData: {
        type: Array,
        default: () => []
    }
});


const formatDate = (inputDate) => {
    if (!inputDate) return '';

    const date = new Date(inputDate);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();

    return `${day}/${month}/${year}`;
};

/**
 * The method handle view details
 *
 * @param {number} idOrder - The id order
 *
 * @returns {Promise<void>}
 */
const handleViewDetails = (idOrder) => {
    emit('handleViewDetails', idOrder);
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/order/list_order.scss';
</style>
