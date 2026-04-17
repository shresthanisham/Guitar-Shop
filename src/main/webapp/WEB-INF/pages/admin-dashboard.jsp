<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.guitar.model.UserModel" %>
<%@ page import="com.guitar.model.GuitarModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<%
    UserModel user = (UserModel) session.getAttribute("loggedInUser");
    GuitarModel editGuitar = (GuitarModel) request.getAttribute("editGuitar");
    List<GuitarModel> guitars = (List<GuitarModel>) request.getAttribute("guitars");
    String error = (String) request.getAttribute("error");
%>

<nav class="navbar">
    <div class="logo">🎸 Admin Panel</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
        <span class="profile">Admin: <%= user.getEmail() %></span>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<div class="container">
    <h1>Admin Dashboard</h1>
    <p class="subtitle">Only admin can access this page.</p>

    <% if (error != null) { %>
        <p class="error-message"><%= error %></p>
    <% } %>

    <div class="form-card">
        <h2><%= (editGuitar != null) ? "Update Guitar" : "Add Guitar" %></h2>

        <form action="${pageContext.request.contextPath}/admin" method="post">
            <input type="hidden" name="action" value="<%= (editGuitar != null) ? "update" : "add" %>">

            <% if (editGuitar != null) { %>
                <input type="hidden" name="guitarId" value="<%= editGuitar.getGuitarId() %>">
            <% } %>

            <div class="form-group">
                <label>Brand</label>
                <input type="text" name="brand" value="<%= (editGuitar != null) ? editGuitar.getBrand() : "" %>" required>
            </div>

            <div class="form-group">
                <label>Model</label>
                <input type="text" name="model" value="<%= (editGuitar != null) ? editGuitar.getModel() : "" %>" required>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="number" step="0.01" name="price" value="<%= (editGuitar != null) ? editGuitar.getPrice() : "" %>" required>
            </div>

            <div class="form-group">
                <label>Stock</label>
                <input type="number" name="stock" value="<%= (editGuitar != null) ? editGuitar.getStock() : "" %>" required>
            </div>

            <button type="submit" class="btn">
                <%= (editGuitar != null) ? "Update Guitar" : "Add Guitar" %>
            </button>

            <% if (editGuitar != null) { %>
                <a class="cancel-btn" href="${pageContext.request.contextPath}/admin">Cancel</a>
            <% } %>
        </form>
    </div>

    <div class="table-card">
        <h2>All Guitars</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (guitars != null && !guitars.isEmpty()) { %>
                    <% for (GuitarModel guitar : guitars) { %>
                        <tr>
                            <td><%= guitar.getGuitarId() %></td>
                            <td><%= guitar.getBrand() %></td>
                            <td><%= guitar.getModel() %></td>
                            <td>$<%= guitar.getPrice() %></td>
                            <td><%= guitar.getStock() %></td>
                            <td>
                                <a class="edit-btn"
                                   href="${pageContext.request.contextPath}/admin?action=edit&id=<%= guitar.getGuitarId() %>">
                                   Edit
                                </a>
                                <a class="delete-btn"
                                   href="${pageContext.request.contextPath}/admin?action=delete&id=<%= guitar.getGuitarId() %>"
                                   onclick="return confirm('Are you sure you want to delete this guitar?');">
                                   Delete
                                </a>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="6">No guitars found.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>