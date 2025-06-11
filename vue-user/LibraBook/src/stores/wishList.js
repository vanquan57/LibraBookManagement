import { defineStore } from 'pinia';
export const useWishListStore = defineStore('wishList', {
    state: () => ({
        wishList: []
    }),
    getters: {},
    actions: {
        addToWishList(bookId) {
            this.wishList.push(bookId);
        },
        removeFromWishList(bookId) {
            this.wishList = this.wishList.filter((id) => id !== bookId);
        },
        clearWishList() {
            this.wishList = [];
        }
    }
});
