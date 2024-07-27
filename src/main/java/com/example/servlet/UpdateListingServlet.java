package com.example.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.example.utils.Database;
import com.example.model.Item;
import com.example.model.User;

@WebServlet("/UpdateListing")
@MultipartConfig
public class UpdateListingServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads"; // Directory to save uploaded files

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        String categoryParam = request.getParameter("category");
        String description = request.getParameter("description");
        String condition = request.getParameter("condition");
        Part photo = request.getPart("photo");

        if (categoryParam == null || description == null || condition == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/updateListing.jsp").forward(request, response);
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
        String photoUrl = savePhoto(photo, request);

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        try (Connection conn = Database.getConnection()) {
            String sql = "UPDATE Items SET category = ?, description = ?, item_condition = ?, photo_url = ? WHERE item_id = ? AND user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, category.name());
            stmt.setString(2, description);
            stmt.setString(3, condition);
            stmt.setString(4, photoUrl);
            stmt.setInt(5, itemId);
            stmt.setInt(6, currentUser.getUserId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        response.sendRedirect("MyListings");
    }

    private String savePhoto(Part photo, HttpServletRequest request) throws IOException {
        if (photo == null || photo.getSize() == 0) {
            // If no photo was uploaded, return the current photo URL (you'll need to fetch it from the database)
            return getCurrentPhotoUrl(request);
        }

        String fileName = UUID.randomUUID().toString() + "_" + photo.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

        // Create the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the file on disk
        photo.write(uploadPath + File.separator + fileName);

        // Return the relative path of the uploaded file
        return UPLOAD_DIRECTORY + "/" + fileName;
    }

    private String getCurrentPhotoUrl(HttpServletRequest request) {
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        String photoUrl = null;

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT photo_url FROM Items WHERE item_id = ? AND user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.setInt(2, currentUser.getUserId());
            var rs = stmt.executeQuery();

            if (rs.next()) {
                photoUrl = rs.getString("photo_url");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return photoUrl;
    }
}
