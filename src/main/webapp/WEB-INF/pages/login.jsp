<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>

<body>

<div class="login-container">
    <div class="login-card">

        <h1>🎸 Guitar Shop</h1>
        <h2>Login</h2>

        <% String error = (String) request.getAttribute("error"); %>

        <% if (error != null) { %>
            <p class="error-message"><%= error %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email"
                       name="email"
                       placeholder="Enter your email"
                       required>
            </div>

            <div class="form-group">
			    <label>Password</label>
			
			    <div class="password-container">
			
			        <input type="password"
			               id="password"
			               name="password"
			               placeholder="Password"
			               required>
			
			    </div>
			</div>

            <p class="forgot-password">
                <a href="${pageContext.request.contextPath}/forgotPassword">
                    Forgot Password?
                </a>
            </p>

            <button type="submit" class="login-btn">Login</button>

        </form>

        <p class="register-text">
            Don’t have an account?
            <a href="${pageContext.request.contextPath}/register">Register here</a>
        </p>

    </div>
</div>


</body>
</html>