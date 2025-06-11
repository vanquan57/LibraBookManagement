<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StoreUpdateAuthorRequest extends FormRequest
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
            'description' => 'nullable|string|max:255',
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
            'name.required' => 'Tên tác giả không được để trống.',
            'name.max' => 'Tên tác giả không được vượt quá 100 ký tự.',
            'description.max' => 'Mô tả không được vượt quá 255 ký tự.',
            'description.string' => 'Mô tả phải là một chuỗi ký tự hợp lệ.',
        ];
    }
}
