<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class ResetPasswordRequest extends FormRequest
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
            'email' => 'required|email|exists:password_reset_tokens,email',
            'token' => 'required|string',
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
            'email.required' => 'Vui lòng nhập email.',
            'email.email' => 'Vui lòng nhập một địa chỉ email hợp lệ.',
            'email.exists' => 'Email không tồn tại.',
            'token.required' => 'Vui lòng nhập token.',
            'token.string' => 'Token phải là một chuỗi ký tự.',
            'password.required' => 'Vui lòng nhập mật khẩu.',
            'password.string' => 'Mật khẩu phải là một chuỗi ký tự.',
            'password.min' => 'Mật khẩu phải có ít nhất 8 ký tự.',
            'password.regex' => 'Mật khẩu phải chứa ít nhất một chữ cái viết hoa và một ký tự đặc biệt.',
            'confirm_password.required' => 'Vui lòng nhập xác nhận mật khẩu.',
            'confirm_password.same' => 'Mật khẩu và xác nhận mật khẩu phải trùng khớp.',
        ];
    }
}
