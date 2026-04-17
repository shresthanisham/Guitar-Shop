package com.guitar.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.guitar.config.DBConfig;
import com.guitar.model.GuitarModel;
import com.guitar.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        UserModel user = (UserModel) session.getAttribute("loggedInUser");

        if (!"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("edit".equalsIgnoreCase(action)) {
                int guitarId = Integer.parseInt(request.getParameter("id"));
                GuitarModel editGuitar = getGuitarById(guitarId);
                request.setAttribute("editGuitar", editGuitar);
            } else if ("delete".equalsIgnoreCase(action)) {
                int guitarId = Integer.parseInt(request.getParameter("id"));
                deleteGuitar(guitarId);
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }

            List<GuitarModel> guitars = getAllGuitars();
            request.setAttribute("guitars", guitars);

            request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong.");
            request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) {
            return;
        }

        String action = request.getParameter("action");
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");

        try {
            if (brand == null || brand.trim().isEmpty() ||
                model == null || model.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                stockStr == null || stockStr.trim().isEmpty()) {

                request.setAttribute("error", "All fields are required.");
                request.setAttribute("guitars", getAllGuitars());
                request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp")
                       .forward(request, response);
                return;
            }

            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);

            if ("update".equalsIgnoreCase(action)) {
                int guitarId = Integer.parseInt(request.getParameter("guitarId"));
                updateGuitar(guitarId, brand, model, price, stock);
            } else {
                addGuitar(brand, model, price, stock);
            }

            response.sendRedirect(request.getContextPath() + "/admin");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            try {
                request.setAttribute("guitars", getAllGuitars());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp")
                   .forward(request, response);
        }
    }

    private List<GuitarModel> getAllGuitars() throws Exception {
        List<GuitarModel> guitars = new ArrayList<>();
        String query = "SELECT * FROM guitars";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                GuitarModel guitar = new GuitarModel();
                guitar.setGuitarId(rs.getInt("guitar_id"));
                guitar.setBrand(rs.getString("brand"));
                guitar.setModel(rs.getString("model"));
                guitar.setPrice(rs.getDouble("price"));
                guitar.setStock(rs.getInt("stock"));
                guitars.add(guitar);
            }
        }

        return guitars;
    }

    private GuitarModel getGuitarById(int guitarId) throws Exception {
        String query = "SELECT * FROM guitars WHERE guitar_id = ?";
        GuitarModel guitar = null;

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, guitarId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    guitar = new GuitarModel();
                    guitar.setGuitarId(rs.getInt("guitar_id"));
                    guitar.setBrand(rs.getString("brand"));
                    guitar.setModel(rs.getString("model"));
                    guitar.setPrice(rs.getDouble("price"));
                    guitar.setStock(rs.getInt("stock"));
                }
            }
        }

        return guitar;
    }

    private void addGuitar(String brand, String model, double price, int stock) throws Exception {
        String query = "INSERT INTO guitars (brand, model, price, stock) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, brand);
            stmt.setString(2, model);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);
            stmt.executeUpdate();
        }
    }

    private void updateGuitar(int guitarId, String brand, String model, double price, int stock) throws Exception {
        String query = "UPDATE guitars SET brand = ?, model = ?, price = ?, stock = ? WHERE guitar_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, brand);
            stmt.setString(2, model);
            stmt.setDouble(3, price);
            stmt.setInt(4, stock);
            stmt.setInt(5, guitarId);
            stmt.executeUpdate();
        }
    }

    private void deleteGuitar(int guitarId) throws Exception {
        String query = "DELETE FROM guitars WHERE guitar_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, guitarId);
            stmt.executeUpdate();
        }
    }
}