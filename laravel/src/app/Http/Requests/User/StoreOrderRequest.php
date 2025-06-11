<?php

namespace App\Http\Requests\User;

use App\Models\Order;
use Illuminate\Foundation\Http\FormRequest;

class StoreOrderRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:11',
            'email' => [
                'required',
                'email',
                'regex:/vku/',
                'max:100',
            ],
            'province_id' => 'required|integer|exists:provinces,id',
            'district_id' => 'required|integer|exists:districts,id',
            'ward_id' => 'required|integer|exists:wards,id',
            'address' => 'required|string|max:255',
            'order_details' => 'required|array',
            'order_details.*.book_id' => 'required|integer|exists:books,id',
            'order_details.*.quantity' => 'required|integer|min:1',
            'order_details.*.return_date' => 'required|date|after_or_equal:today',
            'order_details.*.note' => 'nullable|string|max:255',
        ];
    }

    /**
     * Get the error messages for the defined validation rules.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'name.required' => 'Tên là bắt buộc.',
            'name.string' => 'Tên phải là một chuỗi.',
            'name.max' => 'Tên không được vượt quá 255 ký tự.',
            'phone.required' => 'Số điện thoại là bắt buộc.',
            'phone.string' => 'Số điện thoại phải là một chuỗi.',
            'phone.max' => 'Số điện thoại không được vượt quá 11 ký tự.',
            'email.required' => 'Email là bắt buộc.',
            'email.email' => 'Email phải là một địa chỉ email hợp lệ.',
            'email.regex' => 'Bạn không phải là sinh viên VKU ?',
            'email.max' => 'Email không được vượt quá 100 ký tự.',
            'province_id.required' => 'Tỉnh/Thành phố là bắt buộc.',
            'province_id.integer' => 'Tỉnh/Thành phố phải là một số nguyên.',
            'province_id.exists' => 'Tỉnh/Thành phố không tồn tại.',
            'district_id.required' => 'Quận/Huyện là bắt buộc.',
            'district_id.integer' => 'Quận/Huyện phải là một số nguyên.',
            'district_id.exists' => 'Quận/Huyện không tồn tại.',
            'ward_id.required' => 'Phường/Xã là bắt buộc.',
            'ward_id.integer' => 'Phường/Xã phải là một số nguyên.',
            'ward_id.exists' => 'Phường/Xã không tồn tại.',
            'address.required' => 'Địa chỉ là bắt buộc.',
            'address.string' => 'Địa chỉ phải là một chuỗi.',
            'address.max' => 'Địa chỉ không được vượt quá 255 ký tự.',
            'order_details.required' => 'Chi tiết đơn hàng là bắt buộc.',
            'order_details.*.book_id.required' => 'Mã sách là bắt buộc.',
            'order_details.*.book_id.integer' => 'Mã sách phải là một số nguyên.',
            'order_details.*.book_id.exists' => 'Sách không tồn tại.',
            'order_details.*.quantity.required' => 'Số lượng là bắt buộc.',
            'order_details.*.quantity.integer' => 'Số lượng phải là một số nguyên.',
            'order_details.*.quantity.min' => 'Số lượng phải ít nhất là 1.',
            'order_details.*.return_date.required' => 'Ngày trả là bắt buộc.',
            'order_details.*.return_date.date' => 'Ngày trả phải là một ngày hợp lệ.',
            'order_details.*.return_date.after_or_equal' => 'Ngày trả phải từ hôm nay trở đi.',
        ];
    }
}
