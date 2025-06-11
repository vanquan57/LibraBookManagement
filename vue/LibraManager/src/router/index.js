import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '../views/HomeView.vue';
import LoginView from '@/views/LoginView.vue';
import UserView from '@/views/UserView.vue';
import CategoryView from '@/views/CategoryView.vue';
import PublisherView from '@/views/PublisherView.vue';
import FeedbackView from '@/views/FeedbackView.vue';
import BookView from '@/views/BookView.vue';
import AuthorView from '@/views/AuthorView.vue';
import DefaultLayout from '@/components/layouts/DefaultLayout.vue';
import OrderView from '@/views/OrderView.vue';

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'admin.layout',
            component: DefaultLayout,
            children: [
                {
                    path: '',
                    name: 'home',
                    component: HomeView
                },
                {
                    path: 'user',
                    name: 'user',
                    component: UserView,
                    props: {
                        site: 'user'
                    }
                },
                {
                    path: 'user/information',
                    name: 'user-information',
                    component: UserView,
                    props: {
                        site: 'information'
                    }
                },
                {
                    path: 'category',
                    name: 'category',
                    component: CategoryView
                },
                {
                    path: 'category/create',
                    name: 'category.create',
                    component: CategoryView,
                    props: {
                        site: 'create'
                    }
                },
                {
                    path: 'category/edit/:id',
                    name: 'category.edit',
                    component: CategoryView,
                    props: (route) => ({
                        site: 'edit',
                        id: Number(route.params.id)
                    })
                },
                {
                    path: 'author',
                    name: 'author',
                    component: AuthorView
                },
                {
                    path: 'author/create',
                    name: 'author.create',
                    component: AuthorView,
                    props: {
                        site: 'create'
                    }
                },
                {
                    path: 'author/edit/:id',
                    name: 'author.edit',
                    component: AuthorView,
                    props: (route) => ({
                        site: 'edit',
                        id: Number(route.params.id)
                    })
                },
                {
                    path: 'publisher',
                    name: 'publisher',
                    component: PublisherView
                },
                {
                    path: 'publisher/create',
                    name: 'publisher.create',
                    component: PublisherView,
                    props: {
                        site: 'create'
                    }
                },
                {
                    path: 'publisher/edit/:id',
                    name: 'publisher.edit',
                    component: PublisherView,
                    props: (route) => ({
                        site: 'edit',
                        id: Number(route.params.id)
                    })
                },
                {
                    path: 'book',
                    name: 'book',
                    component: BookView
                },
                {
                    path: 'book/create',
                    name: 'book.create',
                    component: BookView,
                    props: {
                        site: 'create'
                    }
                },
                {
                    path: 'book/edit/:id',
                    name: 'book.edit',
                    component: BookView,
                    props: (route) => ({
                        site: 'edit',
                        id: Number(route.params.id)
                    })
                },
                {
                    path: 'order',
                    name: 'order',
                    component: OrderView
                },
                {
                    path: 'feedback',
                    name: 'feedback',
                    component: FeedbackView
                }
            ]
        },
        {
            path: '/auth/login',
            name: 'auth-login',
            component: LoginView
        }
    ]
});

/**
 * If the JWT token is valid before allowing navigation to the specified route.
 *
 * @function beforeEach
 *
 * @param {Object} to - The route object representing the target route the user is navigating to.
 * @param {Object} from - The route object representing the current route the user is navigating from.
 * @param {Function} next - A function that must be called to resolve or reject the navigation.
 *
 * @returns {void}
 */
router.beforeEach((to, from, next) => {
    const token = localStorage.getItem('token');

    if (!token && to.name !== 'auth-login') {
        return next({ name: 'auth-login' });
    }

    const isTokenValid = checkTokenValidity(token);

    if (!isTokenValid && to.name !== 'auth-login') {
        return next({ name: 'auth-login' });
    }

    next();
});

/**
 * Checks the validity of a JWT token.
 *
 * @function checkTokenValidity
 *
 * @param {string} token - The JWT token to be validated.
 *
 * @returns {boolean} - Returns true if the token is valid, false otherwise.
 */
function checkTokenValidity(token) {
    try {
        const payload = JSON.parse(atob(token.split('.')[1]));

        // Check if the token has expired (exp field)
        if (payload.exp*1000 < Date.now()) {
            return false;
        }

        return true;
    } catch (error) {
        return false;
    }
}

export default router;
