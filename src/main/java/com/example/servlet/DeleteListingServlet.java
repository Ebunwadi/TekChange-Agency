package com.example.servlet;

import com.example.utils.Database;
import com.example.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/DeleteListing")
public class DeleteListingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        try (Connection conn = Database.getConnection()) {
            String sql = "DELETE FROM Items WHERE item_id = ? AND user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.setInt(2, currentUser.getUserId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        response.sendRedirect("MyListings");
    }
}
