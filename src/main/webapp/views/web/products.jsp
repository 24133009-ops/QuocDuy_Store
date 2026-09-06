<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tất cả sản phẩm</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 20px; background-color: #f9f9f9;">
    <h2>Danh sách sản phẩm (6 sản phẩm / trang)</h2>
    <div style="margin-bottom: 15px;">
        <a href="<c:url value='/home'/>" style="text-decoration: none; color: #007bff; font-weight: bold;">&larr; Về trang chủ</a>
    </div>
    <hr style="border: 0; height: 1px; background: #ccc;">

    <div style="display: flex; flex-wrap: wrap; gap: 20px; margin-top: 20px;">
        <c:forEach items="${productList}" var="p">
            <div style="background: #fff; border: 1px solid #e0e0e0; border-radius: 8px; padding: 12px; width: 190px; text-align: center; box-shadow: 0 2px 6px rgba(0,0,0,0.08);">
                <c:choose>
                    <c:when test="${not empty p.images && p.images.startsWith('http')}">
                        <img src="${p.images}" width="160" height="130" style="object-fit: cover; border-radius: 6px;" alt="${p.productName}" />
                    </c:when>
                    <c:when test="${not empty p.images}">
                        <img src="<c:url value='/image?fname=${p.images}'/>" width="160" height="130" style="object-fit: cover; border-radius: 6px;" alt="${p.productName}" />
                    </c:when>
                    <c:otherwise>
                        <img src="https://via.placeholder.com/160x130?text=No+Image" width="160" height="130" style="border-radius: 6px;" alt="No Image" />
                    </c:otherwise>
                </c:choose>

                <div style="height: 42px; margin-top: 10px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                    <b><a href="<c:url value='/product/detail?id=${p.productId}'/>" style="text-decoration: none; color: #333; font-size: 14px;">${p.productName}</a></b>
                </div>

                <p style="color: #d70018; font-weight: bold; font-size: 16px; margin: 10px 0 5px 0;">
                    <fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫
                </p>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang: Tự nhận diện cả endPage, maxPage hoặc mặc định 2 trang -->
    <div style="margin-top: 35px; text-align: center;">
        <c:set var="total" value="${not empty endPage ? endPage : (not empty maxPage ? maxPage : 2)}" />
        <c:forEach begin="1" end="${total}" var="i">
            <c:choose>
                <c:when test="${param.page == i || (empty param.page && i == 1)}">
                    <a href="<c:url value='/product?page=${i}'/>" style="display: inline-block; padding: 8px 16px; margin: 0 4px; background-color: #d70018; color: #fff; text-decoration: none; border-radius: 4px; font-weight: bold;">Trang ${i}</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/product?page=${i}'/>" style="display: inline-block; padding: 8px 16px; margin: 0 4px; background-color: #fff; border: 1px solid #ccc; color: #333; text-decoration: none; border-radius: 4px;">Trang ${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</body>
</html>