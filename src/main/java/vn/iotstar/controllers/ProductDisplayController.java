package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.daos.impl.ProductDaoImpl;
import vn.iotstar.entities.Product;

@WebServlet(urlPatterns = { "/product", "/product/detail" })
public class ProductDisplayController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDaoImpl productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/product/detail")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productDao.findById(id);
            req.setAttribute("product", product);
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
        } else {
            int page = 1;
            int pageSize = 6;
            if (req.getParameter("page") != null) {
                page = Integer.parseInt(req.getParameter("page"));
            }
            List<Product> list = productDao.findAllPaging(page, pageSize);
            int totalProducts = productDao.countTotalProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            req.setAttribute("productList", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("/views/web/products.jsp").forward(req, resp);
        }
    }
}