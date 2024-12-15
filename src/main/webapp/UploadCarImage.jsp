<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Car Image</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <link rel="stylesheet" href="upload-car.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="upload-image-container">
        <a href="addACar.jsp" class="back-btn">Back to Add Car</a>
        <h2>Upload Car Image</h2>
        <form action="SaveCarServlet" method="post" enctype="multipart/form-data">
            <!-- Hidden inputs to forward data from addACar.jsp -->
            <input type="hidden" name="car_name" value="${param.car_name}">
            <input type="hidden" name="car_number" value="${param.car_number}">
            <input type="hidden" name="company" value="${param.company}">
            <input type="hidden" name="type" value="${param.type}">
            <input type="hidden" name="seats" value="${param.seats}">
            <input type="hidden" name="price_per_km" value="${param.price_per_km}"> <!-- Updated field -->
            <input type="hidden" name="description" value="${param.description}">
            <input type="hidden" name="status" value="${param.status}">

            <label for="car_image">Image:</label>
            <input type="file" id="car_image" name="car_image" required>
            
            <button type="submit">Save Listing</button>
        </form>
    </div>
</body>
</html>
