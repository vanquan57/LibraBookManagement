<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class StoreFeedbackRequest extends FormRequest
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
            'book_id' => 'required|integer|exists:books,id',
            'content' => 'required|string|max:255',
            'star' => 'required|integer|between:1,5',
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
            'book_id.required' => 'Sách không được để trống',
            'book_id.integer' => 'Mã định danh phải là một số nguyên',
            'book_id.exists' => 'Sách không tồn tại',
            'content.required' => 'Vui lòng nhập nội dung đánh giá',
            'content.string' => 'Nội dung phải là một chuỗi ký tự',
            'content.max' => 'Nội dung không được vượt quá 255 ký tự',
            'star.required' => 'Vui lòng nhập số sao',
            'star.integer' => 'Số sao phải là một số nguyên',
        ];
    }
}
