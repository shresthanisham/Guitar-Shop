package com.guitar.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.guitar.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/removeFromCart")
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        ArrayList<CartItem> cart = (ArrayList<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            int index = Integer.parseInt(request.getParameter("index"));
            if (index >= 0 && index < cart.size()) {
                cart.remove(index);
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart?message=removed");
    }
}