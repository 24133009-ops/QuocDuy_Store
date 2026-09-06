<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<form action="<c:url value='/reset-password'/>" method="post">
    <h2>Đặt Lại Mật Khẩu</h2>
    <c:if test="${not empty error}"><p style="color:red;">${error}</p></c:if>
    <label>Mã OTP:</label><br><input type="text" name="otp" required><br>
    <label>Mật khẩu mới:</label><br><input type="password" name="newPassword" required><br><br>
    <input type="submit" value="Đổi mật khẩu">
</form>