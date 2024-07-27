package com.example.servlet;

import com.example.utils.Database;
import com.example.model.Item;
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

@WebServlet("/BrowseListings")
public class BrowseListingsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Item> items = new ArrayList<>();
        List<Integer> expressedInterestItems = new ArrayList<>();
        List<Integer> completedExchangeItems = new ArrayList<>();

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT i.item_id, i.description, i.item_condition, i.photo_url, i.category, i.user_id, " +
                    "e.status, u.username AS interested_username " +
                    "FROM Items i LEFT JOIN Exchanges e ON i.item_id = e.item_id " +
                    "LEFT JOIN Users u ON e.interested_user_id = u.user_id " +
                    "WHERE i.user_id <> ? OR e.interested_user_id IS NULL";
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
                items.add(item);

                String status = rs.getString("status");
                if ("Pending".equals(status)) {
                    expressedInterestItems.add(rs.getInt("item_id"));
                } else if ("Completed".equals(status)) {
                    completedExchangeItems.add(rs.getInt("item_id"));
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        request.setAttribute("items", items);
        request.setAttribute("expressedInterestItems", expressedInterestItems);
        request.setAttribute("completedExchangeItems", completedExchangeItems);
        request.getRequestDispatcher("browseListings.jsp").forward(request, response);
    }
}
