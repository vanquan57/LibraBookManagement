<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Reset Password - VKU Libra</title>
    <style>
        :root {
            --primary-color: #4a90e2;
            --hover-color: #357abd;
            --text-color: #2c3e50;
            --background-color: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--background-color);
            background-image: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            max-width: 600px;
            width: 90%;
            background-color: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .header {
            text-align: center;
            margin-bottom: 35px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }

        .header h1 {
            color: var(--text-color);
            font-size: 28px;
            margin: 0;
            font-weight: 600;
        }

        .content {
            color: var(--text-color);
            line-height: 1.8;
            font-size: 16px;
        }

        .content p {
            margin-bottom: 20px;
        }

        .button {
            display: inline-block;
            width: auto;
            min-width: 200px;
            background-color: var(--primary-color);
            color: white;
            padding: 15px 30px;
            text-align: center;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            margin: 30px auto;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(74, 144, 226, 0.2);
        }

        .button:hover {
            background-color: var(--hover-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(74, 144, 226, 0.3);
        }

        .footer {
            text-align: center;
            font-size: 14px;
            color: #6c757d;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #eee;
        }

        @media (max-width: 480px) {
            .container {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 24px;
            }

            .button {
                width: 100%;
                min-width: unset;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>VKU Libra - Đặt Lại Mật Khẩu</h1>
    </div>
    <div class="content">
        <p>Xin chào,</p>
        <p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản VKU Libra của bạn.</p>
        <p>Để đặt lại mật khẩu, vui lòng nhấn vào nút bên dưới:</p>
        <a href="{{ $token }}" class="button">Đặt Lại Mật Khẩu</a>
        <p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>
    </div>
    <div class="footer">
        <p>&copy; 2025 VKU Libra. Mọi quyền được bảo lưu.</p>
    </div>    
</div>
</body>
</html>
