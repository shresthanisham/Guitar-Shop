<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.guitar.model.UserModel" %>

<%
    List<UserModel> users = (List<UserModel>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">🎸 Admin Panel</div>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin">⚙️ Dashboard</a>
        <a href="${pageContext.request.contextPath}/home">🏠 Home</a>
        <a href="${pageContext.request.contextPath}/logout">🚪 Logout</a>
    </div>
</nav>
<%
String message = request.getParameter("message");
%>

<script>

window.onload = function () {

    <% if ("updated".equals(message)) { %>
        alert("User role updated successfully!");
    <% } %>

};

</script>
<div class="container">
    <h1>Manage Users</h1>
    <p class="subtitle">Give or remove admin access.</p>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Email</th>
                    <th>Current Role</th>
                    <th>Change Role</th>
                </tr>
            </thead>

            <tbody>
                <% if (users != null && !users.isEmpty()) { %>
                    <% for (UserModel user : users) { %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getRole() %></td>
                            <td>
                                <% if ("admin@gmail.com".equalsIgnoreCase(user.getEmail())) { %>

							    <select disabled>
							        <option>Admin</option>
							    </select>
							
							<% } else { %>
							
							    <form action="${pageContext.request.contextPath}/manageUsers" method="post">
							
							        <input type="hidden"
							               name="userId"
							               value="<%= user.getUserId() %>">
							
							        <select name="role">
							            <option value="user"
							                <%= "user".equalsIgnoreCase(user.getRole()) ? "selected" : "" %>>
							                User
							            </option>
							
							            <option value="admin"
							                <%= "admin".equalsIgnoreCase(user.getRole()) ? "selected" : "" %>>
							                Admin
							            </option>
							        </select>
							
							        <button type="submit" class="btn">
							            Update
							        </button>
							
							    </form>
							
							<% } %>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="4">No users found.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>