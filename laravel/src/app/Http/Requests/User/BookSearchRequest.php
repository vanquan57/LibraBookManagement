<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class BookSearchRequest extends FormRequest
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
            'name' => 'nullable|string|max:255',
            'limit' => 'nullable|integer|min:1',
            'author_id' => 'nullable|array',
            'author_id.*' => 'integer|exists:authors,id',
            'publisher_id' => 'nullable|array',
            'publisher_id.*' => 'integer|exists:publishers,id',
            'category_id' => 'nullable|integer|exists:categories,id',
            'order' => 'nullable|string|in:asc,desc',
            'most_borrowed' => 'nullable|boolean',
            'most_viewed' => 'nullable|boolean',
            'latest' => 'nullable|boolean',
            'most_loved' => 'nullable|boolean',
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
            'name.string' => 'Tên sách phải là một chuỗi kí tự',
            'name.max' => 'Tên sách không được quá 255 kí tự',
            'limit.integer' => 'Giới hạn số lượng sách phải là số nguyên',
            'limit.min' => 'Giới hạn số lượng sách phải lớn hơn hoặc bằng 1',
            'author_id.array' => 'Danh sách tác giả phải là kiểu dữ liệu mảng',
            'author_id.*.integer' => 'Mã định danh tác giả phải là số nguyên',
            'author_id.*.exists' => 'Mã định danh tác giả không tồn tại',
            'publisher_id.array' => 'Danh sách nhà xuất bản phải là kiểu dữ liệu mảng',
            'publisher_id.*.integer' => 'Mã định danh nhà xuất bản phải là số nguyên',
            'publisher_id.*.exists' => 'Mã định danh nhà xuất bản không tồn tại',
            'category_id.integer' => 'Mã định danh danh mục sách phải là số nguyên',
            'category_id.exists' => 'Mã định danh danh mục sách không tồn tại',
            'order.string' => 'Thứ tự sắp xếp phải là một chuỗi kí tự',
            'order.in' => 'Thứ tự sắp xếp không hợp lệ',
            'most_borrowed.boolean' => 'Sách mượn nhiều nhất phải là kiểu dữ liệu boolean',
            'most_viewed.boolean' => 'Sách xem nhiều nhất phải là kiểu dữ liệu boolean',
            'latest.boolean' => 'Sách mới nhất phải là kiểu dữ liệu boolean',
        ];
    }
}
