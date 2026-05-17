package com.guitar.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.guitar.config.DBConfig;
import com.guitar.model.GuitarModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<GuitarModel> guitars = new ArrayList<>();

        String search = request.getParameter("search");

        String query;

        if (search != null && !search.trim().isEmpty()) {
            query = "SELECT * FROM guitars WHERE brand LIKE ? OR model LIKE ? OR category LIKE ?";
        } else {
            query = "SELECT * FROM guitars";
        }

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(1, "%" + search + "%");
                stmt.setString(2, "%" + search + "%");
                stmt.setString(3, "%" + search + "%");
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                GuitarModel g = new GuitarModel();

                g.setGuitarId(rs.getInt("guitar_id"));
                g.setBrand(rs.getString("brand"));
                g.setModel(rs.getString("model"));
                g.setPrice(rs.getDouble("price"));
                g.setStock(rs.getInt("stock"));
                g.setImage(rs.getString("image"));

                g.setDiscount(rs.getInt("discount"));
                g.setCategory(rs.getString("category"));
                g.setFeatured(rs.getString("featured"));

                guitars.add(g);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("guitars", guitars);
        request.setAttribute("search", search);

        request.getRequestDispatcher("/WEB-INF/pages/inventory.jsp")
               .forward(request, response);
    }
}