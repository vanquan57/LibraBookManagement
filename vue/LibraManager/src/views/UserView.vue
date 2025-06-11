<template>
    <div class="user-management-container">
        <div class="user-management-breadcrumb-container">
            <BreadcrumbComponent
                class="user-management-breadcrumb"
                :breadcrumb-list="breadcrumbList"
            />
            <router-link
                v-if="props.site === 'user'"
                class="btn-add-user"
                to="/user/information"
            >
                <el-button type="primary">
                    Import
                </el-button>
            </router-link>
        </div>
        <div
            v-if="props.site === 'user'"
            class="user-management-content"
        >
            <div class="user-management-top">
                <h1>Quản lý người dùng</h1>
                <div class="user-management-search">
                    <SearchComponent
                        placeholder="Nhập mã nhân viên, tên người dùng, email"
                        :style-input="styleInput"
                        :status-options-user="statusOptionsUser"
                        @search="handleSearch"
                    />
                </div>
            </div>
            <div class="user-management-content">
                <ListUsers
                    :table-data="tableData"
                    @handle-update-status="handleUpdateStatus"
                />
            </div>
            <div
                v-if="tableData.length > 0"
                class="user-management-pagination"
            >
                <PaginationComponent
                    class="user-management-pagination-left"
                    :total="dataPagination.total"
                    :current-page="dataPagination.currentPage"
                    :page-size="dataPagination.limit"
                    @current-page="handlePageChange"
                />
            </div>
        </div>
        <div
            v-else
            class="user-management-content"
        >
            <div class="user-management-top">
                <h1>Thêm thông tin người dùng</h1>
                <div class="user-management-upload">
                    <div class="user-management-upload-btn">
                        <el-button
                            class="ml-3"
                            type="primary"
                            @click="handleUpload"
                        >
                            Chọn file
                        </el-button>
                        <el-button
                            class="ml-3 btn-upload"
                            type="success"
                            :loading="loading"
                            @click="submitUpload"
                        >
                            Tải lên
                        </el-button>
                    </div>
                    <input
                        ref="fileInput"
                        type="file"
                        accept=".csv"
                        style="display: none"
                        @change="handleFileChange"
                    >
                    <p
                        v-if="fileName"
                        class="file-name"
                    >
                        <span>{{ fileName }} <span
                            class="remove-file"
                            @click="handleRemoveFile"
                        >x</span></span>
                    </p>
                </div>
            </div>
            <div class="user-management-content">
                <ListFormation :table-data="tableDataInfoEmployeeCodes" />
                <div class="user-management-pagination">
                    <PaginationComponent
                        class="user-management-pagination-left"
                        :total="dataPagination.total"
                        :current-page="dataPagination.currentPage"
                        :page-size="dataPagination.limit"
                        @current-page="handlePageChange"
                    />
                </div>
                <ErrorUserInformation :errors="errors" />
            </div>
        </div>
    </div>
</template>

<script setup>
import BreadcrumbComponent from '@/components/Breadcrumb/BreadcrumbComponent.vue';
import SearchComponent from '@/components/search/SearchComponent.vue';
import ListUsers from '@/components/user/ListUsers.vue';
import ListFormation from '@/components/user/ListFormation.vue';
import { onMounted, ref, watch, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import PaginationComponent from '@/components/pagination/PaginationComponent.vue';
import axiosInstance from '@/config/axios';
import { ElNotification } from 'element-plus';
import { useRouter } from 'vue-router';
import DEFAULT_CONSTANTS from '@/config/constants';
import { showNotificationError, showNotificationSuccess } from '@/helpers/notification';
import STATUS_USER from '@/config/statusUser';
import ErrorUserInformation from '@/components/user/ErrorUserInformation.vue';

const props = defineProps({
    site: {
        type: String,
        default: 'user'
    }
});
const breadcrumbList = ref([
    { name: 'Trang chủ', path: '/' },
    { name: 'Danh sách', path: '/user' }
]);
const fileUpload = ref();
const fileName = ref('');
const fileInput = ref();
const router = useRouter();
const route = useRoute();
const tableData = ref([]);
const tableDataInfoEmployeeCodes = ref([]);
const styleInput = ref('width: 400px');
const dataPagination = ref({
    limit: 10,
    total: 0,
    currentPage: 1
});
const loading = ref(false);
const keyWord = ref('');
const statusOptionsUser = ref([
    {
        label: 'Chờ kích hoạt',
        value: STATUS_USER.WAITING
    },
    {
        label: 'Đã kích hoạt',
        value: STATUS_USER.ACTIVATED
    },
    {
        label: 'Đã khóa',
        value: STATUS_USER.LOCKED
    }
]);
const errors = ref([]);

onMounted(async () => {
    if (props.site === 'user') {
        await getUsers();
    } else {
        await getInformationEmployeeCodes();
    }
});

watch(
    () => props.site,
    async (newSite) => {
        if (newSite === 'information') {
            await getInformationEmployeeCodes();
            breadcrumbList.value = [
                { name: 'Trang chủ', path: '/' },
                { name: 'Danh sách', path: '/user' },
                { name: 'Thêm thông tin', path: '/user/information' }
            ];
        } else {
            await getUsers();
            breadcrumbList.value = [
                { name: 'Trang chủ', path: '/' },
                { name: 'Người dùng', path: '/user' }
            ];
        }
    }
);
/**
 * The method get data users
 *
 * @param {number} page - The page number
 *
 * @returns {Promise<void>}
 */
const getUsers = async (page = 1, column = null, order = null, keyWord = null, status = null) => {
    try {
        const response = await axiosInstance.get('/user', {
            params: {
                key_word: keyWord,
                limit: dataPagination.value.limit,
                page: page,
                column: column ?? DEFAULT_CONSTANTS.COLUMN,
                order: order ?? DEFAULT_CONSTANTS.ORDER,
                status
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

const getInformationEmployeeCodes = async (page = 1) => {

    const response = await axiosInstance.get('/employees', {
        params: {
            page: page
        }
    });
    if (response.success) {
        tableDataInfoEmployeeCodes.value = response.data.data;
        dataPagination.value.total = response.data.total;
        dataPagination.value.currentPage = response.data.current_page;
    }
};

watchEffect(() => {
    if (route.fullPath === '/user') {
        getUsers();
    }
});

/**
 * The method handle search
 *
 * @param {string} search - The search
 *
 * @returns {Promise<void>}
 */
const handleSearch = async ({ search, status }) => {
    const query = search === '' ? {} : { search: search.trim() };

    router.push({
        path: route.path,
        query
    });

    if (search !== '') {
        keyWord.value = search.trim();

        await getUsers(dataPagination.value.currentPage, null, null, keyWord.value, status);
    } else {
        keyWord.value = '';

        await getUsers();
    }
};

/**
 * The method handle update status
 *
 * @param {number} id - The id of user
 * @param {number} status - The status of user
 *
 * @returns {Promise<void>}
 */
const handleUpdateStatus = async (id, status) => {
    try {
        const response = await axiosInstance.put(`/user/${id}`, { status });

        if (response.success) {
            showNotificationSuccess(response.data.message);

            if (keyWord.value !== '') {
                await getUsers(dataPagination.value.currentPage, null, null, keyWord.value);
            } else {
                await getUsers(dataPagination.value.currentPage);
            }
        }
    } catch (error) {
        showNotificationError(error);
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
    if (props.site === 'user') {
        dataPagination.value.currentPage = page;
        getUsers(page);
    } else {
        dataPagination.value.currentPage = page;
        getInformationEmployeeCodes(page);
    }
};

const handleUpload = () => {
    fileInput.value.click();
};

const handleRemoveFile = () => {
    fileName.value = '';
    fileUpload.value = '';
    fileInput.value.value = '';
};

const handleFileChange = (event) => {
    const file = event.target.files[0];
    fileUpload.value = file;

    if (file && file.type !== 'text/csv' && !file.name.endsWith('.csv')) {
        ElNotification({
            title: 'Thất bại',
            message: 'File không đúng định dạng',
            type: 'error'
        });
        fileUpload.value = '';
        return;
    } else {
        fileName.value = fileUpload.value.name;
    }
};

const submitUpload = async () => {
    try {
        if (!fileUpload.value) {
            return;
        }

        const formData = new FormData();
        formData.append('file', fileUpload.value);
        const response = await axiosInstance.post('employees', formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
        if (response.success) {
            showNotificationSuccess(response.data.message);

            await getInformationEmployeeCodes(dataPagination.value.currentPage);
            fileUpload.value = '';
            fileName.value = '';
            fileInput.value.value = '';
        }
    } catch (error) {
        loading.value = false;

        errors.value = error.data.data;
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/user_view.scss';
</style>
