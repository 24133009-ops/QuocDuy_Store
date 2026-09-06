<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Chi tiết sản phẩm</title></head>
<body>
    <h2>Chi tiết sản phẩm: ${product.productName}</h2>
    <img src="<c:url value='/image?fname=${product.images}'/>" width="250" height="200"/><br>
    <p><b>Giá:</b> <span style="color: red;">${product.price} VNĐ</span></p>
    <p><b>Danh mục:</b> ${product.category.categoryname}</p>
    <p><b>Mô tả:</b> ${product.description}</p>
    <p><b>Ngày đăng:</b> ${product.createDate}</p>
    <a href="javascript:history.back()">Quay lại</a>
</body>
</html>