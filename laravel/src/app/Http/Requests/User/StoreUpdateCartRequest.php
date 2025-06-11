<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class StoreUpdateCartRequest extends FormRequest
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
            "cart" => "required|array",
            "cart.*.book_id" => "required|integer|exists:books,id",
            "cart.*.quantity" => "required|integer|min:1",
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
            "cart.required" => "Trường giỏ mượn là bắt buộc.",
            "cart.array" => "Giỏ mượn phải là một mảng các sách.",
            "cart.*.book_id.required" => "Trường mã sách là bắt buộc.",
            "cart.*.book_id.integer" => "Mã sách phải là một số nguyên.",
            "cart.*.book_id.exists" => "Mã sách đã chọn không hợp lệ.",
            "cart.*.quantity.required" => "Trường số lượng là bắt buộc.",
            "cart.*.quantity.integer" => "Số lượng phải là một số nguyên.",
            "cart.*.quantity.min" => "Số lượng phải ít nhất là 1.",
        ];
    }
}
