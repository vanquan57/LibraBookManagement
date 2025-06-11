<template>
    <div class="list-user-container">
        <el-table
            class="table-user"
            :data="tableDataWithFullAddress"
            :scrolling="true"
            :empty-text="'Không tìm thấy người dùng'"
        >
            <el-table-column
                prop="id"
                label="STT"
                width="60"
                type="index"
                fixed
            />
            <el-table-column
                prop="code"
                label="Mã nhân viên"
                width="100"
                fixed
            />
            <el-table-column
                prop="name"
                label="Tên người dùng"
                fixed
            />
            <el-table-column
                prop="email"
                label="Email"
                width="230"
            />
            <el-table-column
                prop="fullAddress"
                label="Địa chỉ"
            />
            <el-table-column
                fixed="right"
                label="Cập nhật trạng thái"
                width="160"
            >
                <template #default="{ row }">
                    <el-select
                        clearable
                        placeholder="Chọn trạng thái"
                        :model-value="row.status"
                    >
                        <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value"
                            :disabled="row.status === item.value"
                            @click="handleUpdateStatus(row.id, row.status, item.value)"
                        />
                    </el-select>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script setup>
import STATUS_CODE_USER from '@/config/statusUser';
import { computed } from 'vue';


const emit = defineEmits(['handleUpdateStatus']);
const props = defineProps({
    tableData: {
        type: Array,
        default: () => []
    }
});

/**
 * The method get table data with full address
 *
 * @returns {Array} - The table data with full address
 */
const tableDataWithFullAddress = computed(() => {
    return props.tableData.map((item) => {
        const province = item.province?.name || '';
        const district = item.district?.name || '';
        const ward = item.ward?.name || '';
        const address = item.address || '';

        const fullAddress = [province, district, ward, address].filter(Boolean).join(', ');

        return {
            ...item,
            fullAddress: fullAddress || 'Chưa cập nhật địa chỉ'
        };
    });
});

/**
 * The method get options
 *
 * @returns {Array} - The options
 */
const options = [
    {
        value: STATUS_CODE_USER.WAITING,
        label: 'Chờ kích hoạt'
    },
    {
        value: STATUS_CODE_USER.ACTIVATED,
        label: 'Đã kích hoạt'
    },
    {
        value: STATUS_CODE_USER.LOCKED,
        label: 'Đã khóa'
    }
];

/**
 * The method handle update status
 *
 * @param {number} id - The id of user
 * @param {number} status - The status of user
 *
 * @returns {Promise<void>}
 */
const handleUpdateStatus = (id, currentStatus, status) => {
    if (currentStatus === status) {
        return;
    }
    emit('handleUpdateStatus', id, status);
};

</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/user/list_user.scss';
</style>
