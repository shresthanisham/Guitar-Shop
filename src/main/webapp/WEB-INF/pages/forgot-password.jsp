<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>

<div class="login-container">
    <div class="login-card">

        <h1>🎸 Guitar Shop</h1>
        <h2>Forgot Password</h2>
        

        <% if (request.getAttribute("error") != null) { %>
            <p class="error-message"><%= request.getAttribute("error") %></p>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
            <p class="success-message"><%= request.getAttribute("success") %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/forgotPassword" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" placeholder="Enter new password" required>
            </div>
			<div class="form-group">
    			<label>Confirm New Password</label>
    			<input type="password" name="confirmPassword" placeholder="Confirm new password" required>
</div>
            <button type="submit" class="login-btn">Reset Password</button>
        </form>

        <p class="register-text">
            Remember your password?
            <a href="${pageContext.request.contextPath}/login">Back to Login</a>
        </p>

    </div>
</div>
<% if (request.getAttribute("success") != null) { %>
<script>
    alert("Password reset successfully. Please login.");
    window.location.href = "${pageContext.request.contextPath}/login";
</script>
<% } %>
</body>
</html>