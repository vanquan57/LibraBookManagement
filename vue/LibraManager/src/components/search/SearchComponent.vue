<template>
    <div class="search-form-container">
        <el-form
            ref="searchFormRef"
            :model="searchForm"
            class="search-form"
            :style="`grid-template-columns: ${styleSearch}; display: ${displaySearch}`"
            @submit.prevent="handleSearch"
        >
            <el-form-item
                prop="search"
            >
                <el-input
                    :style="styleInput"
                    v-model="searchForm.search"
                    :placeholder="props.placeholder"
                />
            </el-form-item>
            <el-form-item
                v-if="props.statusOptionsUser.length > 0"
                prop="status"
            >
                <el-select
                    v-model="searchForm.status"
                    :placeholder="`Chọn trạng thái`"
                    :options="props.statusOptionsUser"
                >
                    <el-option
                        v-for="item in props.statusOptionsUser"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value"
                    />
                </el-select>
            </el-form-item>
            <el-form-item v-if="props.isSearchBook">
                <el-select
                    v-model="searchForm.category_id"
                    placeholder="Chọn danh mục"
                >
                    <el-option
                        v-for="item in props.categoryData"
                        :key="item.id"
                        :label="item.name"
                        :value="item.id"
                    />
                </el-select>
            </el-form-item>
            <el-form-item v-if="props.isSearchBook">
                <el-select
                    v-model="searchForm.author_id"
                    placeholder="Chọn tác giả"
                >
                    <el-option
                        v-for="item in props.authorData"
                        :key="item.id"
                        :label="item.name"
                        :value="item.id"
                    />
                </el-select>
            </el-form-item>
            <el-form-item v-if="props.isSearchBook">
                <el-select
                    v-model="searchForm.publisher_id"
                    placeholder="Chọn nhà xuất bản"
                >
                    <el-option
                        v-for="item in props.publisherData"
                        :key="item.id"
                        :label="item.name"
                        :value="item.id"
                    />
                </el-select>
            </el-form-item>
            <el-form-item
                v-if="props.isHasDate"
                prop="dateRange"
            >
                <el-date-picker
                    v-model="searchForm.startDate"
                    type="date"
                    :placeholder="`Chọn ngày bắt đầu`"
                    format="DD/MM/YYYY"
                    value-format="YYYY-MM-DD"
                />
            </el-form-item>
            <el-form-item
                v-if="props.isHasDate"
                prop="dateRange"
            >
                <el-date-picker
                    v-model="searchForm.endDate"
                    type="date"
                    :placeholder="`Chọn ngày kết thúc`"
                    format="DD/MM/YYYY"
                    value-format="YYYY-MM-DD"
                />
            </el-form-item>
            <el-form-item
                v-if="props.statusOptions.length > 0"
                prop="status"
            >
                <el-select
                    v-model="searchForm.status"
                    :placeholder="`Chọn trạng thái`"
                    :options="props.statusOptions"
                >
                    <el-option
                        v-for="item in props.statusOptions"
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
            <el-form-item
                v-if="props.isReset"
                justify="center"
            >
                <el-button
                    type="primary"
                    class="search-button"
                    @click="handleReset"
                >
                    Reset
                </el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script setup>
import { ref, watchEffect } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const displaySearch = ref('flex');
const props = defineProps({
    placeholder: {
        type: String,
        default: 'Nhập nội dung tìm kiếm ...'
    },
    styleInput: {
        type: String,
        default: ''
    },
    isSearchBook: {
        type: Boolean,
        default: false
    },
    categoryData: {
        type: Array,
        default: () => []
    },
    authorData: {
        type: Array,
        default: () => []
    },
    publisherData: {
        type: Array,
        default: () => []
    },
    isHasDate: {
        type: Boolean,
        default: false
    },
    statusOptions: {
        type: Array,
        default: () => []
    },
    statusOptionsUser: {
        type: Array,
        default: () => []
    },
    isReset: {
        type: Boolean,
        default: false
    }
});
const styleSearch = ref('');

const emit = defineEmits(['search']);
const searchFormRef = ref(null);
const searchForm = ref({
    search: '',
    category_id: '',
    author_id: '',
    publisher_id: '',
    book_id: '',
    startDate: '',
    endDate: '',
    status: ''
});

watchEffect(() => {
    if (route.path === '/book') {
        styleSearch.value = '3fr 2fr 2fr 2fr 1fr 1fr';
        displaySearch.value = 'grid';
    } else if (route.path === '/order') {
        styleSearch.value = '3fr 2fr 2fr 2fr 1fr';
        displaySearch.value = 'grid';
    } else if (route.path === '/feedback') {
        styleSearch.value = '4fr 2fr 2fr 1fr';
        displaySearch.value = 'grid';
    } else if (route.path === '/user') {
        styleSearch.value = '3fr 2fr 1fr';
        displaySearch.value = 'grid';
    } else {
        styleSearch.value = '7fr 3fr';
    }
});


const handleSearch = async () => {
    await searchFormRef.value.validate((valid) => {
        if (valid) {
            if (props.isSearchBook) {
                emit('search', {
                    search: searchForm.value.search,
                    category_id: searchForm.value.category_id,
                    author_id: searchForm.value.author_id,
                    publisher_id: searchForm.value.publisher_id
                });
            } else if (route.path === '/order') {
                delete searchForm.value.category_id;
                delete searchForm.value.author_id;
                delete searchForm.value.publisher_id;
                delete searchForm.value.book_id;
                emit('search', searchForm.value);
            } else if (route.path === '/feedback') {
                delete searchForm.value.category_id;
                delete searchForm.value.author_id;
                delete searchForm.value.publisher_id;
                delete searchForm.value.status;
                emit('search', searchForm.value);
            } else if (route.path === '/user') {
                delete searchForm.value.category_id;
                delete searchForm.value.author_id;
                delete searchForm.value.publisher_id;
                emit('search', searchForm.value);
            } else {
                emit('search', searchForm.value.search);
            }
        }
    });
};

const handleReset = () => {
    searchForm.value = {
        search: '',
        category_id: '',
        author_id: '',
        publisher_id: ''
    };
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/search/form_search.scss';
</style>
