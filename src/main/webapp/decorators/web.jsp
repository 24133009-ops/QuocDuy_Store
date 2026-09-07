<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quốc Duy Store</title>

    <!-- Bootstrap 5 & Apple Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="icon" type="image/png" href="<c:url value='/assets/avatar.png'/>">

    <style>
        :root {
            --apple-bg: #f5f5f7;
            --apple-nav: rgba(255, 255, 255, 0.82);
            --apple-text: #1d1d1f;
            --apple-subtext: #86868b;
            --apple-blue: #0071e3;
            --apple-blue-hover: #0077ed;
            --apple-border: rgba(0, 0, 0, 0.08);
        }

        body {
            background-color: var(--apple-bg);
            color: var(--apple-text);
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Topbar kính mờ hiệu ứng macOS/iOS */
        .apple-navbar {
            background: var(--apple-nav);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--apple-border);
            height: 54px;
        }

        .navbar-brand {
            font-weight: 600;
            font-size: 17px;
            letter-spacing: -0.01em;
            color: var(--apple-text) !important;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link {
            font-size: 13px;
            color: var(--apple-text) !important;
            opacity: 0.8;
            padding: 8px 16px !important;
            transition: opacity 0.2s ease;
        }
        .nav-link:hover { opacity: 1; }

        /* User Chip bo tròn */
        .user-chip {
            background: rgba(0, 0, 0, 0.04);
            border: 1px solid var(--apple-border);
            border-radius: 980px;
            padding: 4px 14px 4px 6px;
            text-decoration: none;
            color: var(--apple-text) !important;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            font-weight: 500;
            transition: background 0.2s ease;
        }
        .user-chip:hover { background: rgba(0, 0, 0, 0.08); }

        .user-chip-avatar {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            object-fit: cover;
        }

        /* Thẻ nội dung chính */
        main.content-area {
            flex: 1;
            padding-top: 30px;
            padding-bottom: 50px;
        }

        /* Chân trang */
        footer.apple-footer {
            background: #f5f5f7;
            border-top: 1px solid var(--apple-border);
            padding: 24px 0;
            color: var(--apple-subtext);
            font-size: 12px;
            text-align: center;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <!-- Apple Navigation Bar -->
    <nav class="navbar navbar-expand-lg apple-navbar sticky-top">
        <div class="container" style="max-width: 1000px;">
            <a class="navbar-brand" href="<c:url value='/home'/>">
                <i class="bi bi-apple fs-5"></i>
                <span>Quốc Duy Store</span>
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#appleNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="appleNav">
                <ul class="navbar-nav me-auto ms-lg-4 mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/home'/>">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/product'/>">Sản phẩm</a></li>
                    <c:if test="${sessionScope.account.status == 1}">
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/admin/categories'/>">Quản lý Admin</a></li>
                    </c:if>
                </ul>

                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <div class="dropdown">
                                <a href="#" class="user-chip dropdown-toggle" data-bs-toggle="dropdown">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.account.images}">
                                            <img src="<c:url value='${sessionScope.account.images}'/>" class="user-chip-avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="<c:url value='/assets/avatar.png'/>" class="user-chip-avatar">
                                        </c:otherwise>
                                    </c:choose>
                                    <span>${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.email}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 rounded-4 mt-2 p-2">
                                    <li><a class="dropdown-item rounded-3 py-2" href="<c:url value='/user/profile'/>"><i class="bi bi-person-gear me-2"></i>Hồ sơ cá nhân</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item rounded-3 py-2 text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/login'/>" class="btn btn-primary rounded-pill px-4 py-1" style="font-size: 13px; background-color: var(--apple-blue);">
                                Đăng nhập
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Nơi mã nguồn của các file JSP con được bơm vào -->
    <main class="content-area">
        <sitemesh:write property='body'/>
    </main>

    <!-- Apple Footer -->
    <footer class="apple-footer">
        <div class="container">
            <p class="mb-1">Bản quyền © 2026 Quốc Duy Store Inc. Bảo lưu mọi quyền.</p>
            <p class="mb-0 text-muted" style="font-size: 11px;">Thiết kế tích hợp JPA, Servlet, SiteMesh Decorator 3 & Apple Human Interface.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>