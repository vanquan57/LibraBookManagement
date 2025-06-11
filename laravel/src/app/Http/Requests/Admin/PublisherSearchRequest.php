<?php

namespace App\Http\Requests\Admin;

use App\Models\Publisher;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

class PublisherSearchRequest extends FormRequest
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
        $columns = DB::getSchemaBuilder()->getColumnListing('publishers');

        return [
            'name' => 'nullable|string|max:255',
            'limit' => 'nullable|integer|min:1',
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
            'name.max' => 'Từ khóa tìm kiếm không được vượt quá 255 ký tự.',
            'limit.integer' => 'Giới hạn phải là một số nguyên.',
            'limit.min' => 'Giới hạn phải là số nguyên dương',
            'order.string' => 'Thứ tự sắp xếp phải là một chuỗi.',
            'order.in' => 'Thứ tự sắp xếp chỉ được phép là "asc" hoặc "desc".',
            'column.string' => 'Tên cột phải là một chuỗi ký tự hợp lệ.',
            'column.in' => 'Tên trường không tồn tại',
        ];
    }
}
