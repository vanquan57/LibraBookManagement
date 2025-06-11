<?php

namespace App\Http\Requests\Admin;

use App\Models\Author;
use Illuminate\Foundation\Http\FormRequest;

class AuthorSearchRequest extends FormRequest
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
     * Custom messages
     *
     * @return array
     */
    public function messages(): array
    {
        return [
            'search.max' => 'Tác giả không được vượt quá 255 ký tự.',
            'search.string' => 'Tác giả phải là một chuỗi ký tự.',
            'limit.min' => 'Giới hạn số lượng phải lớn hơn hoặc bằng 1.',
            'limit.integer' => 'Giới hạn số lượng phải là số nguyên.',
        ];
    }
}
