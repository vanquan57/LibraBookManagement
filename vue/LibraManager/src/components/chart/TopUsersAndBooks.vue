<template>
    <div class="chart-container">
        <div class="dashboard-item">
            <h1>Top 10 người mượn sách nhiều nhất</h1>
            <Bar
                class="chart-left"
                :data="userChartData"
                :options="chartOptionsUser"
            />
        </div>
        <div class="dashboard-item">
            <h1>Top 10 sách được mượn nhiều nhất</h1>
            <Bar
                class="chart-right"
                :data="bookChartData"
                :options="chartOptions"
            />
        </div>
    </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { Bar } from 'vue-chartjs';
import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    BarElement,
    CategoryScale,
    LinearScale
} from 'chart.js';

ChartJS.register(
    Title,
    Tooltip,
    Legend,
    BarElement,
    CategoryScale,
    LinearScale
);

const props = defineProps({
    topUsers: {
        type: Array,
        required: true,
        default: () => []
    },

    topBooks: {
        type: Array,
        required: true,
        default: () => []
    }
});

const userChartData = computed(() => ({
    labels: props.topUsers.map((user) => user.name),
    datasets: [
        {
            label: 'Số lượt mượn',
            data: props.topUsers.map((user) => user.orders_count),
            backgroundColor: 'rgba(75, 192, 192, 0.5)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1,
            datalabels: {
                formatter: (value) => {
                    return '';
                }
            }
        }
    ]
}));

/**
 * Get data for chart
 *
 * @returns {Object}
 */
const bookChartData = computed(() => ({
    labels: props.topBooks.map((book) => book.name),
    datasets: [
        {
            label: 'Số lượt mượn',
            data: props.topBooks.map((book) => book.borrowing_number),
            backgroundColor: 'rgba(153, 102, 255, 0.5)',
            borderColor: 'rgba(153, 102, 255, 1)',
            borderWidth: 1,
            datalabels: {
                formatter: (value) => {
                    return '';
                }
            },
        }
    ]
}));

const chartOptions = {
    indexAxis: 'y',
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
        legend: { position: 'top' }
    },
    barPercentage: 0.8,
    categoryPercentage: 0.8,
    scales: {
        x: {
            ticks: {
                callback: function (value) {
                    return Number.isInteger(value) ? value : '';
                },
                stepSize: 500
            },
            beginAtZero: true
        },
        y: {
            ticks: {
                callback: function(value) {
                    const label = this.getLabelForValue(value);
                    const maxLength = 10;
                    return label.length > maxLength ? label.substring(0, maxLength) + '...' : label;
                }
            }
        }
    }
};


const chartOptionsUser = {
    indexAxis: 'y',
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
        legend: { position: 'top' }
    },
    barPercentage: 0.8,
    categoryPercentage: 0.8,
    scales: {
        x: {
            ticks: {
                callback: function (value) {
                    return Number.isInteger(value) ? value : '';
                },
                stepSize: 1
            },
            beginAtZero: true
        },
        y: {
            ticks: {
                callback: function(value) {
                    const label = this.getLabelForValue(value);
                    const maxLength = 10;

                    return label.length > maxLength ? label.substring(0, maxLength) + '...' : label;
                }
            }
        }
    }

};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/chart/user_book.scss';
</style>
