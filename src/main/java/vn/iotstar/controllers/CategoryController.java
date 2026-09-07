package vn.iotstar.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.daos.impl.CategoryDaoImpl;
import vn.iotstar.entities.Category;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(urlPatterns = {
        "/admin/categories",
        "/admin/category/add",
        "/admin/category/insert",
        "/admin/category/edit",
        "/admin/category/update",
        "/admin/category/delete"
})
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDaoImpl cateDao = new CategoryDaoImpl();
    public static final String UPLOAD_DIR = "C:/upload";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/admin/categories")) {
            List<Category> list = cateDao.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (uri.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (uri.contains("/admin/category/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = cateDao.findById(id);
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            }
        } else if (uri.contains("/admin/category/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                cateDao.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        // 1. Thêm danh mục mới
        if (uri.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusParam = req.getParameter("status");
            String imageUrl = req.getParameter("images");
            Part part = req.getPart("images1");

            // --- SERVER-SIDE VALIDATION ---
            if (categoryname == null || categoryname.trim().isEmpty()) {
                req.setAttribute("error", "Tên danh mục thiết bị không được để trống!");
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra định dạng file nếu có upload ảnh
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString().toLowerCase();
                if (!filename.endsWith(".jpg") && !filename.endsWith(".jpeg") && !filename.endsWith(".png") && !filename.endsWith(".webp")) {
                    req.setAttribute("error", "Chỉ chấp nhận file ảnh định dạng PNG, JPG, JPEG hoặc WEBP!");
                    req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                    return;
                }
            }

            int status = (statusParam != null) ? Integer.parseInt(statusParam) : 1;
            Category cate = new Category();
            cate.setCategoryname(categoryname.trim());
            cate.setStatus(status);

            // Ưu tiên 1: Tải file từ máy tính
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String originalFilename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = "category_" + System.currentTimeMillis() + ext;

                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                part.write(UPLOAD_DIR + File.separator + newFilename);
                cate.setImages(newFilename);
            }
            // Ưu tiên 2: Nhập URL ảnh online
            else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                cate.setImages(imageUrl.trim());
            }

            cateDao.insert(cate);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
        // 2. Cập nhật danh mục
        else if (uri.contains("/admin/category/update")) {
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            String categoryname = req.getParameter("categoryname");
            String statusParam = req.getParameter("status");
            String imageUrl = req.getParameter("images");
            Part part = req.getPart("images1");

            Category cate = cateDao.findById(categoryId);

            // --- SERVER-SIDE VALIDATION ---
            if (categoryname == null || categoryname.trim().isEmpty()) {
                req.setAttribute("error", "Tên danh mục thiết bị không được để trống!");
                req.setAttribute("cate", cate);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra định dạng file nếu người dùng chọn upload ảnh mới
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString().toLowerCase();
                if (!filename.endsWith(".jpg") && !filename.endsWith(".jpeg") && !filename.endsWith(".png") && !filename.endsWith(".webp")) {
                    req.setAttribute("error", "Chỉ chấp nhận file ảnh định dạng PNG, JPG, JPEG hoặc WEBP!");
                    req.setAttribute("cate", cate);
                    req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                    return;
                }
            }

            int status = (statusParam != null) ? Integer.parseInt(statusParam) : cate.getStatus();
            cate.setCategoryname(categoryname.trim());
            cate.setStatus(status);

            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String originalFilename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = "category_" + System.currentTimeMillis() + ext;

                File uploadDir = new File(UPLOAD_DIR);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                part.write(UPLOAD_DIR + File.separator + newFilename);
                cate.setImages(newFilename);
            } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                cate.setImages(imageUrl.trim());
            }

            cateDao.update(cate);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }
}