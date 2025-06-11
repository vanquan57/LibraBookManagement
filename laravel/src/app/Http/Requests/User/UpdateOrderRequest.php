<?php

namespace App\Http\Requests\User;

use App\Models\Order;
use Illuminate\Foundation\Http\FormRequest;

class UpdateOrderRequest extends FormRequest
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
            'status' => 'required|in:' . Order::STATUS_MISSING . ',' . Order::STATUS_RETURNED,
            'book_id' => 'required|exists:books,id',
            'note' => 'required_if:status,' . Order::STATUS_MISSING,
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
            'status.required' => 'Trạng thái là bắt buộc.',
            'status.in' => 'Trạng thái không hợp lệ.',
            'book_id.required' => 'Mã sách là bắt buộc.',
            'book_id.exists' => 'Mã sách không hợp lệ.',
            'note.required_if' => 'Ghi chú là bắt buộc khi trạng thái bị thiếu.',
        ];
    }
}
