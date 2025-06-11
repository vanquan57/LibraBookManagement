<template>
    <div class="author-form-container">
        <el-form
            ref="authorFormRef"
            :model="authorForm"
            :rules="rules"
            label-width="auto"
            class="author-form"
            status-icon
        >
            <el-form-item
                class="author-form-item"
                label="Tên tác giả"
                prop="name"
            >
                <el-input v-model="authorForm.name" />
            </el-form-item>
            <el-form-item
                class="author-form-item"
                label="Mô tả"
                prop="description"
            >
                <el-input
                    v-model="authorForm.description"
                    type="textarea"
                    class="author-form-item__description"
                />
            </el-form-item>
            <el-form-item class="author-form-item">
                <el-button
                    type="primary"
                    class="author-form-button__submit"
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

const props = defineProps({
    isEdit: {
        type: Boolean,
        default: false
    },
    author: {
        type: Object,
        default: () => ({})
    }
});

const emit = defineEmits(['submit']);

const authorForm = reactive({
    name: '',
    description: ''
});
const authorFormRef = ref(null);

const rules = {
    name: [
        {
            required: true,
            message: 'Vui lòng nhập tên tác giả',
            trigger: 'blur'
        },
        {
            max: 100,
            message: 'Tên tác giả không được tối đa 100 ký tự',
            trigger: 'blur'
        },
        {
            type: 'string',
            message: 'Tên tác giả phải là chuỗi',
            trigger: 'blur'
        }
    ],
    description: [
        {
            required: true,
            message: 'Vui lòng nhập mô tả',
            trigger: 'blur'
        },
        {
            max: 255,
            message: 'Mô tả không được tối đa 255 ký tự',
            trigger: 'change'
        }
    ]
};

/**
 * Watch author props and set author form data
 *
 * @param {object} newAuthor - The new author
 *
 * @returns {Promise<void>}
 */
watch(
    () => props.author,
    (newAuthor) => {
        if (newAuthor) {
            authorForm.name = newAuthor.name || '';
            authorForm.description = newAuthor.description || '';
        }
    },
    { immediate: true }
);

/**
 * Handle submit form author send emit to parent component
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async () => {
    const valid = await authorFormRef.value.validate();

    if (valid) {
        emit('submit', authorForm);
    }
};

</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/author/form_author.scss';
</style>
