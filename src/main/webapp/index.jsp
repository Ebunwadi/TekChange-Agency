<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exchange Agency Platform</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            color: #333;
        }
        h3 {
            color: #555;
        }
        p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }
        a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            border: 1px solid #4CAF50;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }
        a:hover {
            background-color: #4CAF50;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome to Tekchange Agency</h2>

    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p>Hello, ${sessionScope.user.username}!</p>
            <p><a href="Logout">Logout</a></p>
            <p><a href="addListing.jsp">Add New Listing</a></p>
            <p><a href="MyListings">View My Listings</a></p>
            <br>
            <h3>Explore Listings</h3>
            <p><a href="BrowseListings">Browse Listings by Category</a></p>
        </c:when>
        <c:otherwise>
            <p><a href="login.jsp">Login</a> or <a href="register.jsp">Register</a></p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
