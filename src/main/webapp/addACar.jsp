<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add a Car</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <link rel="stylesheet" href="addCar.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="add-car-container">
        <a href="admin.jsp" class="back-btn">Back to Dashboard</a>
        <h2>Add a New Car</h2>
        <form action="UploadCarImage.jsp" method="post">
            <label for="car_name">Car Name:</label>
            <input type="text" id="car_name" name="car_name" required>

            <label for="car_number">Car Number:</label>
            <input type="text" id="car_number" name="car_number" required>

            <label for="company">Company:</label>
            <input type="text" id="company" name="company" required>

            <label for="type">Type:</label>
            <input type="text" id="type" name="type" required>

            <label for="seats">Seats:</label>
            <select id="seats" name="seats" required>
                <option value="2">2</option>
                <option value="4">4</option>
                <option value="6">6</option>
                <option value="8">8</option>
            </select>

            <!-- Field for price per kilometer -->
            <label for="price_per_km">Price per Kilometer:</label>
            <input type="text" id="price_per_km" name="price_per_km" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4"></textarea>

            <label for="status">Status:</label>
            <select id="status" name="status" required>
                <option value="available">Available</option>
                <option value="booked">Booked</option>
            </select>
            
            <button type="submit">Next</button>
        </form>
    </div>
</body>
</html>
