package com.guitar.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.guitar.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(request.getContextPath() + "/inventory");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String guitarName = request.getParameter("guitarName");
        String priceValue = request.getParameter("price");
        String discountValue = request.getParameter("discount");

        if (guitarName == null || guitarName.trim().isEmpty()
                || priceValue == null || priceValue.trim().isEmpty()) {

            response.sendRedirect(request.getContextPath() + "/inventory");
            return;
        }

        try {
            double price = Double.parseDouble(priceValue);

            int discount = 0;

            if (discountValue != null && !discountValue.trim().isEmpty()) {
                discount = Integer.parseInt(discountValue);
            }

            ArrayList<CartItem> cart =
                    (ArrayList<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            CartItem item = new CartItem(guitarName, price, discount);
            cart.add(item);

            session.setAttribute("cart", cart);

            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/inventory");
        }
    }
}