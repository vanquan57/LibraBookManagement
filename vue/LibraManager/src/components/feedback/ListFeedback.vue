<template>
    <div class="list-feedback-container">
        <el-table
            :data="props.tableData"
            class="table-feedback"
            :scrolling="true"
            :empty-text="'Không tìm thấy phản hồi'"
        >
            <el-table-column
                label="STT"
                width="100"
                fixed
                type="index"
            />
            <el-table-column
                prop="user.name"
                label="Tên người phản hồi"
                fixed
            />
            <el-table-column
                prop="book.name"
                label="Tên sách"
            />
            <el-table-column
                prop="content"
                label="Nội dung"
                align="center"
            >
                <template #default="{ row }">
                    <el-button
                        plain
                        @click="handleOpenContent(row)"
                    >
                        Xem nội dung
                    </el-button>
                </template>
            </el-table-column>
            <el-table-column
                prop="created_at"
                label="Ngày tạo"
                width="130"
            >
                <template #default="{ row }">
                    {{ formatDate(row.created_at) }}
                </template>
            </el-table-column>
            <el-table-column
                fixed="right"
                label="Cập nhật trạng thái"
                width="180"
            >
                <template #default="{ row }">
                    <div class="info-row">
                        <el-select
                            class="status-select"
                            :title="row.status"
                            :model-value="row.status || `Chờ phê duyệt`"
                            @change="
                                handleOptionDelete(row.id, row.status, $event)
                            "
                        >
                            <el-option
                                v-for="option in options"
                                :key="option.value"
                                :value="option.value"
                                :label="option.label"
                                :disabled="option.value === row.status"
                            />
                        </el-select>
                    </div>
                </template>
            </el-table-column>
        </el-table>
        <el-dialog
            v-model="centerDialogVisible"
            title="Thông tin phản hồi"
            width="500"
            center
        >
            <div class="feedback-content">
                <p class="feedback-text">
                    <strong>{{ dataFeedback.user.name }}</strong> đã phản hồi: Sách: <strong>{{ dataFeedback.book.name }}</strong>
                </p>
                <blockquote class="feedback-message">
                    "{{ dataFeedback.content }}"
                </blockquote>
            </div>
            <div class="book-card__info__rating">
                <div
                    v-for="i in 5"
                    :key="i"
                    :class="[
                        'book-card__info__rating__item',
                        { active: i <= dataFeedback.star },
                    ]"
                >
                    <IconStar />
                </div>
            </div>
            <div class="feedback-time">
                <p>
                    Phản hồi lúc:
                    {{ new Date(dataFeedback.created_at).toLocaleString() }}
                </p>
            </div>
        </el-dialog>
    </div>
</template>

<script setup>
import { ElMessage, ElMessageBox } from 'element-plus';
import FEEDBACK_STATUS from '@/config/feedbackStatus';
import IconStar from '@/components/icons/IconStar.vue';
import { ref } from 'vue';

const emit = defineEmits(['handleOptionDelete', 'handleOptionUpdate']);
const props = defineProps({
    tableData: {
        type: Array,
        default: () => []
    }
});
const centerDialogVisible = ref(false);
const dataFeedback = ref({});
const options = [
    {
        value: FEEDBACK_STATUS.ACCEPTED,
        label: 'Phê duyệt'
    },
    {
        value: FEEDBACK_STATUS.REJECTED,
        label: 'Xóa bỏ'
    }
];

/**
 * Handle option delete send emit to parent component
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleOptionDelete = async (id, status, newStatus) => {
    try {
        if (
            status === FEEDBACK_STATUS.ACCEPTED &&
            newStatus == FEEDBACK_STATUS.ACCEPTED
        ) {
            ElMessage.error('Phản hồi đã được phê duyệt');
        }
        if (newStatus === FEEDBACK_STATUS.REJECTED) {
            await ElMessageBox.confirm(
                'Bạn có chắc chắn muốn xóa bỏ phản hồi này không?',
                'Thông báo',
                {
                    confirmButtonText: 'Xóa bỏ',
                    cancelButtonText: 'Hủy',
                    type: 'warning'
                }
            );
            emit('handleOptionDelete', id);
        } else {
            emit('handleOptionUpdate', id, newStatus);
        }
    } catch (error) {
        ElNotification.error({
            title: 'Thất bại',
            message: 'Có lỗi xảy ra khi cập nhật trạng thái'
        });
    }
};

const formatDate = (inputDate) => {
    if (!inputDate) return '';

    const date = new Date(inputDate);
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();

    return `${day}/${month}/${year}`;
};

const handleOpenContent = (row) => {
    dataFeedback.value = row;
    centerDialogVisible.value = true;
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/feedback/list_feedback.scss';
</style>
