<template>
    <div>
        <el-dialog
            v-model="outerVisible"
            :title="`Thông tin lỗi`"
            append-to-body
            class="error-user-information-dialog"
        >
            <el-table
                v-if="errors.length"
                :data="errors"
                style="width: 100%"
            >
                <el-table-column
                    prop="row"
                    label="Dòng lỗi"
                    width="120"
                    align="center"
                />
                <el-table-column
                    prop="message"
                    label="Nội dung lỗi"
                    align="left"
                />
            </el-table>
            <template #footer>
                <div class="dialog-footer">
                    <el-button @click="outerVisible = false">
                        Đóng
                    </el-button>
                </div>
            </template>
        </el-dialog>
    </div>
</template>

<script setup>
import { ref, watch } from 'vue';

const props = defineProps({
    errors: {
        type: Object,
        default: () => { }
    }
});
const outerVisible = ref(false);

/**
 * The method watch book
 *
 * @returns {Promise<void>}
 */
watch(
    () => props.errors,
    (newErrors) => {
        if (newErrors?.length) {
            console.log(newErrors);
            outerVisible.value = true;
        }
    },
    { deep: true }
);
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/user/error_user_information.scss';
</style>
