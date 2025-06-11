<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class RegisterRequest extends FormRequest
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
            'name' => 'required|string|max:100',
            'code' => 'required|string|regex:/^\d{2}IT\d{3}$/',
            'email' => 'required|email|regex:/vku/',
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
            'name.required' => 'Vui lòng nhập tên',
            'name.string' => 'Tên phải là chuỗi',
            'name.max' => 'Tên không được quá 100 ký tự',
            'code.required' => 'Vui lòng nhập mã sinh viên',
            'code.string' => 'Mã sinh viên phải là chuỗi',
            'code.regex' => 'Bạn không phải sinh viên VKU ?',
            'email.required' => 'Vui lòng nhập email',
            'email.email' => 'Email không đúng định dạng',
            'email.regex' => 'Bạn không phải là sinh viên VKU ?',
            'password.required' => 'Vui lòng nhập mật khẩu',
            'password.string' => 'Mật khẩu phải là chuỗi',
            'password.min' => 'Mật khẩu phải có ít nhất 8 ký tự',
            'password.regex' => 'Mật khẩu phải chứa ít nhất 1 ký tự viết hoa và 1 ký tự đặc biệt',
            'confirm_password.required' => 'Vui lòng nhập lại mật khẩu',
            'confirm_password.same' => 'Mật khẩu không khớp',
        ];
    }
}
