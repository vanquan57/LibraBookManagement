<?php

namespace App\Http\Requests\Admin;

use App\Models\Author;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

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
        $columns = DB::getSchemaBuilder()->getColumnListing('authors');

        return [
            'name' => 'nullable|string|max:255',
            'limit' => 'nullable|integer|min:1',
            'order' => 'nullable|string|in:asc,desc',
            'column' => 'nullable|string|in:' . implode(',', $columns),
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
            'name.max' => 'Từ khóa tìm kiếm không được vượt quá 255 ký tự.',
            'name.string' => 'Từ khóa tìm kiếm phải là một chuỗi ký tự hợp lệ.',
            'limit.integer' => 'Giá trị giới hạn phải là một số nguyên.',
            'limit.min' => 'Giá trị giới hạn phải lớn hơn hoặc bằng 1.',
            'order.string' => 'Thứ tự sắp xếp phải là một chuỗi ký tự.',
            'order.in' => 'Thứ tự sắp xếp chỉ được phép là "asc" hoặc "desc".',
            'column.string' => 'Tên cột phải là một chuỗi ký tự hợp lệ.',
            'column.in' => 'Giá trị của cột không hợp lệ.',
        ];
    }
}
