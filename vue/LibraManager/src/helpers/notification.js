import { ElNotification } from 'element-plus';
import HTTP_STATUS_CODE from '@/config/statusCode';

/**
 * Show notification success
 * @param {string} message - The message to display in the notification.
 *
 * @param {string} title - The title of the notification.
 *
 * @param {number} duration - The duration of the notification in milliseconds.
 */
export const showNotificationSuccess = (
    message,
    title = 'Thành công',
    duration = 2000
) => {
    ElNotification.success({
        title: title,
        message: message,
        duration: duration,
    });
};

/**
 * Show notification error
 *
 * @param {Object|string} error - The error to display in the notification.
 *
 * @param {string} title - The title of the notification.
 *
 * @param {number} duration - The duration of the notification in milliseconds.
 */
export const showNotificationError = (
    error,
    title = 'Lỗi',
    duration = 2000
) => {
    let message = '';

    if (typeof error === 'string') {
        message = error;
    } else if (error?.data?.errors) {
        const errors = error.data.errors;

        if (error.status === HTTP_STATUS_CODE.HTTP_UNPROCESSABLE_ENTITY) {
            message = Object.values(errors)[0][0];
        } else {
            message = errors.error_message;
        }
    }

    ElNotification.error({
        title: title,
        message: message,
        duration: duration,
    });
};
