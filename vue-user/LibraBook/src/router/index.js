import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '@/views/HomeView.vue';
import DefaultLayout from '@/components/layouts/DefaultLayout.vue';
import LoginView from '@/views/LoginView.vue';
import RegisterView from '@/views/RegisterView.vue';
import VerifyEmail from '@/views/VerifyEmail.vue';
import ResetPassword from '@/views/ResetPassword.vue';
import WishListView from '@/views/WishListView.vue';
import CartView from '@/views/CartView.vue';
import CheckoutOrderView from '@/views/CheckoutOrderView.vue';
import AccountView from '@/views/AccountView.vue';
import AboutView from '@/views/AboutView.vue';
import ContactView from '@/views/ContactView.vue';
import DetailsView from '@/views/DetailsView.vue';
import NotFoundView from '@/views/NotFoundView.vue';
import ListBookView from '@/views/ListBookView.vue';
import { useAuthStore } from '@/stores/auth';
import ChangePasswordView from '@/views/ChangePasswordView.vue';
import OrdersView from '@/views/OrdersView.vue';
import LayoutAccount from '@/components/layouts/LayoutAccount.vue';
import VerifyEmailRegister from '@/views/VerifyEmailRegister.vue';

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'default.layout',
            component: DefaultLayout,
            children: [
                {
                    path: '',
                    name: 'home',
                    component: HomeView
                },
                {
                    path: 'auth/login',
                    name: 'auth-login',
                    component: LoginView,
                    meta: {
                        isLogin: true
                    }
                },
                {
                    path: 'auth/register',
                    name: 'auth-register',
                    component: RegisterView,
                    meta: {
                        isLogin: true
                    }
                },
                {
                    path: 'auth/email/verify/:id/:hash',
                    name: 'auth-verify-email-register',
                    component: VerifyEmailRegister
                },
                {
                    path: 'auth/verify-email',
                    name: 'auth-verify-email',
                    component: VerifyEmail,
                    meta: {
                        isLogin: true
                    }
                },
                {
                    path: 'auth/password/reset/',
                    name: 'reset-password',
                    component: ResetPassword,
                    props: true,
                    meta: {
                        isLogin: true
                    }
                },
                {
                    path: 'wishlist',
                    name: 'wishlist',
                    component: WishListView,
                    meta: {
                        requireAuth: true
                    }
                },
                {
                    path: 'cart',
                    name: 'cart',
                    component: CartView,
                    meta: {
                        requireAuth: true
                    }
                },
                {
                    path: 'checkout',
                    name: 'checkout',
                    component: CheckoutOrderView,
                    meta: {
                        requireAuth: true
                    }
                },
                {
                    path: 'my-account',
                    name: 'my-account',
                    component: LayoutAccount,
                    meta: {
                        requireAuth: true
                    },
                    children: [
                        {
                            path: '',
                            name: 'account',
                            component: AccountView
                        },
                        {
                            path: 'change-password',
                            name: 'change-password',
                            component: ChangePasswordView
                        },
                        {
                            path: 'orders',
                            name: 'orders',
                            component: OrdersView
                        }
                    ]
                },
                {
                    path: 'contact',
                    name: 'contact',
                    component: ContactView
                },
                {
                    path: 'about',
                    name: 'about',
                    component: AboutView
                },
                {
                    path: 'book/:slug',
                    name: 'book.detail',
                    component: DetailsView
                },
                {
                    path: 'list-book',
                    name: 'list-book',
                    component: ListBookView
                },
                {
                    path: '/:pathMatch(.*)*',
                    name: 'not-found',
                    component: NotFoundView,
                    meta: {
                        breadcrumb: 'Not Found'
                    }
                }
            ]
        }
    ],
    scrollBehavior(to, from, savedPosition) {
        if (to.name === 'list-book') {
            return false;
        }

        return { top: 0, behavior: 'auto' };
    }
});

router.beforeEach(async (to, from, next) => {
    const authStore = useAuthStore();

    if (to.meta.isLogin && await authStore.checkTokenValidity()) {
        next('/');
    }

    if (to.meta.requireAuth && !await authStore.checkTokenValidity()) {
        next('/auth/login');
    } else {
        next();
    }
});

export default router;
