<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class ChangePasswordRequest extends FormRequest
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
            'current_password' => 'required|string|min:8|regex:/^(?=.*[A-Z])(?=.*[!@#$%^&*])/',
            'password' => 'required|string|min:8|regex:/^(?=.*[A-Z])(?=.*[!@#$%^&*])/',
            'confirm_password' => 'required|same:password',
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
            'current_password.required' => 'Vui lòng nhập mật khẩu hiện tại.',
            'current_password.string' => 'Vui lòng nhập mật khẩu hiện tại dưới dạng chuỗi ký tự.',
            'current_password.min' => 'Vui lòng nhập mật khẩu hiện tại có ít nhất 8 ký tự.',
            'current_password.regex' => 'Vui lòng nhập mật khẩu hiện tại có ít nhất một chữ cái viết hoa và một ký tự đặc biệt.',
            'password.required' => 'Vui lòng nhập mật khẩu.',
            'password.string' => 'Vui lòng nhập mật khẩu dưới dạng chuỗi ký tự.',
            'password.min' => 'Vui lòng nhập mật khẩu có ít nhất 8 ký tự.',
            'password.regex' => 'Vui lòng nhập mật khẩu có ít nhất một chữ cái viết hoa và một ký tự đặc biệt.',
            'confirm_password.required' => 'Vui lòng nhập xác nhận mật khẩu.',
            'confirm_password.same' => 'Mật khẩu không trùng khớp với mật khẩu.',
        ];
    }
}
