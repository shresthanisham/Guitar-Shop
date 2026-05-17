<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.guitar.model.UserModel" %>
<%@ page import="com.guitar.model.GuitarModel" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    UserModel user = (UserModel) session.getAttribute("loggedInUser");
    boolean isAdmin = (user != null && "admin".equalsIgnoreCase(user.getRole()));

    ArrayList cart = (ArrayList) session.getAttribute("cart");
    int cartCount = (cart == null) ? 0 : cart.size();

    List<GuitarModel> guitars = (List<GuitarModel>) request.getAttribute("guitars");
    String search = (String) request.getAttribute("search");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">🎸 Guitar Shop</div>

    <form action="${pageContext.request.contextPath}/home" method="get" class="search-bar">
        <input type="text" name="search" placeholder="Search guitars..."
               value="<%= (search != null) ? search : "" %>">
        <button type="submit">🔍</button>
    </form>
    <div class="nav-right">
        <% if (user == null) { %>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
        <% } else { %>

            <span class="profile-text">👤 Welcome, <%= user.getEmail() %></span>

            <% if (isAdmin) { %>
                <a href="${pageContext.request.contextPath}/inventory" class="nav-btn">🎸 Inventory</a>
                <a href="${pageContext.request.contextPath}/admin" class="admin-btn">⚙️ Admin Dashboard</a>
            <% } else { %>
                
                <a href="${pageContext.request.contextPath}/cart" class="cart-btn">
                    🛒 Cart: <%= cartCount %>
                </a>
            <% } %>

            <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>

        <% } %>
    </div>
</nav>
<!-- BANNER -->
<section class="banner">

    <div class="banner-content">
        <h1>🎸 Discover Your Perfect Sound</h1>

        <p>
            Explore premium guitars from Fender, Gibson, Yamaha and more.
        </p>

        <% if (!isAdmin) { %>
	    <a href="${pageContext.request.contextPath}/inventory"
	       class="banner-btn">
	       Shop Now
	    </a>
<% } %>
    </div>

</section>
<section class="hero">
    <h1>Welcome to Guitar Shop</h1>
    <p>Find your perfect guitar here.</p>
</section>

<section class="guitar-section">
    <h2>Featured Guitars</h2>

    <div class="guitar-grid">

        <% if (guitars != null && !guitars.isEmpty()) { %>

            <% for (GuitarModel guitar : guitars) { %>

                <div class="guitar-card">
                    <img src="${pageContext.request.contextPath}/images/<%= guitar.getImage() %>">

                    <h3><%= guitar.getBrand() %> <%= guitar.getModel() %></h3>
                    <p>Brand: <%= guitar.getBrand() %></p>
                    <p>Price: Rs. <%= guitar.getPrice() %></p>

                    <% if (!isAdmin) { %>
                        <form action="${pageContext.request.contextPath}/addToCart"
                              method="post"
                              onsubmit="return showPopup()">

                            <input type="hidden" name="guitarName"
                                   value="<%= guitar.getBrand() %> <%= guitar.getModel() %>">

                            <input type="hidden" name="price"
                                   value="<%= guitar.getPrice() %>">

                            <button type="submit">🛒 Add to Cart</button>
                        </form>
                    <% } %>
                </div>

            <% } %>

        <% } else { %>

            <p>No guitars found.</p>

        <% } %>

    </div>
</section>

<script>
function showPopup() {
    <% if (user == null) { %>
        alert("Please sign in first to add items to your cart.");
        window.location.href = "${pageContext.request.contextPath}/login";
        return false;
    <% } else { %>
        alert("Item added to cart!");
        return true;
    <% } %>
}
</script>

</body>
</html>