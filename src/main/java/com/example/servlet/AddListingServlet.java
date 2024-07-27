package com.example.servlet;

import com.example.utils.Database;
import com.example.model.Item;
import com.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AddListing")
@MultipartConfig
public class AddListingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryParam = request.getParameter("category");
        String description = request.getParameter("description");
        String condition = request.getParameter("condition");
        Part photo = request.getPart("photo");

        if (categoryParam == null || description == null || condition == null || photo == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/addListing.jsp").forward(request, response);
            return;
        }

        Item.Category category;
        try {
            category = Item.Category.valueOf(categoryParam.toUpperCase());
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid category.");
            request.getRequestDispatcher("/addListing.jsp").forward(request, response);
            return;
        }

        String photoUrl = savePhoto(photo);

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        try (Connection conn = Database.getConnection()) {
            String sql = "INSERT INTO Items (user_id, category, description, item_condition, photo_url) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, currentUser.getUserId());
            stmt.setString(2, category.name());
            stmt.setString(3, description);
            stmt.setString(4, condition);
            stmt.setString(5, photoUrl);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        response.sendRedirect("MyListings");
    }

    private String savePhoto(Part photo) throws IOException {
        String fileName = Paths.get(photo.getSubmittedFileName()).getFileName().toString();
        String uploadDir = getServletContext().getRealPath("/") + "uploads";
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }
        String filePath = uploadDir + File.separator + fileName;
        photo.write(filePath);
        return "uploads/" + fileName;
    }
}
