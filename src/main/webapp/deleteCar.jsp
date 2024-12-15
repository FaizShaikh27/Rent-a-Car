<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Car Deletion</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            color: #333;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        p {
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #5D5FEF;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 16px;
            width: 100%;
        }

        button:hover {
            background-color: #4343d3;
        }

        .back-button {
            padding: 10px 15px;
            background-color: #777;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            margin-bottom: 20px;
            display: inline-block;
        }

        .back-button:hover {
            background-color: #555;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <a href="manageCars.jsp" class="back-button">Back to Manage Cars</a>
    <h2>Delete Car Listing</h2>
    <p>Type "confirm" in the box below to delete this listing.</p>

    <!-- Check for the error parameter and display the error message if it exists -->
    <% 
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <p class="error-message"><%= error %></p>
    <% 
        } 
    %>

    <form action="DeleteCarServlet" method="post">
        <input type="hidden" name="carId" value="<%= request.getParameter("carId") %>">
        
        <label>Confirmation:</label>
        <input type="text" name="confirmation" required>
        
        <button type="submit">Delete</button>
    </form>
</body>
</html>
