<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

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
        $columns = DB::getSchemaBuilder()->getColumnListing('feedbacks');

        return [
            'name' => 'nullable|string|max:255',
            'limit' => 'nullable|integer|min:1',
            'column' => 'nullable|string|in:' . implode(',', $columns),
            'order' => 'in:asc,desc',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date',
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
            'name.string' => 'Tên phải là một chuỗi ký tự!',
            'name.max' => 'Tên không được vượt quá 255 ký tự!',
            'limit.min' => 'Giá trị tối thiểu phải lớn hơn 1!',
            'limit.integer' => 'Giới hạn phải là một số nguyên!',
            'column.string' => 'Cột phải là một chuỗi ký tự!',
            'column.in' => 'Cột phải là một trong các cột của bảng phản hồi!',
            'order.string' => 'Kiểu sắp xếp phải là một chuỗi ký tự!',
            'order.in' => 'Kiểu sắp xếp phải là "asc" hoặc "desc"!',
            'start_date.date' => 'Ngày bắt đầu phải là một ngày hợp lệ!',
            'end_date.date' => 'Ngày kết thúc phải là một ngày hợp lệ!',
        ];
    }
}
