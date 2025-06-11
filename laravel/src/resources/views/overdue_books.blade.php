<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa Đơn Sách Quá Hạn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f4f8;
        }
        .card {
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            padding: 16px;
            border-radius: 8px;
        }

        .card-header {
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 16px;
            margin-bottom: 16px;
        }

        .card-header .icon {
            width: 24px;
            height: 24px;
            color: #1d4ed8;
            margin-right: 8px;
        }

        .card-header .title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #1f2937;
        }

        .card-content {
            overflow-y: auto;
            max-height: 400px;
            position: relative;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead {
            background-color: #1d4ed8;
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        th, td {
            padding: 12px;
            border: 1px solid #e5e7eb;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fafb;
        }

        .due-date {
            color: #dc2626;
            font-weight: bold;
        }

        .footer {
            margin-top: 16px;
            font-size: 0.875rem;
            color: #4b5563;
        }
    </style>
</head>

<body>
    <div class="card">
        <div class="card-header">
            <div style="display: flex; align-items: center;">
                <svg class="icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.25 19.5h7.5m-7.5-2.25h7.5m-7.5-2.25h7.5m-7.5-2.25h7.5m-7.5-2.25h7.5m-7.5-2.25h7.5m-7.5-2.25h7.5"></path>
                </svg>
                <div class="title">Phiếu thông báo sách quá hạn</div>
            </div>
        </div>
        <div class="card-content">
            <table>
                <thead>
                    <tr>
                        <th>Tên sách</th>
                        <th>Người mượn</th>
                        <th>Ngày quá hạn</th>
                        <th>Số lượng</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($order_details as $order_detail)
                        <tr>
                            <td>{{ $order_detail->name }}</td>
                            <td>{{ $user->name }}</td>
                            <td class="due-date">{{ date('d/m/Y', strtotime($order_detail->pivot->return_date)) }}</td>
                            <td>{{ $order_detail->pivot->quantity }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
        <div class="footer">
            <p>Vui lòng trả sách đúng hạn để tránh phí phạt.</p>
        </div>
    </div>
</body>

</html>
