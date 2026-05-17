<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.guitar.model.UserModel" %>
<%@ page import="com.guitar.model.GuitarModel" %>

<%
    UserModel user = (UserModel) session.getAttribute("loggedInUser");
    GuitarModel editGuitar = (GuitarModel) request.getAttribute("editGuitar");
    List<GuitarModel> guitars = (List<GuitarModel>) request.getAttribute("guitars");
    String error = (String) request.getAttribute("error");
    String action = request.getParameter("action");

    boolean showForm = "add".equalsIgnoreCase(action) || editGuitar != null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<nav class="navbar">
    <div class="logo">🎸 Admin Panel</div>

    <div class="nav-links">

    <a href="${pageContext.request.contextPath}/home">🏠 Home</a>

    <a href="${pageContext.request.contextPath}/manageUsers">
        👥 Manage Users
    </a>

    <span class="profile">
        👤 Admin: <%= user.getEmail() %>
    </span>

    <a href="${pageContext.request.contextPath}/logout">
        🚪 Logout
    </a>

</div>
</nav>
<%
String message = request.getParameter("message");
%>

<script>

window.onload = function () {

    <% if ("added".equals(message)) { %>
        alert("Guitar added successfully!");
    <% } %>

    <% if ("updated".equals(message)) { %>
        alert("Guitar updated successfully!");
    <% } %>

    <% if ("deleted".equals(message)) { %>
        alert("Guitar deleted successfully!");
    <% } %>

};

</script>
<div class="container">

    <h1>Admin Dashboard</h1>
    <p class="subtitle">Only admin can access this page.</p>

    <% if (error != null) { %>
        <p class="error-message"><%= error %></p>
    <% } %>

    <% if (showForm) { %>

        <div class="form-card">
            <h2><%= (editGuitar != null) ? "Update Guitar" : "Add Guitar" %></h2>

            <form action="${pageContext.request.contextPath}/admin" method="post">
                <input type="hidden" name="action" value="<%= (editGuitar != null) ? "update" : "add" %>">

                <% if (editGuitar != null) { %>
                    <input type="hidden" name="guitarId" value="<%= editGuitar.getGuitarId() %>">
                <% } %>

                <div class="form-group">
				    
				    <label>Brand</label>
				
				    <select name="brand" required>
				        <option value="">Select Brand</option>
				

						<option value="Fender" <%= (editGuitar != null && "Fender".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>Fender</option>
						
						<option value="Gibson" <%= (editGuitar != null && "Gibson".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>Gibson</option>
						
						<option value="Yamaha" <%= (editGuitar != null && "Yamaha".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>Yamaha</option>
						
						<option value="Ibanez" <%= (editGuitar != null && "Ibanez".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>Ibanez</option>
						
						<option value="PRS" <%= (editGuitar != null && "PRS".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>PRS</option>
						
						<option value="Taylor" <%= (editGuitar != null && "Taylor".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>Taylor</option>
						
						<option value="Martin" <%= (editGuitar != null && "Martin".equalsIgnoreCase(editGuitar.getBrand())) ? "selected" : "" %>>Martin</option>
				
				    </select>
				</div>
                <div class="form-group">
				    <label>Model</label>
				
				    <select name="model" required>
				        <option value="">Select Model</option>
				

						<option value="Stratocaster" <%= (editGuitar != null && "Stratocaster".equalsIgnoreCase(editGuitar.getModel())) ? "selected" : "" %>>Stratocaster</option>
						
						<option value="Telecaster" <%= (editGuitar != null && "Telecaster".equalsIgnoreCase(editGuitar.getModel())) ? "selected" : "" %>>Telecaster</option>
						
						<option value="Les Paul" <%= (editGuitar != null && "Les Paul".equalsIgnoreCase(editGuitar.getModel())) ? "selected" : "" %>>Les Paul</option>
						
						<option value="SG" <%= (editGuitar != null && "SG".equalsIgnoreCase(editGuitar.getModel())) ? "selected" : "" %>>SG</option>
						
						<option value="RG550" <%= (editGuitar != null && "RG550".equalsIgnoreCase(editGuitar.getModel())) ? "selected" : "" %>>RG550</option>
				        
				
				    </select>
				</div>

                <div class="form-group">
                    <label>Price</label>
                    <input type="number" step="0.01" name="price" value="<%= (editGuitar != null) ? editGuitar.getPrice() : "" %>" required>
                </div>

                <div class="form-group">
                    <label>Stock</label>
                    <input type="number" name="stock" value="<%= (editGuitar != null) ? editGuitar.getStock() : "" %>" required>
                </div>
                
                <div class="form-group">
				    <label>Discount (%)</label>
				    <input type="number"
				       name="discount"
				       min="0"
				       max="100"
				       value="<%= (editGuitar != null) ? editGuitar.getDiscount() : "" %>"
				       placeholder="Enter discount percentage">
				</div>
				
				<div class="form-group">
				    <label>Category</label>
				
				    <select name="category">
				        <option value="">Select Category</option>

						<option value="Electric Guitar" <%= (editGuitar != null && "Electric Guitar".equalsIgnoreCase(editGuitar.getCategory())) ? "selected" : "" %>>Electric Guitar</option>
						
						<option value="Acoustic Guitar" <%= (editGuitar != null && "Acoustic Guitar".equalsIgnoreCase(editGuitar.getCategory())) ? "selected" : "" %>>Acoustic Guitar</option>
						
						<option value="Bass Guitar" <%= (editGuitar != null && "Bass Guitar".equalsIgnoreCase(editGuitar.getCategory())) ? "selected" : "" %>>Bass Guitar</option>
						
						<option value="Premium Guitar" <%= (editGuitar != null && "Premium Guitar".equalsIgnoreCase(editGuitar.getCategory())) ? "selected" : "" %>>Premium Guitar</option>
				    </select>
				</div>
				
				<div class="form-group">
				    <label>Featured Guitar</label>
				
				    <select name="featured">
				        <option value="No" <%= (editGuitar != null && "No".equalsIgnoreCase(editGuitar.getFeatured())) ? "selected" : "" %>>No</option>

						<option value="Yes" <%= (editGuitar != null && "Yes".equalsIgnoreCase(editGuitar.getFeatured())) ? "selected" : "" %>>Yes</option>
				    </select>
				</div>

                <button type="submit" class="btn">
                    <%= (editGuitar != null) ? "Update Guitar" : "Add Guitar" %>
                </button>

                <a class="cancel-btn" href="${pageContext.request.contextPath}/admin">Cancel</a>
            </form>
        </div>

    <% } %>

    <div class="table-card">

        <div class="table-header">
            <h2>All Guitars</h2>

            <% if (!showForm) { %>
                <a class="add-btn" href="${pageContext.request.contextPath}/admin?action=add">
                    + Add Guitar
                </a>
            <% } %>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Price</th>
					<th>Stock</th>
					<th>Discount</th>
					<th>Category</th>
					<th>Featured</th>
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
                            <td>Rs. <%= guitar.getPrice() %></td>
							<td><%= guitar.getStock() %></td>
							<td><%= guitar.getDiscount() %>%</td>
							<td><%= guitar.getCategory() %></td>
							<td><%= guitar.getFeatured() %></td>
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
                        <td colspan="9">No guitars found.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</div>

</body>
</html>