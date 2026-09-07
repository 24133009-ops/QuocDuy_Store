package vn.iotstar.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.daos.impl.UserDaoImpl;
import vn.iotstar.entities.User;
import vn.iotstar.utils.EmailUtil;

@WebServlet(urlPatterns = { "/register", "/verify-otp", "/login", "/forgot-password", "/reset-password", "/logout" })
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.contains("/register")) {
            req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
        } else if (uri.contains("/verify-otp")) {
            req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
        } else if (uri.contains("/login")) {
            // Kiểm tra session đã đăng nhập
            HttpSession session = req.getSession(false);
            if (session != null && (session.getAttribute("account") != null || session.getAttribute("user") != null)) {
                resp.sendRedirect(req.getContextPath() + "/user/profile");
                return;
            }

            // Xử lý thông báo chuyển tiếp qua tham số URL
            String msg = req.getParameter("msg");
            if ("activated".equals(msg)) {
                req.setAttribute("message", "Tài khoản Quốc Duy ID đã kích hoạt thành công. Vui lòng đăng nhập!");
            } else if ("reset_success".equals(msg)) {
                req.setAttribute("message", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập bằng mật khẩu mới!");
            }

            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        } else if (uri.contains("/forgot-password")) {
            req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
        } else if (uri.contains("/reset-password")) {
            req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
        } else if (uri.contains("/logout")) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        // 1. Đăng ký & Gửi OTP kích hoạt
        if (uri.contains("/register")) {
            String email = req.getParameter("email");
            String fullname = req.getParameter("fullname");
            String password = req.getParameter("password");

            if (email != null) email = email.trim();
            if (fullname != null) fullname = fullname.trim();

            try {
                User existingUser = userDao.findByEmail(email);
                if (existingUser != null) {
                    req.setAttribute("error", "Email này đã được đăng ký trên Quốc Duy ID!");
                    req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
                    return;
                }

                String otp = EmailUtil.generateOtp();
                User newUser = new User(email, fullname, password, 0, otp);
                userDao.insert(newUser);

                try {
                    EmailUtil.sendEmail(email, "Mã kích hoạt Quốc Duy ID", "<h3>Mã OTP kích hoạt tài khoản của bạn là: <b>" + otp + "</b></h3>");
                } catch (Exception e) {
                    e.printStackTrace();
                }

                req.getSession().setAttribute("verifyEmail", email);
                resp.sendRedirect(req.getContextPath() + "/verify-otp");
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
                req.getRequestDispatcher("/views/auth/register.jsp").forward(req, resp);
            }
        }

        // 2. Kích hoạt tài khoản bằng OTP
        else if (uri.contains("/verify-otp")) {
            String otp = req.getParameter("otp");
            String email = (String) req.getSession().getAttribute("verifyEmail");

            if (email == null) {
                resp.sendRedirect(req.getContextPath() + "/register");
                return;
            }

            try {
                User user = userDao.findByEmail(email);
                if (user != null && otp != null && otp.trim().equals(user.getOtp())) {
                    user.setStatus(1);
                    user.setOtp(null);
                    userDao.update(user);
                    req.getSession().removeAttribute("verifyEmail");
                    resp.sendRedirect(req.getContextPath() + "/login?msg=activated");
                } else {
                    req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
                    req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
            }
        }

        // 3. Đăng nhập
        else if (uri.contains("/login")) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            if (email != null) email = email.trim();
            if (password != null) password = password.trim();

            try {
                User user = (email != null) ? userDao.findByEmail(email) : null;

                if (user == null || !user.getPassword().equals(password)) {
                    req.setAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
                    req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
                } else if (user.getStatus() == 0) {
                    req.getSession().setAttribute("verifyEmail", email);
                    req.setAttribute("error", "Tài khoản chưa được kích hoạt! Vui lòng nhập OTP.");
                    req.getRequestDispatcher("/views/auth/verify-otp.jsp").forward(req, resp);
                } else {
                    HttpSession session = req.getSession();
                    session.setAttribute("account", user);
                    session.setAttribute("user", user);

                    resp.sendRedirect(req.getContextPath() + "/user/profile");
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Không thể kết nối SQL Server! Vui lòng kiểm tra lại cấu hình persistence.xml.");
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            }
        }

        // 4. Quên mật khẩu - gửi mã OTP
        else if (uri.contains("/forgot-password")) {
            String email = req.getParameter("email");
            if (email != null) email = email.trim();

            try {
                User user = (email != null) ? userDao.findByEmail(email) : null;
                if (user != null) {
                    String otp = EmailUtil.generateOtp();
                    user.setOtp(otp);
                    userDao.update(user);

                    try {
                        EmailUtil.sendEmail(email, "Mã OTP khôi phục mật khẩu Quốc Duy ID", "<h3>Mã OTP đặt lại mật khẩu của bạn là: <b>" + otp + "</b></h3>");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    req.getSession().setAttribute("resetEmail", email);
                    resp.sendRedirect(req.getContextPath() + "/reset-password");
                } else {
                    req.setAttribute("error", "Địa chỉ email không tồn tại trong hệ thống!");
                    req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
                req.getRequestDispatcher("/views/auth/forgot-password.jsp").forward(req, resp);
            }
        }

        // 5. Đặt lại mật khẩu mới
        else if (uri.contains("/reset-password")) {
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");
            String email = (String) req.getSession().getAttribute("resetEmail");

            if (email == null) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }

            try {
                User user = userDao.findByEmail(email);
                if (user != null && otp != null && otp.trim().equals(user.getOtp())) {
                    user.setPassword(newPassword);
                    user.setOtp(null);
                    userDao.update(user);
                    req.getSession().removeAttribute("resetEmail");
                    resp.sendRedirect(req.getContextPath() + "/login?msg=reset_success");
                } else {
                    req.setAttribute("error", "Mã OTP không hợp lệ!");
                    req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
                req.getRequestDispatcher("/views/auth/reset-password.jsp").forward(req, resp);
            }
        }
    }
}git status