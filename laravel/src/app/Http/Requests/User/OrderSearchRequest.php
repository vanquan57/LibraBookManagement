<?php

namespace App\Http\Requests\User;

use App\Models\Order;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

class OrderSearchRequest extends FormRequest
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
        $columns = DB::getSchemaBuilder()->getColumnListing('orders');

        return [
            'limit' => 'nullable|integer|min:1',
            'column' => 'nullable|string|in:' . implode(',', $columns),
            'order' => 'nullable|string|in:asc,desc',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date',
            'status' => 'nullable|in:' . implode(',', Order::GROUP_STATUS),
        ];
    }

    /**
     * Get the custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'search.string' => 'Trường tìm kiếm phải là một chuỗi.',
            'search.max' => 'Trường tìm kiếm không được vượt quá :max ký tự.',
            'limit.integer' => 'Trường giới hạn phải là một số nguyên.',
            'limit.min' => 'Trường giới hạn phải có giá trị tối thiểu là :min.',
            'column.string' => 'Trường tên cột phải là một chuỗi.',
            'column.in' => 'Trường tên cột phải thuộc một trong các loại sau: :values.',
            'order.string' => 'Trường kiểu sắp xếp phải là một chuỗi.',
            'order.in' => 'Trường kiểu sắp xếp phải thuộc một trong các loại sau: :values.',
            'start_date.date' => 'Trường ngày bắt đầu phải là một ngày hợp lệ.',
            'end_date.date' => 'Trường ngày kết thúc phải là một ngày hợp lệ.',
            'status.in' => 'Trường trạng thái phải thuộc một trong các loại sau: :values.',
        ];
    }
}
