<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Nạp Header Apple -->
<jsp:include page="/common/header.jsp">
    <jsp:param name="title" value="Hồ sơ cá nhân - Quốc Duy ID" />
</jsp:include>

<style>
    .apple-card {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(25px);
        -webkit-backdrop-filter: blur(25px);
        border: 1px solid rgba(0, 0, 0, 0.08);
        border-radius: 24px;
        padding: 40px;
        box-shadow: 0 16px 36px rgba(0, 0, 0, 0.04);
    }

    .avatar-wrapper {
        position: relative;
        width: 110px;
        height: 110px;
        margin: 0 auto 20px;
        cursor: pointer;
    }

    .avatar-img {
        width: 110px;
        height: 110px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #ffffff;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s ease;
    }

    .avatar-overlay {
        position: absolute;
        inset: 0;
        border-radius: 50%;
        background: rgba(0, 0, 0, 0.35);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #ffffff;
        font-size: 20px;
        opacity: 0;
        transition: opacity 0.2s ease;
    }

    .avatar-wrapper:hover .avatar-overlay { opacity: 1; }
    .avatar-wrapper:hover .avatar-img { transform: scale(1.02); }

    .apple-input-box {
        width: 100%;
        height: 48px;
        border-radius: 12px;
        border: 1px solid #d2d2d7;
        padding: 0 16px;
        font-size: 15px;
        outline: none;
        transition: border-color 0.2s ease;
    }

    .apple-input-box:focus {
        border-color: #0071e3;
        box-shadow: 0 0 0 4px rgba(0, 113, 227, 0.12);
    }

    .apple-input-box.readonly-box {
        background-color: #f5f5f7;
        color: #86868b;
        cursor: not-allowed;
    }

    .apple-btn {
        width: 100%;
        height: 48px;
        border-radius: 980px;
        background: #0071e3;
        color: #ffffff;
        font-size: 15px;
        font-weight: 500;
        border: none;
        cursor: pointer;
        transition: background 0.2s ease;
    }
    .apple-btn:hover { background: #0077ed; }

    .invalid-feedback-custom {
        color: #ff3b30;
        font-size: 12px;
        margin-top: 5px;
        display: none;
    }
</style>

<div class="container" style="max-width: 600px;">
    <div class="apple-card">

        <div class="text-center mb-4">
            <h2 class="fw-bold" style="letter-spacing: -0.02em;">Quốc Duy ID & Hồ Sơ</h2>
            <p class="text-muted small">Xem và cập nhật thông tin nhận diện tài khoản của bạn</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show rounded-4 border-0 shadow-sm mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show rounded-4 border-0 shadow-sm mb-4" role="alert">
                <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form id="profileForm" action="<c:url value='/user/profile'/>" method="post" enctype="multipart/form-data" novalidate>

            <!-- Click để đổi Avatar -->
            <div class="avatar-wrapper" onclick="document.getElementById('avatarFile').click();" title="Bấm để đổi ảnh đại diện">
                <c:choose>
                    <c:when test="${not empty user.images}">
                        <img id="avatarPreview" src="<c:url value='${user.images}'/>" class="avatar-img">
                    </c:when>
                    <c:otherwise>
                        <img id="avatarPreview" src="<c:url value='/assets/avatar.png'/>" class="avatar-img">
                    </c:otherwise>
                </c:choose>
                <div class="avatar-overlay">
                    <i class="bi bi-camera-fill"></i>
                </div>
            </div>
            <input type="file" id="avatarFile" name="image" accept="image/*" style="display: none;" onchange="previewImage(this)">

            <div class="mb-3 text-start">
                <label class="form-label small fw-semibold text-muted">Địa chỉ Email (Quốc Duy ID)</label>
                <input type="text" class="apple-input-box readonly-box" value="${user.email}" readonly>
            </div>

            <div class="mb-3 text-start">
                <label class="form-label small fw-semibold text-dark">Họ và tên <span class="text-danger">*</span></label>
                <input type="text" id="fullname" name="fullname" class="apple-input-box" value="${user.fullname}" placeholder="Nhập họ và tên...">
                <div id="fullnameErr" class="invalid-feedback-custom">Vui lòng không để trống họ và tên!</div>
            </div>

            <div class="mb-4 text-start">
                <label class="form-label small fw-semibold text-dark">Số điện thoại liên hệ</label>
                <input type="tel" id="phone" name="phone" class="apple-input-box" value="${user.phone}" placeholder="VD: 0912345678">
                <div id="phoneErr" class="invalid-feedback-custom">Số điện thoại phải gồm 10 chữ số (đầu 03, 05, 07, 08, 09)!</div>
            </div>

            <button type="submit" class="apple-btn shadow-sm">
                Lưu thay đổi
            </button>
        </form>

    </div>
</div>

<script>
    function previewImage(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('avatarPreview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    // Client-side Validation chuẩn Apple UI
    document.getElementById('profileForm').addEventListener('submit', function(event) {
        let isValid = true;
        const fullname = document.getElementById('fullname').value.trim();
        const phone = document.getElementById('phone').value.trim();

        if (fullname === "") {
            document.getElementById('fullnameErr').style.display = "block";
            document.getElementById('fullname').style.borderColor = "#ff3b30";
            isValid = false;
        } else {
            document.getElementById('fullnameErr').style.display = "none";
            document.getElementById('fullname').style.borderColor = "#d2d2d7";
        }

        const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
        if (phone !== "" && !phoneRegex.test(phone)) {
            document.getElementById('phoneErr').style.display = "block";
            document.getElementById('phone').style.borderColor = "#ff3b30";
            isValid = false;
        } else {
            document.getElementById('phoneErr').style.display = "none";
            document.getElementById('phone').style.borderColor = "#d2d2d7";
        }

        if (!isValid) {
            event.preventDefault();
        }
    });
</script>

<!-- Nạp Footer Apple -->
<jsp:include page="/common/footer.jsp" />