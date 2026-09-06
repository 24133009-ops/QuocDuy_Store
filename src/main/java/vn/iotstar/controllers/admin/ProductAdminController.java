package vn.iotstar.controllers.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.daos.impl.CategoryDaoImpl;
import vn.iotstar.daos.impl.ProductDaoImpl;
import vn.iotstar.entities.Category;
import vn.iotstar.entities.Product;
import vn.iotstar.utils.Constant;

@MultipartConfig
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert", "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
public class ProductAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDaoImpl productDao = new ProductDaoImpl();
    private CategoryDaoImpl categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/products")) {
            req.setAttribute("listProduct", productDao.findAll());
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/add")) {
            req.setAttribute("categories", categoryDao.findAll());
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("product", productDao.findById(id));
            req.setAttribute("categories", categoryDao.findAll());
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else if (uri.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            productDao.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("/admin/product/insert")) {
            String name = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            String desc = req.getParameter("description");
            int cateId = Integer.parseInt(req.getParameter("categoryId"));

            Product p = new Product();
            p.setProductName(name);
            p.setPrice(price);
            p.setDescription(desc);
            p.setCategory(categoryDao.findById(cateId));

            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String fname = System.currentTimeMillis() + "_" + filename;
                part.write(Constant.DIR + File.separator + fname);
                p.setImages(fname);
            }
            productDao.insert(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
        if (uri.contains("/admin/product/update")) {
            int id = Integer.parseInt(req.getParameter("productId"));
            Product p = productDao.findById(id);
            p.setProductName(req.getParameter("productName"));
            p.setPrice(Double.parseDouble(req.getParameter("price")));
            p.setDescription(req.getParameter("description"));
            p.setCategory(categoryDao.findById(Integer.parseInt(req.getParameter("categoryId"))));

            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String fname = System.currentTimeMillis() + "_" + filename;
                part.write(Constant.DIR + File.separator + fname);
                p.setImages(fname);
            }
            productDao.update(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}