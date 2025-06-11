<template>
    <div class="dashboard-container">
        <TopUserAndBook
            :top-users="topUsers"
            :top-books="topBooks"
        />
        <div class="dashboard-container__month__category">
            <div class="dashboard-item dashboard-item__month">
                <h1>Số lượng đơn mượn theo từng tháng</h1>
                <TotalOrdersByMonth :total-orders-by-month="totalOrdersByMonth" />
            </div>
            <div class="dashboard-item dashboard-item__category">
                <h1>Tổng số lượng sách trong mỗi loại danh mục</h1>
                <TotalBookInCategory
                    :pie-chart-data="pieChartData"
                    class="pie-chart-container"
                />
            </div>
        </div>
        <div class="dashboard-item">
            <h1>Sách được yêu thích nhiều nhất</h1>
            <TopMostPopularBooks :top-most-popular-books="topMostPopularBooks" />
        </div>
    </div>
</template>

<script setup>
import TopUserAndBook from '@/components/chart/TopUsersAndBooks.vue';
import TotalBookInCategory from '@/components/chart/TotalBooksInCategories.vue';
import TotalOrdersByMonth from '@/components/chart/TotalOrdersByMonth.vue';
import TopMostPopularBooks from '@/components/chart/TopMostPopularBooks.vue';
import { onMounted } from 'vue';
import axios from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';
import { ref } from 'vue';

const topUsers = ref([]);
const topBooks = ref([]);
const pieChartData = ref([]);
const totalOrdersByMonth = ref([]);
const topMostPopularBooks = ref([]);

/**
 * Get data from API and render to the page
 *
 * @returns {Promise<void>}
*/
onMounted(async () => {
    await getDataDashboard();
});

/**
 * Get data admin dashboard
 *
 * @returns {Promise<void>}
*/
const getDataDashboard = async () => {
    try {
        const response = await axios.get('dashboard');

        if (response.success) {
            topUsers.value = response.data.topUsers;
            topBooks.value = response.data.topBooks;
            pieChartData.value = response.data.totalBooksInCategories;
            totalOrdersByMonth.value = response.data.totalOrders;
            topMostPopularBooks.value = response.data.topMostLikesBook;
        }
    } catch (error) {}
};

</script>

<style lang="scss" scoped>
@import '@/assets/scss/views/home_view.scss';
</style>
