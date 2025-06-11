<template>
    <div class="category-form-container">
        <el-form
            ref="categoryFormRef"
            :model="categoryForm"
            :rules="rules"
            label-width="auto"
            class="category-form"
            status-icon
        >
            <el-form-item
                class="category-form-item"
                label="Tên danh mục"
                prop="name"
            >
                <el-input v-model="categoryForm.name" />
            </el-form-item>
            <el-form-item
                class="category-form-item"
                label="Mô tả"
                prop="description"
            >
                <el-input
                    v-model="categoryForm.description"
                    type="textarea"
                    class="category-form-item__description"
                />
            </el-form-item>
            <el-form-item class="category-form-item">
                <el-button
                    type="primary"
                    class="category-form-button__submit"
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
    category: {
        type: Object,
        default: () => ({})
    }
});

const emit = defineEmits(['submit']);

const categoryForm = reactive({
    name: '',
    description: ''
});
const categoryFormRef = ref(null);

const rules = {
    name: [
        {
            required: true,
            message: 'Vui lòng nhập tên danh mục',
            trigger: 'blur'
        },
        {
            max: 100,
            message: 'Tên danh mục không được quá 100 ký tự',
            trigger: 'blur'
        },
        {
            type: 'string',
            message: 'Tên danh mục phải là chuỗi',
            trigger: 'blur'
        }
    ],
    description: [
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
    () => props.category,
    (newCategory) => {
        if (newCategory) {
            categoryForm.name = newCategory.name || '';
            categoryForm.description = newCategory.description || '';
        }
    },
    { immediate: true }
);

/**
 * Handle submit form category send emit to parent component
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async () => {
    const valid = await categoryFormRef.value.validate();

    if (valid) {
        if (categoryForm.description === '') {
            try {
                emit('submit', categoryForm);
            } catch (error) {}
        } else {
            emit('submit', categoryForm);
        }
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/category/form_category.scss';
</style>
