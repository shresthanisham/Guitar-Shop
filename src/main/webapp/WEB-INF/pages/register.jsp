<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register | Guitar Shop</title>

    <!-- Link CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>

<body>

<div class="register-container">

    <div class="register-card">
        <h1>🎸 Guitar Shop</h1>
        <h2>Create Account</h2>

        <!-- Error Message -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <p class="error-message"><%= error %></p>
        <% } %>

        <!-- Success Message -->
        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
            <p class="success-message"><%= success %></p>
        <% } %>

        <!-- Register Form -->
        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter password" required>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" placeholder="Confirm password" required>
            </div>

            <button type="submit" class="register-btn">Register</button>

        </form>

        <p class="login-text">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Login here</a>
        </p>

    </div>

</div>

</body>
</html>