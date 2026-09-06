package vn.iotstar.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/image" })
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Thư mục lưu file upload trên ổ cứng
    public static final String UPLOAD_DIR = "C:/upload";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }

        File file = new File(UPLOAD_DIR, fileName);
        if (file.exists()) {
            String mimeType = getServletContext().getMimeType(fileName);
            if (mimeType == null) {
                mimeType = "application/octet-stream";
            }
            resp.setContentType(mimeType);
            resp.setContentLengthLong(file.length());

            try (FileInputStream in = new FileInputStream(file)) {
                // Sử dụng hàm transferTo có sẵn từ Java 9+ thay cho IOUtils
                in.transferTo(resp.getOutputStream());
            }
        }
    }
}