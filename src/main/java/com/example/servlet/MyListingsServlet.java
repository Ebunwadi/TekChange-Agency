package com.example.servlet;

import com.example.utils.Database;
import com.example.model.Item;
import com.example.model.Notification;
import com.example.model.User;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/MyListings")
public class MyListingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Item> items = new ArrayList<>();
        List<Notification> notifications = new ArrayList<>();

        try (Connection conn = Database.getConnection()) {
            // Fetch the user's listings with status and interested username if applicable
            String sql = "SELECT i.item_id, i.description, i.item_condition, i.photo_url, i.category, i.user_id, " +
                    "e.status, e.interested_user_id, u.username AS interested_username " +
                    "FROM Items i " +
                    "LEFT JOIN Exchanges e ON i.item_id = e.item_id " +
                    "LEFT JOIN Users u ON e.interested_user_id = u.user_id " +
                    "WHERE i.user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, currentUser.getUserId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setDescription(rs.getString("description"));
                item.setCondition(rs.getString("item_condition"));
                item.setPhotoUrl(rs.getString("photo_url"));
                item.setCategory(Item.Category.valueOf(rs.getString("category")));
                item.setUserId(rs.getInt("user_id"));
                item.setStatus(rs.getString("status"));
                item.setInterestedUserId(rs.getInt("interested_user_id"));
                item.setInterestedUsername(rs.getString("interested_username"));
                items.add(item);
            }

            // Fetch notifications
            sql = "SELECT e.interested_user_id, u.username, u.email, e.item_id, i.description " +
                    "FROM Exchanges e " +
                    "JOIN Users u ON e.interested_user_id = u.user_id " +
                    "JOIN Items i ON e.item_id = i.item_id " +
                    "WHERE i.user_id = ? AND e.status = 'Pending'";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, currentUser.getUserId());
            rs = stmt.executeQuery();

            while (rs.next()) {
                Notification notification = new Notification();
                notification.setUserId(rs.getInt("interested_user_id"));
                notification.setUsername(rs.getString("username"));
                notification.setEmail(rs.getString("email"));
                notification.setItemId(rs.getInt("item_id"));
                notification.setItemDescription(rs.getString("description"));
                notifications.add(notification);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        request.setAttribute("items", items);
        request.setAttribute("notifications", notifications);
        request.getRequestDispatcher("myListings.jsp").forward(request, response);
    }
}
