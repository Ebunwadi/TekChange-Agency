<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Listings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1, h2, h3 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            border-radius: 4px;
        }
        .actions button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
            margin-right: 5px;
        }
        .actions button:hover {
            background-color: #45a049;
        }
        .actions form {
            display: inline;
        }
        .notifications {
            background-color: #fffbcc;
            border: 1px solid #ffd700;
            padding: 15px;
            margin: 20px 0;
            border-radius: 4px;
        }
        .notifications p {
            margin: 0;
        }
        .notifications a {
            color: #007bff;
            text-decoration: none;
        }
        .notifications a:hover {
            text-decoration: underline;
        }
        .welcome {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .home-link {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p class="welcome">Hello, ${sessionScope.user.username}! These are the items you have listed for exchange.</p>
        </c:when>
        <c:otherwise>
            <p>Please <a href="login.jsp">login</a> to view and manage your listings.</p>
        </c:otherwise>
    </c:choose>

    <c:if test="${not empty notifications}">
        <div class="notifications">
            <h2>Notifications</h2>
            <c:forEach var="notification" items="${notifications}">
                <p>
                    A user (<a href="UserDetails?userId=${notification.userId}">${notification.username}</a>)
                    has expressed interest in your item
                    (<a href="ItemDetails?itemId=${notification.itemId}">${notification.itemDescription}</a>).
                    Please do your background check before finalizing the exchange
                    <a href="FinalizeExchange?itemId=${notification.itemId}">here</a>.
                </p>
            </c:forEach>
        </div>
    </c:if>

    <h3>My Listings</h3>
    <table>
        <tr>
            <th>Category</th>
            <th>Description</th>
            <th>Condition</th>
            <th>Photo</th>
            <th>Action</th>
        </tr>
        <c:forEach var="item" items="${items}">
            <tr>
                <td>${item.category}</td>
                <td>${item.description}</td>
                <td>${item.condition}</td>
                <td><img src="${item.photoUrl}" alt="item photo" width="100"></td>
                <td class="actions">
                    <c:choose>
                        <c:when test="${item.status == 'Completed'}">
                            <p>You finalized an exchange with ${item.interestedUsername}.</p>
                        </c:when>
                        <c:otherwise>
                            <form action="UpdateListingForm" method="get" style="display:inline;">
                                <input type="hidden" name="item_id" value="${item.itemId}" />
                                <button type="submit">Update</button>
                            </form>
                            <form action="DeleteListing" method="post" onsubmit="return confirm('Are you sure you want to delete this listing?');" style="display:inline;">
                                <input type="hidden" name="itemId" value="${item.itemId}">
                                <button type="submit">Delete</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
    <p class="home-link"><a href="index.jsp">Home</a></p>
</div>

</body>
</html>
