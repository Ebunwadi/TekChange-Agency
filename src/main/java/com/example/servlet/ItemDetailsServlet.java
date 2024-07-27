package com.example.servlet;

import com.example.utils.Database;
import com.example.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/ItemDetails")
public class ItemDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        Item item = null;

        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM Items WHERE item_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                item = new Item();
                item.setItemId(rs.getInt("item_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setCategory(Item.Category.valueOf(rs.getString("category")));
                item.setDescription(rs.getString("description"));
                item.setCondition(rs.getString("item_condition"));
                item.setPhotoUrl(rs.getString("photo_url"));
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        if (item == null) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("item", item);
            request.getRequestDispatcher("/itemDetails.jsp").forward(request, response);
        }
    }
}
