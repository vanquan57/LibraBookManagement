
<template>
    <div class="dashboard-item__month">
        <Bar
            :data="orderByMonthData"
            :options="chartOptions"
        />
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

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

const props = defineProps({
    totalOrdersByMonth: {
        type: Array,
        required: true,
        default: () => []
    }
});

/**
 * Get data for chart
 *
 * @returns {Object}
*/
const orderByMonthData = computed(() => ({
    labels: props.totalOrdersByMonth.map((item) => item.month_year),
    datasets: [
        {
            label: 'Số lượng mượn',
            data: props.totalOrdersByMonth.map((item) => item.total_orders),
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


const chartOptions = {
    responsive: true,
    plugins: {
        legend: { position: 'top' }
    },
    barPercentage: 0.8,
    categoryPercentage: 0.8
};
</script>


<style lang="scss" scoped>
@import '@/assets/scss/components/chart/order.scss';
</style>

