<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quốc Duy Store - Hệ Sinh Thái Công Nghệ</title>

    <!-- Thẻ Favicon đổi hình quả địa cầu trên tab thành hình đại diện -->
    <link rel="icon" type="image/png" href="<c:url value='/assets/avatar.png?v=1'/>">
    <!-- Nếu chưa có file avatar.png trong thư mục assets, có thể dùng tạm link online:
    <link rel="icon" type="image/jpeg" href="<c:url value='/assets/avatar.jpg?v=1'/>">
    -->

    <style>
        :root {
            --bg-color: #f5f5f7;
            --card-bg: rgba(255, 255, 255, 0.85);
            --text-main: #1d1d1f;
            --text-sub: #86868b;
            --apple-blue: #0071e3;
            --apple-blue-hover: #0077ed;
            --price-red: #d70018;
            --border-color: rgba(210, 210, 215, 0.6);
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
            padding: 30px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 1200px;
        }

        /* Thanh điều hướng Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            padding-bottom: 18px;
            border-bottom: 1px solid var(--border-color);
        }

        .brand-title h1 {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: -0.02em;
            color: var(--text-main);
        }

        .brand-title p {
            font-size: 14px;
            color: var(--text-sub);
            margin-top: 4px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-btn {
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            padding: 8px 18px;
            border-radius: 980px;
            transition: all 0.2s ease;
        }

        .btn-view-all {
            background-color: #ffffff;
            color: var(--text-main);
            border: 1px solid #d2d2d7;
        }

        .btn-view-all:hover {
            background-color: #f0f0f2;
        }

        .btn-login {
            background-color: var(--apple-blue);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 113, 227, 0.2);
        }

        .btn-login:hover {
            background-color: var(--apple-blue-hover);
            transform: scale(1.02);
        }

        /* Khung hiển thị sản phẩm */
        .grid-products {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(210px, 1fr));
            gap: 20px;
            margin-top: 10px;
        }

        .product-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 16px;
            text-align: center;
            transition: all 0.25s cubic-bezier(0.25, 0.1, 0.25, 1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            border-color: rgba(0, 113, 227, 0.3);
        }

        .img-wrap {
            width: 100%;
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border-radius: 12px;
            background: #ffffff;
            margin-bottom: 12px;
        }

        .product-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.04);
        }

        .product-name {
            min-height: 42px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 8px;
        }

        .product-name a {
            text-decoration: none;
            color: var(--text-main);
            font-size: 14px;
            font-weight: 600;
            line-height: 1.35;
            transition: color 0.2s;
        }

        .product-name a:hover {
            color: var(--apple-blue);
        }

        .product-price {
            color: var(--price-red);
            font-weight: 700;
            font-size: 16px;
            letter-spacing: -0.01em;
            margin-top: 4px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="header">
            <div class="brand-title">
                <h1>Quốc Duy Store</h1>
                <p>10 Sản phẩm công nghệ mới nhất trong hệ thống</p>
            </div>
            <div class="nav-links">
                <a href="<c:url value='/product'/>" class="nav-btn btn-view-all">Xem toàn bộ sản phẩm</a>
                <a href="<c:url value='/login'/>" class="nav-btn btn-login">Đăng nhập Quốc Duy ID</a>
            </div>
        </div>

        <div class="grid-products">
            <c:forEach items="${top10Products}" var="p">
                <div class="product-card">
                    <div class="img-wrap">
                        <c:choose>
                            <c:when test="${not empty p.images && p.images.startsWith('http')}">
                                <img class="product-img" src="${p.images}" alt="${p.productName}" />
                            </c:when>
                            <c:when test="${not empty p.images}">
                                <img class="product-img" src="<c:url value='/image?fname=${p.images}'/>" alt="${p.productName}" />
                            </c:when>
                            <c:otherwise>
                                <img class="product-img" src="https://via.placeholder.com/200x150?text=No+Image" alt="No Image" />
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="product-name">
                        <a href="<c:url value='/product/detail?id=${p.productId}'/>">${p.productName}</a>
                    </div>

                    <div class="product-price">
                        <fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>