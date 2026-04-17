package com.guitar.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.guitar.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 🔹 Load register page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
               .forward(request, response);
    }

    // 🔹 Handle register form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 🔹 Password match check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                   .forward(request, response);
            return;
        }

        String query = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3, "user");

            int result = stmt.executeUpdate();

            if (result > 0) {
                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                       .forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp")
                   .forward(request, response);
        }
    }
}