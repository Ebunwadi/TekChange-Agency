<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
            width: 300px;
        }
        h1 {
            color: #333;
        }
        p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
        }
        img {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 5px;
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
    <h1>Item Details</h1>
    <p><strong>Category:</strong> ${item.category}</p>
    <p><strong>Description:</strong> ${item.description}</p>
    <p><strong>Condition:</strong> ${item.condition}</p>
    <p><img src="${item.photoUrl}" alt="Item Photo" width="100" /></p>
    <br>
    <p><a href="MyListings">Back to listings</a></p>
</div>
</body>
</html>
