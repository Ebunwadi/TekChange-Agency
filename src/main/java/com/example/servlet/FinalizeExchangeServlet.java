package com.example.servlet;

import com.example.utils.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/FinalizeExchange")
public class FinalizeExchangeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        HttpSession session = request.getSession();

        try (Connection conn = Database.getConnection()) {
            // Update the exchange status
            String sql = "UPDATE Exchanges SET status = 'Completed' WHERE item_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            stmt.executeUpdate();

            // Get the usernames involved in the exchange
            sql = "SELECT e.item_id, i.user_id AS owner_id, u.username AS owner_username, " +
                    "e.interested_user_id, u2.username AS interested_username " +
                    "FROM Exchanges e " +
                    "JOIN Items i ON e.item_id = i.item_id " +
                    "JOIN Users u ON i.user_id = u.user_id " +
                    "JOIN Users u2 ON e.interested_user_id = u2.user_id " +
                    "WHERE e.item_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();

            String ownerUsername = null;
            String interestedUsername = null;

            if (rs.next()) {
                ownerUsername = rs.getString("owner_username");
                interestedUsername = rs.getString("interested_username");
            }

            // Set usernames in session to show in the listings page
            session.setAttribute("finalizedOwnerUsername", ownerUsername);
            session.setAttribute("finalizedInterestedUsername", interestedUsername);

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        response.sendRedirect("finalizeExchange.jsp");
    }
}
