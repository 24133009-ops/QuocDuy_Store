package vn.iotstar.controllers;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.iotstar.daos.impl.ProductDaoImpl;
import vn.iotstar.entities.Product;

@WebServlet(urlPatterns = { "/home", "/" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDaoImpl productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> top10 = productDao.getTop10Latest();
        req.setAttribute("top10Products", top10);
        req.getRequestDispatcher("/views/web/home.jsp").forward(req, resp);
    }
}