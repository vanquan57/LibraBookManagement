<template>
    <div>
        <Line
            :data="orderByMonthData"
            :options="chartOptions"
        />
    </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { Line } from 'vue-chartjs';
import {
    Chart as ChartJS,
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
} from 'chart.js';

ChartJS.register(
    CategoryScale,
    LinearScale,
    PointElement,
    LineElement,
    Title,
    Tooltip,
    Legend
);

const props = defineProps({
    topMostPopularBooks: {
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
    labels: props.topMostPopularBooks.map((item) => item.name),
    datasets: [
        {
            label: 'Số lượt yêu thích',
            data: props.topMostPopularBooks.map(
                (item) => item.wish_lists_count
            ),
            datalabels: {
                formatter: (value) => {
                    return '';
                }
            },
            backgroundColor: '#f87979',
            borderColor: '#f87979'
        }
    ]
}));

const chartOptions = {
    responsive: true,
    plugins: {
        legend: { position: 'top' }
    },
    scales: {
        y: {
            ticks: {
                callback: function (value) {
                    return Number.isInteger(value) ? value : '';
                },
                stepSize: 1
            },
            beginAtZero: true
        },
        x: {
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

<style scoped></style>
