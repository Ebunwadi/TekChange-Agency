<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Listings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 70%;
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
        ul {
            list-style-type: none;
            padding: 0;
            text-align: center;
        }
        ul li {
            display: inline;
            margin: 0 10px;
        }
        ul li a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }
        ul li a.active {
            color: #ff9800;
            text-decoration: underline;
        }
        ul li a:hover {
            text-decoration: underline;
        }
        .tab {
            display: none;
        }
        .tab.active {
            display: block;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        img {
            max-width: 100px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #45a049;
        }
        .home-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
    <script>
        function showTab(category) {
            var tabs = document.getElementsByClassName('tab');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].classList.remove('active');
            }
            document.getElementById(category).classList.add('active');

            var links = document.querySelectorAll('ul li a');
            links.forEach(link => {
                link.classList.remove('active');
            });
            document.querySelector('ul li a[href="javascript:showTab(\'' + category + '\')"]').classList.add('active');
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Browse Listings</h2>

    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p>Hello, ${sessionScope.user.username}!</p>
        </c:when>
        <c:otherwise>
            <p>Please <a href="login.jsp">login</a> to view and manage your listings.</p>
        </c:otherwise>
    </c:choose>

    <h3>Categories</h3>
    <ul>
        <li><a href="javascript:showTab('Electronics')" class="active">Electronics</a></li>
        <li><a href="javascript:showTab('Furniture')">Furniture</a></li>
        <li><a href="javascript:showTab('Clothing')">Clothing</a></li>
    </ul>

    <c:choose>
        <c:when test="${not empty items}">
            <div id="Electronics" class="tab active">
                <table>
                    <tr>
                        <th>Description</th>
                        <th>Condition</th>
                        <th>Photo</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="item" items="${items}">
                        <c:if test="${item.category == 'ELECTRONICS'}">
                            <tr>
                                <td>${item.description}</td>
                                <td>${item.condition}</td>
                                <td><img src="${item.photoUrl}" alt="item photo"></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.userId == sessionScope.user.userId}">
                                            <p>This is your item</p>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="interestExpressed" value="false" />
                                            <c:set var="exchangeCompleted" value="false" />
                                            <c:forEach var="expressedItemId" items="${expressedInterestItems}">
                                                <c:if test="${item.itemId == expressedItemId}">
                                                    <c:set var="interestExpressed" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach var="completedItemId" items="${completedExchangeItems}">
                                                <c:if test="${item.itemId == completedItemId}">
                                                    <c:set var="exchangeCompleted" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${interestExpressed == true}">
                                                    <p>Interest expressed</p>
                                                </c:when>
                                                <c:when test="${exchangeCompleted == true}">
                                                    <p>you have successfully Exchanged this Item</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="ExpressInterest" method="post">
                                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                                        <button type="submit">Express Interest</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>

            <div id="Furniture" class="tab">
                <table>
                    <tr>
                        <th>Description</th>
                        <th>Condition</th>
                        <th>Photo</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="item" items="${items}">
                        <c:if test="${item.category == 'FURNITURE'}">
                            <tr>
                                <td>${item.description}</td>
                                <td>${item.condition}</td>
                                <td><img src="${item.photoUrl}" alt="item photo"></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.userId == sessionScope.user.userId}">
                                            <p>This is your item</p>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="interestExpressed" value="false" />
                                            <c:set var="exchangeCompleted" value="false" />
                                            <c:forEach var="expressedItemId" items="${expressedInterestItems}">
                                                <c:if test="${item.itemId == expressedItemId}">
                                                    <c:set var="interestExpressed" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach var="completedItemId" items="${completedExchangeItems}">
                                                <c:if test="${item.itemId == completedItemId}">
                                                    <c:set var="exchangeCompleted" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${interestExpressed == true}">
                                                    <p>Interest expressed</p>
                                                </c:when>
                                                <c:when test="${exchangeCompleted == true}">
                                                    <p>you have successfully Exchanged this Item</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="ExpressInterest" method="post">
                                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                                        <button type="submit">Express Interest</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>

            <div id="Clothing" class="tab">
                <table>
                    <tr>
                        <th>Description</th>
                        <th>Condition</th>
                        <th>Photo</th>
                        <th>Action</th>
                    </tr>
                    <c:forEach var="item" items="${items}">
                        <c:if test="${item.category == 'CLOTHING'}">
                            <tr>
                                <td>${item.description}</td>
                                <td>${item.condition}</td>
                                <td><img src="${item.photoUrl}" alt="item photo"></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.userId == sessionScope.user.userId}">
                                            <p>This is your item</p>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="interestExpressed" value="false" />
                                            <c:set var="exchangeCompleted" value="false" />
                                            <c:forEach var="expressedItemId" items="${expressedInterestItems}">
                                                <c:if test="${item.itemId == expressedItemId}">
                                                    <c:set var="interestExpressed" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach var="completedItemId" items="${completedExchangeItems}">
                                                <c:if test="${item.itemId == completedItemId}">
                                                    <c:set var="exchangeCompleted" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:choose>
                                                <c:when test="${interestExpressed == true}">
                                                    <p>Interest expressed</p>
                                                </c:when>
                                                <c:when test="${exchangeCompleted == true}">
                                                    <p>you have successfully Exchanged this Item</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="ExpressInterest" method="post">
                                                        <input type="hidden" name="itemId" value="${item.itemId}">
                                                        <button type="submit">Express Interest</button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <p>No items available.</p>
        </c:otherwise>
    </c:choose>

    <div class="home-link">
        <p><a href="index.jsp">Home</a></p>
    </div>
</div>
</body>
</html>
