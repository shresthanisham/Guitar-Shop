<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.guitar.model.UserModel" %>
<%@ page import="com.guitar.model.GuitarModel" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    UserModel user = (UserModel) session.getAttribute("loggedInUser");
    boolean isAdmin = (user != null && "admin".equalsIgnoreCase(user.getRole()));

    List<GuitarModel> guitars = (List<GuitarModel>) request.getAttribute("guitars");

    ArrayList cart = (ArrayList) session.getAttribute("cart");
    int cartCount = (cart == null) ? 0 : cart.size();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">🎸 Guitar Shop</div>

		<form action="${pageContext.request.contextPath}/inventory"
		      method="get"
		      class="search-bar">
		
		    <input type="text"
		           name="search"
		           placeholder="Search guitars...">
		
		    <button type="submit">🔍</button>
		
		</form>

    <div class="nav-right">
        <span class="profile-text">👤 Welcome, <%= user.getEmail() %></span>

        <% if (!isAdmin) { %>
            <a href="${pageContext.request.contextPath}/cart" class="cart-btn">
                🛒 Cart: <%= cartCount %>
            </a>
        <% } %>

        <a href="${pageContext.request.contextPath}/home">🏠 Home</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
</nav>

<main class="main-content">

    <!-- INVENTORY BANNER -->
    <section class="inventory-banner">

        <div class="inventory-banner-content">
            <h1>🎸 Explore Our Guitar Collection</h1>

            <p>
                Browse electric, acoustic, and premium guitars for every users.
            </p>
        </div>

    </section>

    
    <section class="hero">
        <h1>Guitar Inventory</h1>
        <p>Browse available guitars and add them to your cart.</p>
    </section>

    <section class="guitar-section">
        <h2>Available Guitars</h2>

        <div class="guitar-grid">

            <% if (guitars != null && !guitars.isEmpty()) { %>

                <% for (GuitarModel guitar : guitars) { %>

                    <div class="guitar-card">
                        <img src="${pageContext.request.contextPath}/images/<%= guitar.getImage() %>">

                        <h3><%= guitar.getBrand() %> <%= guitar.getModel() %></h3>
                        <p>Brand: <%= guitar.getBrand() %></p>
						<p>Model: <%= guitar.getModel() %></p>
						<p>Price: Rs. <%= guitar.getPrice() %></p>
						<p>Stock: <%= guitar.getStock() %></p>
						<p>Discount: <%= guitar.getDiscount() %>%</p>
						<p>Category: <%= guitar.getCategory() %></p>
						<p>Featured: <%= guitar.getFeatured() %></p>

                        <% if (!isAdmin) { %>
                            <form action="${pageContext.request.contextPath}/addToCart" 
							      method="post"
							      onsubmit="return showPopup()">
							
							    <input type="hidden" name="guitarName"
							           value="<%= guitar.getBrand() %> <%= guitar.getModel() %>">
							
							    <input type="hidden" name="price"
							           value="<%= guitar.getPrice() %>">
							           <input type="hidden"
								       name="discount"
								       value="<%= guitar.getDiscount() %>">
							
							    <button type="submit">🛒 Add to Cart</button>
							</form>
                        <% } %>
                    </div>

                <% } %>

            <% } else { %>

                <p>No guitars available.</p>

            <% } %>

        </div>
    </section>

</main>
<script>
function showPopup() {
    alert("Item added to cart!");
    return true;
}
</script>
</body>
</html>