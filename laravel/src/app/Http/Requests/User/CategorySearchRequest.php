<?php

namespace App\Http\Requests\Admin;

use App\Models\Category;
use Illuminate\Foundation\Http\FormRequest;

class CategorySearchRequest extends FormRequest
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
            'search' => 'nullable|string|max:255',
            'limit' => 'nullable|integer|min:1',
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
            'search.string' => 'Danh mục phải là một chuỗi ký tự.',
            'search.max' => 'Danh mục không được vượt quá 255 ký tự.',
            'limit.integer' => 'Giới hạn số lượng phải là 1 số nguyên.',
            'limit.min' => 'Giới hạn số lượng phải lớn hơn hoặc bằng 1.',
        ];
    }
}
