<template>
    <div class="book-card">
        <div class="book-card__image">
            <router-link :to="`/book/${book.id}`">
                <img
                    :src="urlImage(book.image)"
                    alt=""
                    loading="lazy"
                >
            </router-link>
            <div class="book-card__image__action">
                <div
                    v-if="!isWishlist && !isNewBook"
                    class="book-card__image__action__item icon-wishlist"
                    :class="{'active': wishListStore.wishList.includes(book.id)}"
                    @click="handleToggleBookWishlist(book.id)"
                >
                    <IconWishlist />
                </div>
                <div
                    v-if="isWishlist"
                    class="book-card__image__action__item"
                    :class="{'is-wishlist': isWishlist}"
                    @click="handleRemoveBookFromWishlist(book.id)"
                >
                    <IconDelete />
                </div>
                <div
                    v-if="!isWishlist"
                    class="book-card__image__action__item"
                    @click="handleQuickView(book.id)"
                >
                    <IconQuickView />
                </div>
            </div>
            <button
                class="book-card__image__btn-add"
                @click="handleAddBookToCart(book.id)"
            >
                <IconCart
                    v-if="isWishlist"
                    class="book-card__image__btn-add__icon"
                    color="white"
                />
                Thêm vào giỏ mượn
            </button>
        </div>
        <div class="book-card__info">
            <h2 class="book-card__info__name">
                {{ book.name }}
            </h2>
            <h3 class="book-card__info__author">
                {{ book.author.name }}
            </h3>
            <div class="book-card__info__rating">
                <div
                    v-for="i in 5"
                    :key="i"
                    :class="[
                        'book-card__info__rating__item',
                        { active: i <= book.average_star },
                    ]"
                >
                    <IconStar />
                </div>
                <span class="book-card__info__total-feedbacks">({{ book.feedbacks_count }})</span>
            </div>
        </div>
    </div>
</template>

<script setup>
import IconStar from '@/components/icons/IconStar.vue';
import IconQuickView from '@/components/icons/IconQuickView.vue';
import IconDelete from '@/components/icons/IconDelete.vue';
import IconWishlist from '@/components/icons/IconWishList.vue';
import IconCart from '@/components/icons/IconCart.vue';
import { useWishListStore } from '@/stores/wishList';

const wishListStore = useWishListStore();
const props = defineProps({
    book: {
        type: Object,
        required: true
    },
    isWishlist: {
        type: Boolean,
        default: false
    },
    isNewBook: {
        type: Boolean,
        default: false
    }
});

const emit = defineEmits(['quickView', 'addBookToCart', 'addBookToWishlist', 'removeBookFromWishlist']);

const urlImage = (url) => {
    return import.meta.env.VITE_URL_IMAGE + url;
};

const handleQuickView = (id) => {
    emit('quickView', id);
};

const handleAddBookToCart = (id) => {
    emit('addBookToCart', id);
};

const handleToggleBookWishlist = (id) => {
    if (wishListStore.wishList.includes(id)) {
        emit('removeBookFromWishlist', id);
    } else {
        emit('addBookToWishlist', id);
    }
};

const handleRemoveBookFromWishlist = (id) => {
    emit('removeBookFromWishlist', id);
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/book/book_card.scss';
</style>
