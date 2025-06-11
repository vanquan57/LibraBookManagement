import { defineStore } from 'pinia';
export const useCounterCartAndWishList = defineStore('counterCartAndWishList', {
    state: () => ({
        cart: 0,
        wishList: 0,
    }),
    getters: {},
    actions: {
        setCart(value) {
            this.cart = value;
        },
        setWishList(value) {
            this.wishList = value;
        },
        incrementCounterWishList() {
            this.wishList++;
        },
        incrementCounterCart() {
            this.cart++;
        },
        decrementCounterWishList() {
            this.wishList--;
        },
        decrementCounterCart() {
            this.cart--;
        }
    }
});
