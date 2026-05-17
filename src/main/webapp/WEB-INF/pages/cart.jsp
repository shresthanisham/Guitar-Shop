<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.guitar.model.CartItem" %>
<%@ page import="com.guitar.model.UserModel" %>

<%
    UserModel user = (UserModel) session.getAttribute("loggedInUser");
    ArrayList<CartItem> cart =
            (ArrayList<CartItem>) session.getAttribute("cart");

    double total = 0;

    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cart | Guitar Shop</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/home.css">
</head>

<body>

<nav class="navbar">

    <div class="logo">🎸 Guitar Shop</div>

    <div class="nav-right">

        <span class="profile-text">
            Welcome, <%= user.getEmail() %>
        </span>

        <a href="${pageContext.request.contextPath}/inventory">
            Inventory
        </a>

        <a href="${pageContext.request.contextPath}/home">
            Home
        </a>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

</nav>

<main class="cart-page">

    <section class="cart-header">

        <h1>🛒 Your Cart</h1>

        <p>
            Review your selected guitars before checkout.
        </p>

    </section>

    <section class="cart-box">

        <% if (cart != null && !cart.isEmpty()) { %>

            <table class="cart-table">

                <thead>

                    <tr>
                        <th>No.</th>
                        <th>Guitar</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>After Discount</th>
                        <th>Action</th>
                    </tr>

                </thead>

                <tbody>

                    <% for (int i = 0; i < cart.size(); i++) {

                        CartItem item = cart.get(i);

                        double price = item.getPrice();
                        int discount = item.getDiscount();

                        double discountAmount =
                                price * discount / 100;

                        double finalPrice =
                                price - discountAmount;

                        total += finalPrice;
                    %>

                    <tr>

                        <td><%= i + 1 %></td>

                        <td>
                            <%= item.getGuitarName() %>
                        </td>

                        <td>
                            Rs. <%= price %>
                        </td>

                        <td>
                            <%= discount %>%
                        </td>

                        <td>
                            Rs. <%= finalPrice %>
                        </td>

                        <td>

                            <a class="remove-btn"
                               href="${pageContext.request.contextPath}/removeFromCart?index=<%= i %>">

                               Remove

                            </a>

                        </td>

                    </tr>

                    <% } %>

                </tbody>

            </table>

            <div class="cart-summary">

                <h2>
                    Total Price After Discount:
                    Rs. <%= total %>
                </h2>

                <a class="continue-btn"
                   href="${pageContext.request.contextPath}/inventory">

                    Continue Shopping

                </a>

            </div>

        <% } else { %>

            <div class="empty-cart">

                <h2>Your cart is empty.</h2>

                <p>
                    Add guitars from the inventory page.
                </p>

                <a class="continue-btn"
                   href="${pageContext.request.contextPath}/inventory">

                    Go to Inventory

                </a>

            </div>

        <% } %>

    </section>

</main>

<script>

window.onload = function () {

    <% if ("removed".equals(message)) { %>
        alert("Item removed from cart successfully!");
    <% } %>

};

</script>

</body>
</html>