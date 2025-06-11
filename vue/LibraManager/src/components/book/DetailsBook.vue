<template>
    <div>
        <el-dialog
            v-model="outerVisible"
            :title="`Chi tiết sách: ${props.book.name}`"
            append-to-body
            class="book-detail-dialog"
        >
            <div class="book-content">
                <div class="book-images">
                    <div class="main-image">
                        <img
                            :src="mainImage"
                            :alt="props.book.name"
                        >
                    </div>
                    <div class="image-gallery">
                        <img
                            v-for="image in props.book.images"
                            :key="image.id"
                            :src="urlImage(image.url)"
                            :alt="props.book.name"
                            class="thumbnail"
                            @click="handleClickImage(image.url)"
                        >
                    </div>
                </div>

                <div class="book-info">
                    <h2>{{ props.book.name }}</h2>
                    <div class="info-row">
                        <span class="label">Tác giả:</span>
                        <span>{{ props.book.author.name }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Nhà xuất bản:</span>
                        <span>{{ props.book.publisher.name }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Thể loại:</span>
                        <span>{{
                            props.book.categories
                                .map((cat) => cat.name)
                                .join(", ")
                        }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Ngày xuất bản:</span>
                        <span>{{
                            new Date(
                                props.book.publication_date
                            ).toLocaleDateString("vi-VN")
                        }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Số trang:</span>
                        <span>{{ props.book.page }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Kích thước:</span>
                        <span>{{ props.book.size }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Số lượng:</span>
                        <span>{{ props.book.quantity }}</span>
                    </div>
                    <div class="info-row">
                        <span class="label">Loại bìa:</span>
                        <span>{{ coverType.find(item => item.id === props.book.cover_type)?.label }}</span>
                    </div>
                    <div class="stats">
                        <div class="stat-item">
                            <span class="stat-label">Lượt xem</span>
                            <span class="stat-value">{{
                                props.book.views
                            }}</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-label">Lượt mượn</span>
                            <span class="stat-value">{{
                                props.book.borrowing_number
                            }}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="description-section">
                <h3>Mô tả ngắn</h3>
                <p
                    class="text-description"
                    v-html="props.book.mini_description"
                />

                <h3>Mô tả chi tiết</h3>
                <p
                    class="text-description"
                    v-html="props.book.details_description"
                />
            </div>

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
import COVER_TYPE from '@/config/coverType';
const props = defineProps({
    book: {
        type: Object,
        default: () => {}
    }
});

const outerVisible = ref(false);
const mainImage = ref('');
const coverType = Array.from(COVER_TYPE);


/**
 * The method get url image
 *
 * @param {string} url - The url
 *
 * @returns {string}
 */
const urlImage = (url) => {
    return import.meta.env.VITE_STORAGE_URL + url;
};

/**
 * The method watch book
 *
 * @returns {Promise<void>}
 */
watch(
    () => props.book,
    (newBook) => {
        if (newBook) {
            outerVisible.value = true;
            mainImage.value = urlImage(props.book.image);
        }
    }
);

/**
 * The method handle click image
 *
 * @param {string} url - The url
 *
 * @returns {Promise<void>}
 */
const handleClickImage = (url) => {
    mainImage.value = urlImage(url);
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/book/details_book.scss';
</style>
