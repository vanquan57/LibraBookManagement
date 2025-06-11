<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class AdminDashboardSearchRequest extends FormRequest
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
            'limit' => 'nullable|integer|min:1',
            'order_by_type' => 'nullable|string|in:asc,desc',
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
            'limit.integer' => 'Số lượng bản ghi phải là một số nguyên.',
            'limit.min' => 'Giá trị tối thiểu phải lớn hơn 1.',
            'order_by_type.in' => 'Kiểu sắp xếp phải là phải tăng dần hoặc giảm dần".',
            'order_by_type.string' => 'Kiểu sắp xếp phải là một chuỗi.',
        ];
    }
}
