<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Car</title>
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

        form {
            max-width: 600px;
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

        input[type="text"],
        input[type="number"],
        textarea,
        select {
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

        /* Responsive Design */
        @media (max-width: 768px) {
            form {
                padding: 15px;
            }
            button {
                width: 100%; /* Full-width button on mobile */
            }
        }
    </style>
</head>
<body>
    <a href="manageCars.jsp" class="back-button">Back to Manage Cars</a>
    <h2>Update Car Details</h2>
    <form action="UpdateCarServlet" method="post">
        <input type="hidden" name="carId" value="${carId}">
        
        <label>Car Name:</label>
        <input type="text" name="carName" value="${carName}" required>

        <label>Car Number:</label>
        <input type="text" name="carNumber" value="${carNumber}" required>

        <label>Company:</label>
        <input type="text" name="company" value="${company}" required>

        <label>Type:</label>
        <input type="text" name="type" value="${type}" required>

        <label>Seats:</label>
        <input type="number" name="seats" value="${seats}" required>

        <label>Price per Day:</label>
        <input type="text" name="pricePerDay" value="${pricePerDay}" required>

        <label>Description:</label>
        <textarea name="description" required>${description}</textarea>

        <label>Status:</label>
        <select name="status" required>
            <option value="available" <c:if test="${status == 'available'}">selected</c:if>>Available</option>
            <option value="booked" <c:if test="${status == 'booked'}">selected</c:if>>Booked</option>
        </select>

        <button type="submit">Save Changes</button>
    </form>
</body>
</html>
