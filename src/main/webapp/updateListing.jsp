<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Listing</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        p {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        select,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        .home-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            font-size: 16px;
        }
        .home-link a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
            transition: color 0.3s;
        }
        .home-link a:hover {
            color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Update Listing</h1>
    <c:if test="${not empty item}">
        <form action="UpdateListing" method="post" enctype="multipart/form-data">
            <input type="hidden" name="item_id" value="${item.itemId}" />

            <p>
                <label for="category">Category:</label>
                <select name="category" id="category">
                    <option value="ELECTRONICS" ${item.category == 'ELECTRONICS' ? 'selected' : ''}>Electronics</option>
                    <option value="FURNITURE" ${item.category == 'FURNITURE' ? 'selected' : ''}>Furniture</option>
                    <option value="CLOTHING" ${item.category == 'CLOTHING' ? 'selected' : ''}>Clothing</option>
                </select>
            </p>

            <p>
                <label for="description">Description:</label>
                <input type="text" name="description" id="description" value="${item.description}" required />
            </p>

            <p>
                <label for="condition">Condition:</label>
                <input type="text" name="condition" id="condition" value="${item.condition}" required />
            </p>

            <p>
                <label for="photo">Photo:</label>
                <input type="file" name="photo" id="photo" />
            </p>

            <button type="submit">Update</button>
        </form>
    </c:if>
    <div class="home-link">
        <a href="index.jsp">Home</a>
    </div>
</div>
</body>
</html>
