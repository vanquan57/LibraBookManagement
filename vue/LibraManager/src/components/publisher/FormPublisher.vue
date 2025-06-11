<template>
    <div class="publisher-form-container">
        <el-form
            ref="publisherFormRef"
            :model="publisherForm"
            :rules="rules"
            label-width="auto"
            class="publisher-form"
            status-icon
        >
            <el-form-item
                class="publisher-form-item"
                label="Tên nhà xuất bản"
                prop="name"
            >
                <el-input v-model="publisherForm.name" />
            </el-form-item>
            <el-form-item
                class="publisher-form-item"
                label="Mô tả"
                prop="description"
            >
                <el-input
                    v-model="publisherForm.description"
                    type="textarea"
                    class="publisher-form-item__description"
                />
            </el-form-item>
            <el-form-item class="publisher-form-item">
                <el-button
                    type="primary"
                    class="publisher-form-button__submit"
                    @click="handleSubmit"
                >
                    {{ isEdit ? "Cập nhật" : "Tạo mới" }}
                </el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script setup>
import { reactive, ref, watch } from 'vue';
import { ElMessageBox } from 'element-plus';

const props = defineProps({
    isEdit: {
        type: Boolean,
        default: false
    },
    publisher: {
        type: Object,
        default: () => ({})
    }
});

const emit = defineEmits(['submit']);

const publisherForm = reactive({
    name: '',
    description: ''
});
const publisherFormRef = ref(null);

const rules = {
    name: [
        {
            required: true,
            message: 'Vui lòng nhập tên nhà xuất bản',
            trigger: 'blur'
        },
        {
            max: 100,
            message: 'Tên nhà xuất bản không được quá 100 ký tự',
            trigger: 'blur'
        },
        {
            type: 'string',
            message: 'Tên nhà xuất bản phải là chuỗi',
            trigger: 'blur'
        }
    ],
    description: [
        {
            required: true,
            message: 'Vui lòng nhập tên nhà xuất bản',
            trigger: 'blur'
        },
        {
            max: 255,
            message: 'Mô tả không được quá 255 ký tự',
            trigger: 'change'
        }
    ]
};

/**
 * Watch category props and set category form data
 *
 * @param {object} newCategory - The new category
 *
 * @returns {Promise<void>}
 */
watch(
    () => props.publisher,
    (newPublisher) => {
        if (newPublisher) {
            publisherForm.name = newPublisher.name || '';
            publisherForm.description = newPublisher.description || '';
        }
    },
    { immediate: true }
);

/**
 * Handle submit form publisher send emit to parent component
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async () => {
    const valid = await publisherFormRef.value.validate();

    if (valid) {
        emit('submit', publisherForm);
    }
};

</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/publisher/form_publisher.scss';
</style>
