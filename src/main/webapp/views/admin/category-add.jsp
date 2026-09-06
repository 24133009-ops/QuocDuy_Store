<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Danh Mục Mới - Quốc Duy Admin</title>
    <style>
        :root {
            --bg-color: #f5f5f7;
            --card-bg: rgba(255, 255, 255, 0.9);
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --apple-blue: #0071e3;
            --apple-blue-hover: #0077ed;
            --border-color: #d2d2d7;
            --border-focus: #0071e3;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .container {
            width: 100%;
            max-width: 620px;
        }

        .header {
            text-align: center;
            margin-bottom: 32px;
        }

        .apple-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
            margin-bottom: 16px;
        }

        .brand-tag {
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--apple-blue);
            margin-bottom: 4px;
        }

        .header h1 {
            font-size: 30px;
            font-weight: 700;
            letter-spacing: -0.02em;
            color: var(--text-main);
        }

        .header p {
            font-size: 15px;
            color: var(--text-sub);
            margin-top: 6px;
        }

        .form-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 22px;
            border: 1px solid rgba(210, 210, 215, 0.6);
            padding: 36px 32px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.04);
        }

        .form-group {
            margin-bottom: 22px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-main);
            margin-bottom: 8px;
            letter-spacing: -0.01em;
        }

        .hint {
            font-size: 12px;
            color: var(--text-sub);
            margin-top: 5px;
        }

        input[type="text"] {
            width: 100%;
            height: 48px;
            padding: 0 16px;
            font-size: 15px;
            color: var(--text-main);
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            outline: none;
            transition: all 0.2s ease;
        }

        input[type="text"]:focus {
            border-color: var(--border-focus);
            box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.12);
        }

        .file-upload-box {
            position: relative;
            display: flex;
            align-items: center;
            gap: 12px;
            background: #ffffff;
            border: 1px dashed var(--border-color);
            border-radius: 12px;
            padding: 12px 16px;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .file-upload-box:hover {
            border-color: var(--apple-blue);
            background: #fafaff;
        }

        input[type="file"] {
            font-size: 13px;
            color: var(--text-sub);
            width: 100%;
            cursor: pointer;
        }

        .status-options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            background: #e5e5ea;
            padding: 4px;
            border-radius: 12px;
        }

        .status-item {
            position: relative;
        }

        .status-item input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }

        .status-item label {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            margin-bottom: 0;
            height: 38px;
            border-radius: 9px;
            font-size: 14px;
            font-weight: 500;
            color: var(--text-main);
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.25, 0.1, 0.25, 1);
        }

        .status-item input[type="radio"]:checked + label {
            background: #ffffff;
            color: var(--apple-blue);
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .form-actions {
            margin-top: 32px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            align-items: center;
        }

        .btn-submit {
            width: 100%;
            height: 48px;
            background: var(--apple-blue);
            color: #ffffff;
            border: none;
            border-radius: 980px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.25, 0.1, 0.25, 1);
            box-shadow: 0 4px 14px rgba(0, 113, 227, 0.25);
        }

        .btn-submit:hover {
            background: var(--apple-blue-hover);
            transform: scale(1.01);
        }

        .btn-back {
            color: var(--text-sub);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.15s ease;
        }

        .btn-back:hover {
            color: var(--apple-blue);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <div class="apple-badge">
                <svg width="22" height="22" viewBox="0 0 170 170" fill="#1d1d1f">
                    <path d="M150.37 130.25c-2.45 5.66-5.35 10.87-8.71 15.66-4.58 6.53-8.33 11.05-11.22 13.56-4.48 4.12-9.28 6.23-14.42 6.35-3.69 0-8.14-1.05-13.32-3.18-5.19-2.12-9.97-3.17-14.34-3.17-4.58 0-9.49 1.05-14.75 3.17-5.26 2.13-9.5 3.24-12.74 3.35-4.35.13-9.16-1.9-14.42-6.08-3.7-3.04-7.7-7.8-12-14.28-5.59-8.49-10.04-18.42-13.35-29.78-3.32-11.36-4.98-22.18-4.98-32.48 0-14.15 3.59-25.75 10.77-34.8 7.18-9.04 16.32-13.68 27.42-13.91 4.8 0 10.15 1.25 16.06 3.75 5.91 2.5 9.77 3.82 11.58 3.96 1.48-.14 5.56-1.5 12.24-4.1 6.68-2.6 12.18-3.73 16.5-3.4 12.24.63 21.9 4.87 28.98 12.72-10.63 6.42-15.82 15.19-15.58 26.31.25 8.78 3.59 16.03 10.02 21.75 6.43 5.72 13.96 9.07 22.59 10.05-2.22 6.81-4.8 13.38-7.74 19.71zM119.22 33.15c0-6.84 2.45-13.3 7.35-19.38 4.9-6.08 11.08-10.23 18.54-12.45.24 1.13.36 2.18.36 3.15 0 6.61-2.6 13.15-7.8 19.62-5.2 6.47-11.33 10.25-18.39 11.34-.06-.76-.06-1.52-.06-2.28z"/>
                </svg>
            </div>
            <div class="brand-tag">Quốc Duy Admin</div>
            <h1>Thêm Danh Mục Mới</h1>
            <p>Khởi tạo nhóm thiết bị mới cho hệ thống Quốc Duy Store</p>
        </div>

        <div class="form-card">
            <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="categoryname">Tên danh mục thiết bị</label>
                    <input type="text" id="categoryname" name="categoryname" placeholder="Ví dụ: iPad Pro, AirPods Max..." required autofocus>
                </div>

                <div class="form-group">
                    <label for="images">Đường dẫn hình ảnh (URL Online)</label>
                    <input type="text" id="images" name="images" placeholder="https://images.unsplash.com/...">
                    <div class="hint">Dán trực tiếp URL ảnh sắc nét từ web</div>
                </div>

                <div class="form-group">
                    <label>Hoặc tải ảnh từ máy tính</label>
                    <div class="file-upload-box">
                        <input type="file" id="images1" name="images1" accept="image/*">
                    </div>
                    <div class="hint">Định dạng hỗ trợ: PNG, JPG, WebP</div>
                </div>

                <div class="form-group" style="margin-top: 26px;">
                    <label>Trạng thái danh mục</label>
                    <div class="status-options">
                        <div class="status-item">
                            <input type="radio" id="ston" name="status" value="1" checked>
                            <label for="ston">● Đang hoạt động</label>
                        </div>
                        <div class="status-item">
                            <input type="radio" id="stoff" name="status" value="0">
                            <label for="stoff">● Tạm khóa</label>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-submit">Thêm vào hệ thống</button>
                    <a href="<c:url value='/admin/categories'/>" class="btn-back">&larr; Hủy và quay lại danh sách</a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>