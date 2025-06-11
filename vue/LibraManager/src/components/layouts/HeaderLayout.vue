<template>
    <header class="top-bar">
        <div class="top-bar-left">
            <div class="top-bar-icon_left">
                <button>
                    <component :is="IconHamb" />
                </button>
            </div>
            <form
                class="search-form"
                role="search"
            >
                <component :is="IconSearch" />
                <input
                    id="search-input"
                    type="search"
                    class="search-input"
                    placeholder="Tìm kiếm ..."
                >
            </form>
        </div>
        <div class="user-controls">
            <button class="btn-bell">
                <p class="total-notification">
                    9
                </p>
                <component :is="IconBell" />
            </button>
            <div class="language-selector">
                <img
                    :src="images.flag"
                    alt="Language flag"
                    class="language-flag"
                >
                <select>
                    <option value="vi">
                        Vietnamese
                    </option>
                    <option value="en">
                        English
                    </option>
                    <option value="jp">
                        Japanese
                    </option>
                </select>
            </div>
            <div
                class="user-profile"
                @click="showPopup"
            >
                <img
                    :src="images.imgProfile"
                    alt="User avatar"
                    class="user-avatar"
                >
                <div class="user-info">
                    <h5 class="user-name">
                        Moni Roy
                    </h5>
                    <span class="user-role">Admin</span>
                </div>
                <button class="btn-profile-menu-icon">
                    <img
                        src="https://cdn.builder.io/api/v1/image/assets/TEMP/b20169eda56be3aa0d5a801d2c4bcc650bc2f445c19e2b878c9b494edee515d8?placeholderIfAbsent=true&apiKey=4255145e56f84e14926ae9843aa02290"
                        alt="Profile menu"
                        :class="['profile-menu-icon', { rotate: isActive }]"
                    >
                </button>
                <div
                    v-if="isActive"
                    class="user-profile-popup"
                >
                    <ul class="list-profile-options">
                        <li>
                            <component :is="IconSetting" />
                            <a href="#">Change Password</a>
                        </li>
                        <li @click="handleLogout">
                            <component :is="IconLogout" />
                            <a href="#">Log out</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </header>
</template>

<script setup>
import images from '@/assets/images';
import { ref } from 'vue';
import IconLogout from '@/components/icons/IconLogout.vue';
import IconSetting from '@/components/icons/IconSetting.vue';
import IconBell from '@/components/icons/IconBell.vue';
import IconHamb from '@/components/icons/IconHamb.vue';
import IconSearch from '@/components/icons/IconSearch.vue';
const isActive = ref(false);
const emit = defineEmits(['logout']);
/**
 * Toggles the visibility of the popup by changing the value of `isActive`.
 * When called, it inverts the current boolean value of `isActive`.
 */
const showPopup = () => {
    isActive.value = !isActive.value;
};

const handleLogout = () => {
    emit('logout');
};
</script>

<style lang="scss" scoped>
@import '@/assets/scss/components/layouts/header_layout.scss';
</style>
