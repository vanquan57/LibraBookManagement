<?php

namespace App\Http\Requests\Admin;

use App\Models\Category;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

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
        $columns = DB::getSchemaBuilder()->getColumnListing('categories');

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
            'name.string' => 'Trường tìm kiếm phải là một chuỗi.',
            'name.max' => 'Trường tìm kiếm không được vượt quá 255 ký tự.',
            'limit.integer' => 'Trường giới hạn phải là một số nguyên.',
            'limit.min' => 'Trường giới hạn phải có giá trị tối thiểu là 1.',
            'order.string' => 'Trường sắp xếp phải là một chuỗi.',
            'order.in' => 'Trường sắp xếp phải là asc hoặc desc.',
            'column.string' => 'Trường cột phải là một chuỗi.',
            'column.in' => 'Trường cột không hợp lệ.',
        ];
    }
}
