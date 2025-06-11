import { defineStore } from 'pinia';
import axiosInstance from '@/config/axios';
import HTTP_STATUS_CODE from '@/config/statusCode';

export const useAuthStore = defineStore('auth', {
    state: () => ({}),
    getters: {},
    actions: {
        /**
         * Checks the validity of a JWT token.
         *
         * @function checkTokenValidity
         *         *
         * @returns {boolean} - Returns true if the token is valid, false otherwise.
         */
        async checkTokenValidity() {
            try {
                const token = localStorage.getItem('token');

                if (!token) {
                    return false;
                }

                const payload = JSON.parse(atob(token.split('.')[1]));

                // Check if the token has expired (exp field)
                if (payload.exp * 1000 < Date.now()) {
                    return false;
                }

                // If the token is still valid, verify its validity on the server
                const response = await axiosInstance.get('/profile');

                return response.status === HTTP_STATUS_CODE.OK && response.success;
            } catch (error) {
                return false;
            }
        }
    }
});
