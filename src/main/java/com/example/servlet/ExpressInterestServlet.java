package com.example.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.utils.Database;
import com.example.model.User;

@WebServlet("/ExpressInterest")
public class ExpressInterestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        try (Connection conn = Database.getConnection()) {
            String sql = "INSERT INTO Exchanges (item_id, interested_user_id, status) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.setInt(2, currentUser.getUserId());
            stmt.setString(3, "Pending");
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        response.sendRedirect("expressInterest.jsp");
    }

    public boolean isInterestExpressed(int itemId, int userId) throws ServletException {
        // Implement the method to check if interest is already expressed
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT COUNT(*) FROM Exchanges WHERE item_id = ? AND interested_user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.setInt(2, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
        return false;
    }
}
