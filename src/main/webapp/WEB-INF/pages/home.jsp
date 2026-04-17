<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.guitar.model.UserModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<%
    UserModel user = (UserModel) session.getAttribute("loggedInUser");
%>

<!-- NAVBAR -->
<nav class="navbar">
    <div class="nav-left">
        <div class="logo">🎸 Guitar Shop</div>
        <a href="${pageContext.request.contextPath}/home">Home</a>

        <% if (user != null && "admin".equalsIgnoreCase(user.getRole())) { %>
            <a href="${pageContext.request.contextPath}/admin">Admin</a>
        <% } %>
    </div>

    <div class="nav-right">
        <% if (user == null) { %>
            <a href="${pageContext.request.contextPath}/login">Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
        <% } else { %>
            <span class="profile-text">Welcome, <%= user.getEmail() %></span>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        <% } %>
    </div>
</nav>

<!-- SEARCH BAR (RIGHT SIDE) -->
<div class="search-container">
    <form action="${pageContext.request.contextPath}/home" method="get">
        <input type="text" name="search" placeholder="Search guitars...">
        <button type="submit">Search</button>
    </form>
</div>

<!-- HERO -->
<section class="hero">
    <h1>Welcome to Guitar Shop</h1>
    <p>Find your perfect guitar here.</p>
</section>

<!-- GUITARS -->
<section class="guitar-section">
    <h2>Featured Guitars</h2>

    <div class="guitar-grid">

        <div class="guitar-card">
            <img src="${pageContext.request.contextPath}/images/fender.jpg" alt="Fender Stratocaster">
            <h3>Fender Stratocaster</h3>
            <p>Brand: Fender</p>
            <p>Price: $1200</p>
            <button>View Details</button>
        </div>

        <div class="guitar-card">
            <img src="${pageContext.request.contextPath}/images/gibson.jpg" alt="Gibson Les Paul">
            <h3>Gibson Les Paul</h3>
            <p>Brand: Gibson</p>
            <p>Price: $1500</p>
            <button>View Details</button>
        </div>

        <div class="guitar-card">
            <img src="${pageContext.request.contextPath}/images/yamaha.jpg" alt="Yamaha F310">
            <h3>Yamaha F310</h3>
            <p>Brand: Yamaha</p>
            <p>Price: $250</p>
            <button>View Details</button>
        </div>

    </div>
</section>

</body>
</html>