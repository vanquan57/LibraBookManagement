<?php

namespace App\Http\Requests\Admin;

use App\Models\Book;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreBookRequest extends FormRequest
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
            'author_id' => 'required|integer|exists:authors,id',
            'publisher_id' => 'required|integer|exists:publishers,id',
            'category_id' => 'required|integer|exists:categories,id',
            'name' => 'required|string|max:255|unique:books',
            'mini_description' => 'required|string|max:255',
            'details_description' => 'required|string',
            'publication_date' => 'required|date',
            'quantity' => 'nullable|integer|min:0',
            'size' => 'nullable|string|max:50',
            'page' => 'nullable|integer|min:0',
            'cover_type' => 'nullable|integer|in:'. Book::HARD_COVER .','. Book::SOFT_COVER,
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'images' => 'required|array|size:4',
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
            'author_id.required' => 'Trường tác giả là bắt buộc.',
            'author_id.integer' => 'ID tác giả phải là một số nguyên.',
            'author_id.exists' => 'Tác giả được chọn không tồn tại.',
            'publisher_id.required' => 'Trường nhà xuất bản là bắt buộc.',
            'publisher_id.integer' => 'ID nhà xuất bản phải là một số nguyên.',
            'publisher_id.exists' => 'Nhà xuất bản được chọn không tồn tại.',
            'category_id.required' => 'Trường thể loại là bắt buộc.',
            'category_id.integer' => 'ID thể loại phải là một số nguyên.',
            'category_id.exists' => 'Thể loại được chọn không tồn tại.',
            'name.required' => 'Trường tên là bắt buộc.',
            'name.string' => 'Tên phải là một chuỗi ký tự.',
            'name.max' => 'Tên không được vượt quá 255 ký tự.',
            'name.unique' => 'Tên đã tồn tại.',
            'mini_description.required' => 'Trường mô tả ngắn là bắt buộc.',
            'mini_description.string' => 'Mô tả ngắn phải là một chuỗi ký tự.',
            'mini_description.max' => 'Mô tả ngắn không được quá 255 kí tự.',
            'details_description.required' => 'Trường mô tả chi tiết là bắt buộc.',
            'details_description.string' => 'Mô tả chi tiết phải là một chuỗi ký tự.',
            'publication_date.required' => 'Trường ngày xuất bản là bắt buộc.',
            'publication_date.date' => 'Ngày xuất bản phải là một ngày hợp lệ.',
            'quantity.integer' => 'Số lượng phải là một số nguyên.',
            'quantity.min' => 'Số lượng không được nhỏ hơn 0.',
            'size.string' => 'Kích thước phải là một chuỗi ký tự.',
            'size.max' => 'Kích thước không được vượt quá 50 ký tự.',
            'page.integer' => 'Số trang phải là một số nguyên.',
            'page.min' => 'Số trang không được nhỏ hơn 0.',
            'cover_type.integer' => 'Loại bìa phải là một số nguyên.',
            'cover_type.in' => 'Loại bìa không hợp lệ.',
            'image.required' => 'Trường ảnh là bắt buộc.',
            'image.image' => 'Ảnh phải có định dạng hợp lệ.',
            'image.mimes' => 'Ảnh phải có định dạng JPEG, PNG, JPG, GIF hoặc SVG.',
            'image.max' => 'Ảnh không được lớn hơn 2MB.',
            'images.required' => 'Trường danh sách ảnh là bắt buộc.',
            'images.array' => 'Danh sách ảnh phải là một mảng.',
            'images.size' => 'Danh sách ảnh phải chứa đúng 4 ảnh.',
        ];
    }
}
