
<template>
    <div>
        <Pie
            :data="pieChartData"
            :options="chartOptions"
        />
    </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import { Pie } from 'vue-chartjs';
import ChartDataLabels from 'chartjs-plugin-datalabels';

import {
    Chart as ChartJS, ArcElement, Tooltip, Legend
} from 'chart.js';

ChartJS.register(ArcElement, Tooltip, Legend, ChartDataLabels);

const props = defineProps({
    pieChartData: {
        type: Array,
        required: true,
        default: () => []
    }
});

/**
 * Generate random colors
 *
 * @param {number} count - The number of colors to generate
 * @returns {Array} An array of random colors
*/
function generateRandomColors(count) {
    return Array.from({ length: count }, () => {
        const r = Math.floor(Math.random() * 255);
        const g = Math.floor(Math.random() * 255);
        const b = Math.floor(Math.random() * 255);
        return `rgba(${r}, ${g}, ${b}, 0.2)`;
    });
}

/**
 * Get data for chart
 *
 * @returns {Object}
*/
const pieChartData = computed(() => {
    const colors = generateRandomColors(props.pieChartData.length);

    return {
        labels: props.pieChartData.map((item) => item.name),
        datasets: [
            {
                label: 'Số lượng sách',
                data: props.pieChartData.map((item) => item.books_count),
                backgroundColor: colors
            }
        ]
    };
});


const chartOptions = {
    responsive: true,
    plugins: {
        legend: { position: 'top' },
        datalabels: {
            formatter: (value) => {
                if (value === 0) {
                    return '';
                }
                return value;
            }
        }
    },
    barPercentage: 0.8,
    categoryPercentage: 0.8
};
</script>


<style scoped>
</style>
