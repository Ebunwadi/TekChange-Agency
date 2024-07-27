<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Listing</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            border-radius: 8px;
        }
        h2, h3 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 10px;
            color: #555;
        }
        input[type="text"],
        select,
        textarea,
        input[type="file"] {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            text-align: center;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .home-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>you can click <a href="predict">here</a> to predict the item's category you want to list.</h3>
    <h2>Add New Listing</h2>

    <form action="AddListing" method="post" enctype="multipart/form-data">
        <label for="category">Category:</label>
        <select name="category" id="category">
            <option value="ELECTRONICS">Electronics</option>
            <option value="FURNITURE">Furniture</option>
            <option value="CLOTHING">Clothing</option>
        </select>

        <label for="description">Description:</label>
        <textarea name="description" id="description" required></textarea>

        <label for="condition">Condition:</label>
        <input type="text" name="condition" id="condition" required>

        <label for="photo">Photo:</label>
        <input type="file" name="photo" id="photo" accept="image/*" required>

        <input type="submit" value="Add Listing">
    </form>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <div class="home-link">
        <p><a href="index.jsp">Home</a></p>
    </div>
</div>
</body>
</html>
