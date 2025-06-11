<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class FeedbackSearchRequest extends FormRequest
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
            'book_id' => 'required|integer|exists:books,id',
            'column' => 'nullable|string|in:star,created_at',
            'order' => 'nullable|string|in:asc,desc',
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
            'limit.integer' => 'Giới hạn số lương phải là số nguyên',
            'limit.min' => 'Giới hạn số lượng phải lớn hơn hoặc bằng 1',
            'book_id.required' => 'Sách không được để trống',
            'book_id.integer' => 'Sách phải là số nguyên',
            'book_id.exists' => 'Sách không tồn tại',
            'column.string' => 'Tên trường phải là một chuỗi ký tự',
            'column.in' => 'Tên trường phải thuộc star, created_at',
            'order.string' => 'Trường sắp xếp phải là một chuỗi ký tự',
            'order.in' => 'Trường sắp xếp phải thuộc asc hoặc desc',
        ];
    }
}
