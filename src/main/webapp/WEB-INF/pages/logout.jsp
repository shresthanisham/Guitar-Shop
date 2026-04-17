<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out | Guitar Shop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/logout.css">
</head>
<body>

<div class="logout-container">
    <div class="logout-card">
        <h1>🎸 Guitar Shop</h1>
        <h2>You have been logged out</h2>

        <p>Thank you for visiting!</p>

        <a href="${pageContext.request.contextPath}/login" class="btn">Login Again</a>
    </div>
</div>

</body>
</html>