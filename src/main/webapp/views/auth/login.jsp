<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập bằng Tài khoản Quốc Duy ID</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "SF Pro Display", "Helvetica Neue", Helvetica, Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        body {
            background-color: #ffffff;
            color: #1d1d1f;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-card {
            width: 100%;
            max-width: 440px;
            text-align: center;
        }

        .apple-icon {
            width: 48px;
            height: 48px;
            margin-bottom: 24px;
        }

        h1 {
            font-size: 26px;
            font-weight: 600;
            letter-spacing: -0.015em;
            margin-bottom: 8px;
        }

        .subtitle {
            font-size: 14px;
            color: #86868b;
            margin-bottom: 32px;
            line-height: 1.4;
        }

        .error-message {
            background-color: #ffebe9;
            color: #ff3b30;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 13px;
            margin-bottom: 20px;
            text-align: left;
            border: 1px solid rgba(255, 59, 48, 0.2);
        }

        .input-group {
            margin-bottom: 16px;
            text-align: left;
        }

        input[type="email"],
        input[type="password"],
        input[type="text"] {
            width: 100%;
            height: 52px;
            padding: 0 16px;
            font-size: 16px;
            color: #1d1d1f;
            background: #ffffff;
            border: 1px solid #d2d2d7;
            border-radius: 12px;
            outline: none;
            transition: all 0.2s ease;
        }

        input:focus {
            border-color: #0071e3;
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.15);
        }

        .btn-submit {
            width: 100%;
            height: 50px;
            background: #0071e3;
            color: #ffffff;
            border: none;
            border-radius: 980px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-submit:hover {
            background: #0077ed;
            transform: scale(1.01);
        }

        .options-links {
            margin-top: 32px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            font-size: 14px;
        }

        .options-links a {
            color: #0071e3;
            text-decoration: none;
            transition: underline 0.2s;
        }

        .options-links a:hover {
            text-decoration: underline;
        }

        .footer-note {
            margin-top: 48px;
            font-size: 12px;
            color: #86868b;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <!-- Giữ nguyên quả táo khuyết Apple chuẩn -->
        <svg class="apple-icon" viewBox="0 0 170 170" fill="#1d1d1f">
            <path d="M150.37 130.25c-2.45 5.66-5.35 10.87-8.71 15.66-4.58 6.53-8.33 11.05-11.22 13.56-4.48 4.12-9.28 6.23-14.42 6.35-3.69 0-8.14-1.05-13.32-3.18-5.19-2.12-9.97-3.17-14.34-3.17-4.58 0-9.49 1.05-14.75 3.17-5.26 2.13-9.5 3.24-12.74 3.35-4.35.13-9.16-1.9-14.42-6.08-3.7-3.04-7.7-7.8-12-14.28-5.59-8.49-10.04-18.42-13.35-29.78-3.32-11.36-4.98-22.18-4.98-32.48 0-14.15 3.59-25.75 10.77-34.8 7.18-9.04 16.32-13.68 27.42-13.91 4.8 0 10.15 1.25 16.06 3.75 5.91 2.5 9.77 3.82 11.58 3.96 1.48-.14 5.56-1.5 12.24-4.1 6.68-2.6 12.18-3.73 16.5-3.4 12.24.63 21.9 4.87 28.98 12.72-10.63 6.42-15.82 15.19-15.58 26.31.25 8.78 3.59 16.03 10.02 21.75 6.43 5.72 13.96 9.07 22.59 10.05-2.22 6.81-4.8 13.38-7.74 19.71zM119.22 33.15c0-6.84 2.45-13.3 7.35-19.38 4.9-6.08 11.08-10.23 18.54-12.45.24 1.13.36 2.18.36 3.15 0 6.61-2.6 13.15-7.8 19.62-5.2 6.47-11.33 10.25-18.39 11.34-.06-.76-.06-1.52-.06-2.28z"/>
        </svg>

        <h1>Đăng nhập với Quốc Duy ID</h1>
        <p class="subtitle">Sử dụng tài khoản cá nhân của bạn để truy cập hệ thống cửa hàng công nghệ Quốc Duy</p>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form action="<c:url value='/login'/>" method="post">
            <div class="input-group">
                <input type="email" name="email" placeholder="Email hoặc Quốc Duy ID" required autofocus>
            </div>

            <div class="input-group">
                <input type="password" name="password" placeholder="Mật khẩu" required>
            </div>

            <button type="submit" class="btn-submit">Tiếp tục</button>
        </form>

        <div class="options-links">
            <a href="<c:url value='/forgot-password'/>">Quên Quốc Duy ID hoặc mật khẩu?</a>
            <a href="<c:url value='/register'/>">Chưa có tài khoản? Tạo Quốc Duy ID</a>
            <a href="<c:url value='/home'/>">&larr; Quay về trang chủ cửa hàng</a>
        </div>

        <div class="footer-note">
            Bảo mật thông tin &bull; Điều khoản dịch vụ &bull; Quoc Duy Store
        </div>
    </div>

</body>
</html>