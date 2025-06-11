<template>
    <div class="book-form-container">
        <el-form
            ref="bookFormRef"
            :model="bookForm"
            :rules="rules"
            label-width="auto"
            class="book-form"
        >
            <el-row :gutter="24">
                <el-col :span="12">
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Tên sách"
                        prop="name"
                    >
                        <el-input
                            v-model="bookForm.name"
                            placeholder="Nhập tên sách"
                        />
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Tác giả"
                        prop="author_id"
                    >
                        <el-select
                            v-model="bookForm.author_id"
                            placeholder="Chọn tác giả"
                            filterable
                            allow-create
                            :reserve-keyword="false"
                        >
                            <el-option
                                v-for="item in props.authorData"
                                :key="item.id"
                                :label="item.name"
                                :value="item.id"
                            />
                        </el-select>
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Nhà xuất bản"
                        prop="publisher_id"
                    >
                        <el-select
                            v-model="bookForm.publisher_id"
                            placeholder="Chọn nhà xuất bản"
                            filterable
                            allow-create
                            :reserve-keyword="false"
                        >
                            <el-option
                                v-for="item in props.publisherData"
                                :key="item.id"
                                :label="item.name"
                                :value="item.id"
                            />
                        </el-select>
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Danh mục"
                        prop="category_id"
                    >
                        <el-select
                            v-model="bookForm.category_id"
                            placeholder="Chọn danh mục"
                            filterable
                            allow-create
                            :reserve-keyword="false"
                        >
                            <el-option
                                v-for="item in props.categoryData"
                                :key="item.id"
                                :label="item.name"
                                :value="item.id"
                            />
                        </el-select>
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Hình ảnh"
                        prop="image"
                    >
                        <input
                            class="input-image"
                            type="file"
                            accept="image/*"
                            :class="{
                                'error-input': errorUploadFile.image.status,
                            }"
                            @change="(e) => handleChangeImage(e, 'image')"
                            @focus="errorUploadFile.image.status = false"
                        >
                        <div
                            v-if="errorUploadFile.image.status"
                            class="error-message"
                        >
                            {{ errorUploadFile.image.message }}
                        </div>
                        <div v-if="fakeImage">
                            <img
                                :src="fakeImage"
                                class="image-preview"
                            >
                        </div>
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Ngày xuất bản"
                        prop="publication_date"
                    >
                        <el-date-picker
                            v-model="bookForm.publication_date"
                            type="date"
                            placeholder="Chọn ngày xuất bản"
                            format="DD/MM/YYYY"
                            value-format="YYYY-MM-DD"
                        />
                    </el-form-item>
                    <div class="input-group">
                        <el-form-item
                            label-position="top"
                            class="form-item"
                            label="Số lượng"
                            prop="quantity"
                        >
                            <el-input-number
                                v-model="bookForm.quantity"
                                :min="1"
                                :step="1"
                                placeholder="Nhập số lượng"
                            />
                        </el-form-item>
                        <el-form-item
                            label-position="top"
                            class="form-item"
                            label="Số trang"
                            prop="page"
                        >
                            <el-input-number
                                v-model="bookForm.page"
                                :min="1"
                                :step="1"
                                placeholder="Nhập số trang"
                            />
                        </el-form-item>
                    </div>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Kích thước"
                        prop="size"
                    >
                        <el-input
                            v-model="bookForm.size"
                            placeholder="Nhập kích thước"
                        />
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Loại bìa"
                        prop="cover_type"
                    >
                        <el-radio-group v-model="bookForm.cover_type">
                            <el-radio value="1">
                                Bìa cứng
                            </el-radio>
                            <el-radio value="2">
                                Bìa mềm
                            </el-radio>
                        </el-radio-group>
                    </el-form-item>
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Hình ảnh thumbnail (Tối đa 4 hình ảnh)"
                        prop="images"
                    >
                        <input
                            type="file"
                            accept="image/*"
                            class="input-image"
                            multiple
                            :class="{
                                'error-input': errorUploadFile.images.status,
                            }"
                            @change="(e) => handleChangeImage(e, 'images')"
                            @focus="errorUploadFile.images.status = false"
                        >
                        <div
                            v-if="errorUploadFile.images.status"
                            class="error-message"
                        >
                            {{ errorUploadFile.images.message }}
                        </div>
                    </el-form-item>
                    <div
                        v-if="fakeImages.length > 0"
                        class="thumbnail-container"
                    >
                        <div
                            v-for="image in fakeImages"
                            :key="image.id"
                            class="thumbnail-item-container"
                        >
                            <IconRemove
                                class="icon-remove"
                                @click="handleRemoveImage(image.id)"
                            />
                            <img
                                :src="image.url"
                                class="thumbnail-item"
                            >
                        </div>
                    </div>
                </el-col>
                <el-col :span="24">
                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Mô tả ngắn"
                        prop="mini_description"
                    >
                        <CkEditorComponent
                            v-model="bookForm.mini_description"
                            :data="bookForm.mini_description"
                            :is-edit="props.isEdit"
                        />
                        <div
                            v-if="errorUploadFile.mini_description.status"
                            class="error-message"
                        >
                            {{ errorUploadFile.mini_description.message }}
                        </div>
                    </el-form-item>

                    <el-form-item
                        label-position="top"
                        class="form-item"
                        label="Mô tả chi tiết"
                        prop="details_description"
                    >
                        <CkEditorComponent
                            v-model="bookForm.details_description"
                            :data="bookForm.details_description"
                            :is-edit="props.isEdit"
                        />
                        <div
                            v-if="errorUploadFile.details_description.status"
                            class="error-message"
                        >
                            {{ errorUploadFile.details_description.message }}
                        </div>
                    </el-form-item>
                </el-col>
            </el-row>

            <el-form-item
                label-position="top"
                class="form-item"
            >
                <el-button
                    type="primary"
                    class="submit-button"
                    @click="handleSubmit"
                >
                    {{ props.isEdit ? "Cập nhật" : "Thêm" }}
                </el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script setup>
import { ref, watch, watchEffect } from 'vue';
import CkEditorComponent from '../ckeditor/CkEditorComponent.vue';
import axiosInstance from '@/config/axios';
import { ElNotification } from 'element-plus';
import HTTP_STATUS_CODE from '@/config/statusCode';
import IconRemove from '@/components/icons/IconRemove.vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const props = defineProps({
    isEdit: {
        type: Boolean,
        default: false
    },
    id: {
        type: Number,
        default: 0
    },
    authorData: {
        type: Array,
        default: () => []
    },
    publisherData: {
        type: Array,
        default: () => []
    },
    categoryData: {
        type: Array,
        default: () => []
    }
});

const emit = defineEmits(['submit']);

const errorUploadFile = ref({
    images: {
        status: false,
        message: ''
    },
    image: {
        status: false,
        message: ''
    },
    mini_description: {
        status: false,
        message: ''
    },
    details_description: {
        status: false,
        message: ''
    },
    isEdit: {
        type: Boolean,
        default: false
    }
});

const bookFormRef = ref(null);

const bookForm = ref({
    name: '',
    author_id: null,
    publisher_id: null,
    category_id: null,
    mini_description: '',
    details_description: '',
    publication_date: '',
    quantity: 0,
    size: '',
    page: 0,
    cover_type: 0,
    image: '',
    images: []
});

const rules = {
    name: [
        {
            required: true,
            message: 'Vui lòng nhập tên sách',
            trigger: 'blur'
        },
        {
            max: 255,
            message: 'Tên sách không được quá 255 ký tự',
            trigger: 'blur'
        },
        {
            type: 'string',
            message: 'Tên sách phải là chuỗi',
            trigger: 'blur'
        }
    ],
    author_id: [
        {
            required: true,
            message: 'Vui lòng chọn tác giả',
            trigger: 'change'
        }
    ],
    publisher_id: [
        {
            required: true,
            message: 'Vui lòng chọn nhà xuất bản',
            trigger: 'change'
        }
    ],
    category_id: [
        {
            required: true,
            message: 'Vui lòng chọn danh mục',
            trigger: 'change'
        }
    ],
    publication_date: [
        {
            required: true,
            message: 'Vui lòng chọn ngày xuất bản',
            trigger: 'blur'
        },
        {
            validator: (rule, value, callback) => {
                const selectedDate = new Date(value);
                const currentDate = new Date();

                currentDate.setHours(0, 0, 0, 0);

                if (selectedDate > currentDate) {
                    callback(new Error('Ngày xuất bản không hợp lệ!'));
                } else {
                    callback();
                }
            },
            trigger: 'change'
        }
    ],
    image: [
        {
            required: !props.isEdit,
            message: ''
        }
    ],
    images: [
        {
            required: !props.isEdit,
            message: ''
        }
    ],
    mini_description: [
        {
            required: true,
            message: ''
        }
    ],
    details_description: [
        {
            required: true,
            message: ''
        }
    ]
};

const fakeImages = ref([]);
const fakeImage = ref(null);
const idImagesDelete = ref([]);

const imageUrl = (url) => {
    return import.meta.env.VITE_STORAGE_URL + url;
};

/**
 * The method handle change image
 *
 * @param {Event} e - The event
 * @param {string} type - The type
 *
 * @returns {Promise<void>}
 */
const handleChangeImage = (e, type) => {

    if (type === 'image') {
        const file = e.target.files[0];
        bookForm.value.image = file;
        fakeImage.value = URL.createObjectURL(file);

        if (file && !file.type.startsWith('image/')) {
            ElNotification.error('Vui lòng chọn một tệp hình ảnh!');
            e.target.value = '';

            return;
        }
    }


    if (type === 'images') {
        const files = e.target.files;

        if (files.length + fakeImages.value.length > 4) {
            errorUploadFile.value.images.status = true;
            errorUploadFile.value.images.message =
                'Chỉ được chọn tối đa 4 hình ảnh';
            e.target.value = '';
            return;
        }

        const newFiles = Array.from(files).filter((file) => {
            if (!file.type.startsWith('image/')) {
                ElNotification.error(`Tệp "${file.name}" không phải là hình ảnh!`);
                return false;
            }
            return true;
        });

        errorUploadFile.value.images.status = false;
        errorUploadFile.value.images.message = '';

        newFiles.forEach((file) => {
            const newId =
                fakeImages.value.length > 0
                    ? Math.max(...fakeImages.value.map((img) => img.id)) + 1
                    : 1;

            fakeImages.value.push({
                id: newId,
                name: file.name,
                url: URL.createObjectURL(file)
            });

            if (route.name === 'book.edit' && idImagesDelete.value.length > 0) {
                bookForm.value.images.push({
                    id: idImagesDelete.value.pop(),
                    file,
                });
            } else {
                bookForm.value.images.push({
                    id: newId,
                    file,
                });
            }
        });
    }
};

/**
 * The method watch data in book form using for description ckeditor
 *
 * @returns {Promise<void>}
 */
watchEffect(async () => {
    if (bookForm.value.mini_description) {
        errorUploadFile.value.mini_description.status = false;
        errorUploadFile.value.mini_description.message = '';
        bookForm.value.mini_description = bookForm.value.mini_description;
    }
    if (bookForm.value.details_description) {
        errorUploadFile.value.details_description.status = false;
        errorUploadFile.value.details_description.message = '';
        bookForm.value.details_description = bookForm.value.details_description;
    }

    if (bookForm.value?.mini_description?.length > 255) {
        errorUploadFile.value.mini_description.status = true;
        errorUploadFile.value.mini_description.message =
            'Mô tả ngắn phải không được quá 255 ký tự';
    }
});

/**
 * The method watch id update data using form book update
 *
 * @returns {Promise<void>}
 */
watch(
    () => props.id,
    async (newVal) => {
        if (newVal) {
            const response = await axiosInstance.get(`/book/${newVal}`);

            if (response.success) {
                const book = response.data;
                bookForm.value.name = book.name;
                bookForm.value.author_id = book.author_id;
                bookForm.value.publisher_id = book.publisher_id;
                bookForm.value.category_id = book.categories[0].id;
                bookForm.value.mini_description = book.mini_description;
                bookForm.value.details_description = book.details_description;
                bookForm.value.publication_date = book.publication_date;
                bookForm.value.quantity = book.quantity;
                bookForm.value.size = book.size;
                bookForm.value.page = book.page;
                bookForm.value.cover_type = String(book.cover_type);
                fakeImage.value = imageUrl(book.image);
                fakeImages.value = book.images.map((image) => ({
                    id: image.id,
                    name: image.name,
                    url: imageUrl(image.url)
                }));
            }
        }
    },
    { immediate: true }
);

/**
 * The method handle submit form book
 *
 * @returns {Promise<void>}
 */
const handleSubmit = async () => {
    await bookFormRef.value.validate((valid) => {
        if (route.name === 'book.edit') {
            if (!bookForm.value.mini_description) {
                errorUploadFile.value.mini_description.status = true;
                errorUploadFile.value.mini_description.message =
                    'Vui lòng nhập mô tả ngắn';
            }
            if (!bookForm.value.details_description) {
                errorUploadFile.value.details_description.status = true;
                errorUploadFile.value.details_description.message =
                    'Vui lòng nhập mô tả chi tiết';
            }
            if (
                valid &&
                !errorUploadFile.value.mini_description.status &&
                !errorUploadFile.value.details_description.status
            ) {
                emit('submit', bookForm.value);
            }
        } else {
            if (!bookForm.value.image) {
                errorUploadFile.value.image.status = true;
                errorUploadFile.value.image.message = 'Vui lòng chọn hình ảnh';
            }
            if (
                bookForm.value.images.length === 0 ||
                bookForm.value.images.length !== 4
            ) {
                errorUploadFile.value.images.status = true;
                errorUploadFile.value.images.message =
                    'Vui lòng chọn 4 hình ảnh';
            }
            if (!bookForm.value.mini_description) {
                errorUploadFile.value.mini_description.status = true;
                errorUploadFile.value.mini_description.message =
                    'Vui lòng nhập mô tả ngắn';
            }
            if (!bookForm.value.details_description) {
                errorUploadFile.value.details_description.status = true;
                errorUploadFile.value.details_description.message =
                    'Vui lòng nhập mô tả chi tiết';
            }

            if (
                valid &&
                !errorUploadFile.value.images.status &&
                !errorUploadFile.value.image.status &&
                !errorUploadFile.value.mini_description.status &&
                !errorUploadFile.value.details_description.status
            ) {
                emit('submit', bookForm.value);
            }
        }
    });
};

const handleRemoveImage = (id) => {
    if (route.name === 'book.edit') {
        idImagesDelete.value.push(id);
        bookForm.value.images = bookForm.value.images.filter(
            (image) => image.id !== id
        );
    }

    fakeImages.value = fakeImages.value.filter((image) => image.id !== id);

    if (route.name !== 'book.edit') {
        bookForm.value.images = bookForm.value.images.filter(
            (image) => image.id !== id
        );
    }
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/book/form_book.scss';
</style>
