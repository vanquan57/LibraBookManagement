<template>
    <div class="example-pagination-block">
        <el-pagination
            :current-page="currentPage"
            :page-size="props.pageSize"
            :total="props.total"
            layout="prev, pager, next"
            @current-change="handlePageChange"
        />
    </div>
</template>

<script setup>
const props = defineProps({
    total: {
        type: Number,
        default: 0
    },
    pageSize: {
        type: Number,
        default: 24
    },
    currentPage: {
        type: Number,
        default: 1
    }
});

const emit = defineEmits(['currentPage']);

const handlePageChange = (page) => {
    emit('currentPage', page);
};
</script>

<style lang="scss" scoped></style>
