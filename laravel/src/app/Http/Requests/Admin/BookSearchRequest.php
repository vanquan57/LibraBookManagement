<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

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
        $columns = DB::getSchemaBuilder()->getColumnListing('books');

        return [
            'name' => 'nullable|string|max:255',
            'limit' => 'nullable|integer|min:1',
            'author_id' => 'nullable|integer|exists:authors,id',
            'publisher_id' => 'nullable|integer|exists:publishers,id',
            'category_id' => 'nullable|integer|exists:categories,id',
            'order' => 'nullable|string|in:asc,desc',
            'column' => 'nullable|string|in:' . implode(',', $columns),
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
            'name.string' => 'Từ khóa tìm kiếm phải là một chuỗi ký tự hợp lệ.',
            'name.max' => 'Tên không được vượt quá 255 ký tự.',
            'limit.integer' => 'Giá trị giới hạn phải là một số nguyên.',
            'limit.min' => 'Giá trị giới hạn phải lớn hơn hoặc bằng 1.',
            'author_id.integer' => 'ID tác giả phải là một số nguyên.',
            'author_id.exists' => 'Tác giả được chọn không tồn tại.',
            'publisher_id.integer' => 'ID nhà xuất bản phải là một số nguyên.',
            'publisher_id.exists' => 'Nhà xuất bản được chọn không tồn tại.',
            'category_id.integer' => 'ID thể loại phải là một số nguyên.',
            'category_id.exists' => 'Thể loại được chọn không tồn tại.',
            'order.string' => 'Thứ tự sắp xếp phải là một chuỗi ký tự.',
            'order.in' => 'Thứ tự sắp xếp chỉ được phép là "asc" hoặc "desc".',
            'column.string' => 'Tên cột phải là một chuỗi ký tự hợp lệ.',
            'column.in' => 'Tên cột không hợp lệ.',
        ];
    }
}
