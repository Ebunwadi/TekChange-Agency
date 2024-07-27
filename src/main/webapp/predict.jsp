<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Category Prediction</title>
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
        }
        h2 {
            color: #333;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        select, input[type="submit"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group select {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Predict Item Category</h2>
    <form action="predict" method="post">
        <div class="form-group">
            <label for="brand">Brand:</label>
            <select name="brand" id="brand">
                <option value="">Select Brand</option>
                <option value="Apple">Apple</option>
                <option value="Nike">Nike</option>
                <option value="IKEA">IKEA</option>
                <option value="Sony">Sony</option>
                <option value="DFS">DFS</option>
                <option value="Samsung">Samsung</option>
                <option value="Next">Next</option>
                <option value="None">None</option>
            </select>
        </div>

        <div class="form-group">
            <label for="ram">RAM:</label>
            <select name="ram" id="ram">
                <option value="">Select RAM</option>
                <option value="8">8</option>
                <option value="6">6</option>
                <option value="3">3</option>
                <option value="None">None</option>
            </select>
        </div>

        <div class="form-group">
            <label for="model">Model:</label>
            <select name="model" id="model">
                <option value="">Select Model</option>
                <option value="iPhone_X">iPhone_X</option>
                <option value="PlayStation_5">PlayStation_5</option>
                <option value="S20">S20</option>
                <option value="S10">S10</option>
                <option value="None">None</option>
            </select>
        </div>

        <div class="form-group">
            <label for="size">Size:</label>
            <select name="size" id="size">
                <option value="">Select Size</option>
                <option value="Small">Small</option>
                <option value="Medium">Medium</option>
                <option value="Large">Large</option>
                <option value="7">7</option>
                <option value="None">None</option>
            </select>
        </div>

        <div class="form-group">
            <label for="type">Type:</label>
            <select name="type" id="type">
                <option value="">Select Type</option>
                <option value="Sofa">Sofa</option>
                <option value="Bookcase">Bookcase</option>
                <option value="Chair">Chair</option>
                <option value="None">None</option>
            </select>
        </div>

        <div class="form-group">
            <label for="colour">Colour:</label>
            <select name="colour" id="colour">
                <option value="">Select Colour</option>
                <option value="Silver">Silver</option>
                <option value="Black">Black</option>
                <option value="Brown">Brown</option>
                <option value="Gold">Gold</option>
                <option value="White">White</option>
                <option value="Green">Green</option>
                <option value="Blue">Blue</option>
                <option value="None">None</option>
            </select>
        </div>

        <input type="submit" value="Predict">
    </form>
</div>
</body>
</html>
