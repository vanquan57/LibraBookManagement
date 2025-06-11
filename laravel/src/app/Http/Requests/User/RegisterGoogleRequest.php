<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class RegisterGoogleRequest extends FormRequest
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
            'code' => 'required|string|regex:/^\d{2}IT\d{3}$/',
            'access_token' => 'required|string',
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
            'code.required' => 'Vui lòng nhập mã sinh viên',
            'code.string' => 'Mã sinh viên phải là chuỗi',
            'code.regex' => 'Bạn không phải sinh viên VKU ?',
            'access_token.required' => 'Thông tin xác thực không được để trống',
            'access_token.string' => 'Thông tin xác thực phải là chuỗi',
        ];
    }
}
