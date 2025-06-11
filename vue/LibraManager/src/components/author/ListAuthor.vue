<template>
    <div class="list-author-container">
        <el-table
            :data="props.tableData"
            class="table-author"
            :scrolling="true"
            :empty-text="'Không tìm thấy tác giả'"
        >
            <el-table-column
                type="index"
                label="STT"
                width="100"
                fixed
                align="center"
            />
            <el-table-column
                prop="name"
                label="Tên tác giả"
                width="250"
                fixed
            />
            <el-table-column
                prop="description"
                label="Mô tả"
                fixed
            >
                <template #default="{ row }">
                    <p class="format-description">
                        {{ row.description }}
                    </p>
                </template>
            </el-table-column>
            <el-table-column
                fixed="right"
                label="Tính năng"
                width="140"
            >
                <template #default="{ row }">
                    <div class="actions-group">
                        <router-link :to="`/author/edit/${row.id}`">
                            <el-button
                                type="primary"
                                :icon="Edit"
                            />
                        </router-link>
                        <el-button
                            type="danger"
                            :icon="Delete"
                            @click="handleOptionDelete(row.id)"
                        />
                    </div>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script setup>
const emit = defineEmits(['handleOptionDelete']);
import { Edit, Delete } from '@element-plus/icons-vue';

const props = defineProps({
    tableData: {
        type: Array,
        default: () => []
    }
});

/**
 * Handle option delete send emit to parent component
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleOptionDelete = (id) => {
    emit('handleOptionDelete', id);
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/author/list_author.scss';
</style>
