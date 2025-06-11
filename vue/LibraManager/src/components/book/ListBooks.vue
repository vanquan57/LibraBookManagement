<template>
    <div class="list-book-management-container">
        <el-table
            :data="props.booksData"
            class="table-author"
            :scrolling="true"
            :empty-text="'Không tìm thấy sách'"
        >
            <el-table-column
                type="index"
                label="STT"
                width="60"
                align="center"
                fixed="left"
            />
            <el-table-column
                prop="image"
                label="Ảnh"
                width="100"
                align="center"
                fixed="left"
            >
                <template #default="{ row }">
                    <img
                        class="image-book"
                        :src="imageUrl(row.image)"
                        alt="Ảnh sách"
                        width="100"
                        height="100"
                    >
                </template>
            </el-table-column>
            <el-table-column
                prop="name"
                label="Tên sách"
                fixed="left"
            />
            <el-table-column
                prop="quantity"
                label="Số lượng"
                align="center"
            />
            <el-table-column
                prop="categories"
                label="Danh mục"
            >
                <template #default="{ row }">
                    {{ row.categories[0].name }}
                </template>
            </el-table-column>
            <el-table-column
                prop="author"
                label="Tác giả"
            >
                <template #default="{ row }">
                    {{ row.author.name }}
                </template>
            </el-table-column>
            <el-table-column
                prop="publisher"
                label="Nhà xuất bản"
            >
                <template #default="{ row }">
                    {{ row.publisher.name }}
                </template>
            </el-table-column>
            <el-table-column
                prop="views"
                label="Lượt xem"
                align="center"
            />
            <el-table-column
                fixed="right"
                label="Tính năng"
                align="center"
            >
                <template #default="{ row }">
                    <div class="actions-group-book">
                        <el-button
                            type="primary"
                            @click="handleShowDetailsBook(row.id)"
                        >
                            Xem chi tiết
                        </el-button>
                        <div class="actions-group">
                            <router-link :to="`/book/edit/${row.id}`">
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
                    </div>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script setup>
import { Edit, Delete } from '@element-plus/icons-vue';
const emit = defineEmits(['handleOptionDelete', 'showDetailsBook']);
const imageUrl = (url) => {
    return import.meta.env.VITE_STORAGE_URL + url;
};
const props = defineProps({
    booksData: {
        type: Array,
        default: () => []
    }
});

/**
 * The method handle option delete
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleOptionDelete = (id) => {
    emit('handleOptionDelete', id);
};

/**
 * The method handle show details book
 *
 * @param {number} id - The id
 *
 * @returns {Promise<void>}
 */
const handleShowDetailsBook = (id) => {
    emit('showDetailsBook', id);
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/book/list_book.scss';
</style>

