package vn.iotstar.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.entities.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.services.impl.UserServiceImpl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(urlPatterns = {"/user/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("account");
        if (sessionUser == null) {
            sessionUser = (User) session.getAttribute("user");
        }

        // Nếu chưa đăng nhập thì chuyển hướng về login
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy dữ liệu mới nhất từ CSDL qua Email, dự phòng bằng sessionUser nếu DB chưa nạp kịp
        User user = null;
        try {
            user = userService.getByEmail(sessionUser.getEmail());
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (user == null) {
            user = sessionUser;
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("account");
        if (sessionUser == null) {
            sessionUser = (User) session.getAttribute("user");
        }

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        Part filePart = req.getPart("image");

        User user = null;
        try {
            user = userService.getByEmail(sessionUser.getEmail());
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (user == null) {
            user = sessionUser;
        }

        // 1. Kiểm tra họ và tên không được để trống
        if (fullname == null || fullname.trim().isEmpty()) {
            req.setAttribute("error", "Họ và tên không được để trống!");
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra định dạng số điện thoại Việt Nam (10 số, đầu 03, 05, 07, 08, 09)
        String phoneRegex = "^(0[3|5|7|8|9])+([0-9]{8})$";
        if (phone != null && !phone.trim().isEmpty() && !phone.trim().matches(phoneRegex)) {
            req.setAttribute("error", "Số điện thoại không hợp lệ! Vui lòng nhập 10 chữ số (đầu 03, 05, 07, 08, 09).");
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
            return;
        }

        user.setFullname(fullname.trim());
        user.setPhone(phone != null ? phone.trim() : "");

        // 3. Xử lý upload ảnh multipart
        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().trim().isEmpty()) {
            String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String lowerName = originalFileName.toLowerCase();

            if (!lowerName.endsWith(".jpg") && !lowerName.endsWith(".jpeg") &&
                    !lowerName.endsWith(".png") && !lowerName.endsWith(".webp")) {
                req.setAttribute("error", "Chỉ chấp nhận định dạng ảnh PNG, JPG, JPEG hoặc WEBP!");
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
                return;
            }

            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String newFileName = "user_" + System.currentTimeMillis() + fileExtension;

            // Thư mục lưu trữ: uploads
            String uploadPath = req.getServletContext().getRealPath("/uploads");
            if (uploadPath == null) {
                uploadPath = "C:/upload";
            }
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath + File.separator + newFileName);
            user.setImages("/uploads/" + newFileName);
        }

        // Cập nhật xuống CSDL qua JPA
        try {
            userService.updateProfile(user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Đồng bộ lại dữ liệu trong Session
        session.setAttribute("account", user);
        session.setAttribute("user", user);

        req.setAttribute("message", "Cập nhật hồ sơ Quốc Duy ID thành công!");
        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/web/profile.jsp").forward(req, resp);
    }
}