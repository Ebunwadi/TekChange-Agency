<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Prediction Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        .result {
            font-size: 18px;
            font-weight: bold;
            color: #4CAF50;
            margin: 20px 0;
        }
        a {
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
            transition: color 0.3s;
        }
        a:hover {
            color: #45a049;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Prediction Result</h2>
    <p class="result">Predicted Category: ${predictedCategory}</p>
    <p>
        <a href="predict" class="button">Predict Another Item Category</a>
        <a href="addListing.jsp" class="button">Back to Add Listing</a>
    </p>
</div>
</body>
</html>
