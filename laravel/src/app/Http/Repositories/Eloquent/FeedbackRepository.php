<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\FeedbackRepositoryInterface;
use App\Models\Book;
use App\Models\Feedback;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

class FeedbackRepository extends BaseRepository implements FeedbackRepositoryInterface
{
    /**
     * Get the model
     */
    public function getModel(): string
    {
        return Feedback::class;
    }

    /**
     * Get all feedbacks by paginate
     * 
     * @param array $data
     * 
     * @return LengthAwarePaginator|null
     */
    public function getAllByPaginate(array $data): ?LengthAwarePaginator
    {
        $query = $this->model->with([
            'user:id,name',
            'book:id,name',
        ]);

        if (isset($data['book_ids'])) {
            $query->whereIn('book_id', $data['book_ids']);

            if (!empty($data['start_date'])) {
                if (!empty($data['end_date'])) {
                    $query->whereBetween('created_at', [$data['start_date'], $data['end_date']]);
                }
    
                $query->whereBetween('created_at', [$data['start_date'], now()]);
            }    
        }

        if (!empty($data['column']) && !empty($data['order'])) {
            $query->orderBy($data['column'], $data['order']);
        }

        return $query->orderBy('created_at', config('constants.DEFAULT_ORDER_DATE'))
            ->paginate($data['limit']);
    }

    /**
     * Update the feedback status
     *
     * @param int $id
     *
     * @return bool
     */
    public function updateStatus(int $id): bool
    {
        return $this->model->findOrFail($id)->update([
            'status' => Feedback::STATUS_ACTIVE,
        ]);
    }

    /**
     * Get feedbacks by book id.
     *
     * @param Book $book
     * 
     * @param array $data
     * 
     * @return LengthAwarePaginator|null
     */
    public function getFeedbacksByBookId(Book $book, array $data): ?LengthAwarePaginator
    {
        $query = $book->feedbacks()
            ->where('feedbacks.status', Feedback::STATUS_ACTIVE)
            ->where('users.role', User::ROLE_USER);

        if (!empty($data['column']) && !empty($data['order'])) {
            $query->orderBy('feedbacks.' . $data['column'], $data['order']);
        }

        return $query->paginate($data['limit'] ?? config('constants.DEFAULT_LIMIT'));
    }

    /**
     * Store a new feedback
     * 
     * @param array $data
     * 
     * @return Model
     */
    public function store(array $data): Model
    {
        return $this->model->create([
            'book_id' => $data['book_id'],
            'user_id' => $data['user_id'],
            'content' => $data['content'],
            'star' => $data['star'],
        ]);
    }
}
