<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Quốc Duy Admin</title>
    <style>
        :root {
            --bg-color: #f5f5f7;
            --card-bg: rgba(255, 255, 255, 0.85);
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --apple-blue: #0071e3;
            --apple-blue-hover: #0077ed;
            --danger: #ff3b30;
            --success: #34c759;
            --border-color: #d2d2d7;
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
            padding: 40px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 1100px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 32px;
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
            font-size: 38px;
            font-weight: 700;
            letter-spacing: -0.02em;
            color: var(--text-main);
        }

        .header p {
            color: var(--text-sub);
            font-size: 15px;
            margin-top: 6px;
        }

        .btn-add {
            background-color: var(--apple-blue);
            color: #ffffff;
            padding: 10px 22px;
            border-radius: 980px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s cubic-bezier(0.25, 0.1, 0.25, 1);
            box-shadow: 0 4px 12px rgba(0, 113, 227, 0.2);
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-add:hover {
            background-color: var(--apple-blue-hover);
            transform: scale(1.02);
        }

        .table-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(210, 210, 215, 0.6);
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.04);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead {
            background-color: rgba(245, 245, 247, 0.7);
            border-bottom: 1px solid var(--border-color);
        }

        th {
            padding: 16px 24px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-sub);
        }

        td {
            padding: 18px 24px;
            font-size: 15px;
            vertical-align: middle;
            border-bottom: 1px solid rgba(210, 210, 215, 0.4);
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover td {
            background-color: rgba(255, 255, 255, 0.5);
        }

        .cate-img {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            object-fit: cover;
            background-color: #e5e5ea;
            border: 1px solid rgba(0, 0, 0, 0.04);
            display: block;
        }

        .cate-name {
            font-weight: 600;
            color: var(--text-main);
            font-size: 16px;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            border-radius: 980px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background-color: rgba(52, 199, 89, 0.12);
            color: var(--success);
        }

        .status-locked {
            background-color: rgba(255, 59, 48, 0.12);
            color: var(--danger);
        }

        .actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-action {
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            padding: 6px 14px;
            border-radius: 8px;
            transition: 0.15s ease;
        }

        .btn-edit {
            background-color: #f2f2f7;
            color: var(--text-main);
        }

        .btn-edit:hover {
            background-color: #e5e5ea;
        }

        .btn-delete {
            background-color: rgba(255, 59, 48, 0.08);
            color: var(--danger);
        }

        .btn-delete:hover {
            background-color: rgba(255, 59, 48, 0.16);
        }

        .back-link {
            display: inline-block;
            margin-top: 24px;
            color: var(--text-sub);
            text-decoration: none;
            font-size: 14px;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--apple-blue);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <div>
                <div class="brand-tag">Quốc Duy Ecosystem</div>
                <h1>Danh mục sản phẩm</h1>
                <p>Quản lý hệ thống thiết bị và gian hàng trực tuyến</p>
            </div>
            <a href="<c:url value='/admin/category/add'/>" class="btn-add">+ Thêm danh mục</a>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">ID</th>
                        <th style="width: 110px;">Hình ảnh</th>
                        <th>Tên danh mục</th>
                        <th style="width: 160px;">Trạng thái</th>
                        <th style="width: 180px; text-align: right;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listcate}" var="c">
                        <tr>
                            <td style="color: var(--text-sub); font-weight: 500;">#${c.categoryId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty c.images && c.images.startsWith('http')}">
                                        <img src="${c.images}" class="cate-img" alt="${c.categoryname}">
                                    </c:when>
                                    <c:when test="${not empty c.images}">
                                        <img src="<c:url value='/image?fname=${c.images}'/>" class="cate-img" alt="${c.categoryname}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="cate-img" style="display: flex; align-items: center; justify-content: center; font-size: 10px; color: #8e8e93;">No Img</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="cate-name">${c.categoryname}</div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.status == 1}">
                                        <span class="status-badge status-active">● Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-locked">● Đã khóa</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="actions" style="justify-content: flex-end;">
                                    <a href="<c:url value='/admin/category/edit?id=${c.categoryId}'/>" class="btn-action btn-edit">Sửa</a>
                                    <a href="<c:url value='/admin/category/delete?id=${c.categoryId}'/>" class="btn-action btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">Xóa</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <a href="<c:url value='/home'/>" class="back-link">&larr; Quay về trang chủ cửa hàng Quốc Duy</a>
    </div>

</body>
</html>