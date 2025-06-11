<?php

namespace App\Http\Requests\Admin;

use App\Models\User;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\DB;

class UserSearchRequest extends FormRequest
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
        $columns = DB::getSchemaBuilder()->getColumnListing('users');

        return [
            'key_word' => 'nullable|string|max:255',
            'column' => 'nullable|string|in:' . implode(',', $columns),
            'order' => 'nullable|string|in:asc,desc',
            'limit' => 'nullable|integer|min:1',
            'status' => 'nullable|integer|in:' . implode(',', User::GROUP_STATUS),
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
            'key_word.string' => 'Từ khóa tìm kiếm phải là một chuỗi.',
            'key_word.max' => 'Từ khóa tìm kiếm không được vượt quá 255 ký tự.',
            'limit.integer' => 'Giới hạn phải là một số nguyên.',
            'limit.min' => 'Giới hạn phải lớn hơn 0.',
            'status.integer' => 'Trạng thái phải là một số nguyên.',
            'status.in' => 'Trạng thái không hợp lệ.',
        ];
    }
}
