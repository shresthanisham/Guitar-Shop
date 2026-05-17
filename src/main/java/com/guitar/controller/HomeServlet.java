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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public HomeServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<GuitarModel> guitars = new ArrayList<>();
        String search = request.getParameter("search");

        String query;

        if (search != null && !search.trim().isEmpty()) {
            query = "SELECT * FROM guitars WHERE brand LIKE ? OR model LIKE ?";
        } else {
            query = "SELECT * FROM guitars";
        }

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(1, "%" + search + "%");
                stmt.setString(2, "%" + search + "%");
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                GuitarModel guitar = new GuitarModel();
                guitar.setGuitarId(rs.getInt("guitar_id"));
                guitar.setBrand(rs.getString("brand"));
                guitar.setModel(rs.getString("model"));
                guitar.setPrice(rs.getDouble("price"));
                guitar.setStock(rs.getInt("stock"));
                guitar.setImage(rs.getString("image"));

                guitars.add(guitar);
            }

            request.setAttribute("guitars", guitars);
            request.setAttribute("search", search);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load guitars.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/home.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}