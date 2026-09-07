<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'Quốc Duy Store'}</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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
            font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text", "Segoe UI", Roboto, sans-serif;
            -webkit-font-smoothing: antialiased;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

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
        }

        .user-chip-avatar {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            object-fit: cover;
        }

        main.content-area {
            flex: 1;
            padding: 40px 16px;
        }
    </style>
</head>
<body>

    <!-- Apple Top Bar -->
    <nav class="navbar navbar-expand-lg apple-navbar sticky-top">
        <div class="container" style="max-width: 1000px;">
            <a class="navbar-brand" href="<c:url value='/home'/>">
                <i class="bi bi-apple fs-5"></i>
                <span>Quốc Duy Store</span>
            </a>

            <div class="collapse navbar-collapse show">
                <ul class="navbar-nav me-auto ms-lg-4">
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/home'/>">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="<c:url value='/admin/categories'/>">Quản lý Admin</a></li>
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

    <main class="content-area">