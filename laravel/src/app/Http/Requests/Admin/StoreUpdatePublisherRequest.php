<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreUpdatePublisherRequest extends FormRequest
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
        $publisherId = $this->route('publisher');

        return [
            'name' => [
                'required',
                'string',
                'max:100',
                Rule::unique('publishers')->ignore($publisherId),
            ],
            'description' => 'required|string|max:255',
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
            'name.required' => 'Tên là trường bắt buộc.',
            'name.string' => 'Tên phải là một chuỗi ký.',
            'name.max' => 'Tên không được vượt quá 100 ký tự.',
            'name.unique' => 'Tên nhà xuất bản đã tồn tại.',
            'description.required' => 'Mô tả là trường bắt buộc.',
            'description.string' => 'Mô tả phải là một chuỗi ký tự hợp lệ.',
            'description.max' => 'Mô tả không được vượt quá 255 ký tự.',
        ];
    }
}
