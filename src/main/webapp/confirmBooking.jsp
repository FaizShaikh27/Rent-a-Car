<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Booking</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
        }
        .booking-details {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        label {
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        input[type="date"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
        }
        .cost-display {
            font-size: 1.2em;
            color: #333;
            font-weight: bold;
            margin-top: 10px;
        }
        .error-message {
            color: red;
            font-weight: bold;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
 <% String username = (session != null) ? (String) session.getAttribute("username") : null; %>
<div class="header">
    <div class="logo">
        <a href="index.jsp">Rent A Ride</a>
    </div>
    <div class="navbar">
        <ul class="nav-container">
            <li class="nav-element"><a href="index.jsp">Home</a></li>
            <li class="nav-element"><a href="rentCar.jsp">Rent A Car</a></li>
            <li class="nav-element"><a href="about.jsp">About Us</a></li>
            <li class="nav-element"><a href="contact.jsp">Contact Us</a></li>
            <% if (username == null) { %>
                    <li class="nav-element"><a href="login.jsp">Login</a></li>
                <% } else { %>
                    <li class="nav-element">
                        <a>Account</a>
                        <ul class="dropdown">
                            <li><a href="bookingStatus.jsp">Booking Status</a></li>
                            <li><a href="changePassword.jsp">Change Password</a></li>
                            <li><a href="myDetails.jsp">My Details</a></li>
                            <li><a href="logout.jsp">Logout</a></li>
                        </ul>
                    </li>
                <% } %>
        </ul>
    </div>
</div>

<%
    // Retrieve car details from request parameters
    //String carName = request.getParameter("car_name");
    //String carNumber = request.getParameter("car_number");
    //String company = request.getParameter("company");
    //String carType = request.getParameter("type");
    //String seats = request.getParameter("seats");
    //String pricePerKm = request.getParameter("price_per_km");
    //String description = request.getParameter("description");
    //String imagePath = request.getParameter("image_path") != null ? request.getParameter("image_path") : "no-image.png";
    //String carId = request.getParameter("car_id");

    // Check if car details are available
    //if (carName != null && !carName.isEmpty()) {
%>

<!--  
    
    -->
    <c:if test="${not empty param.car_name}">
    <div class="booking-details">
        <h2>Confirm Booking for ${param.car_name}</h2>
        <img src="${param.image_path != null ? param.image_path : 'no-image.png'}" alt="${param.car_name}">
        <p><strong>Car Number:</strong> ${param.car_number}</p>
        <p><strong>Company:</strong> ${param.company}</p>
        <p><strong>Type:</strong> ${param.type}</p>
        <p><strong>Seats:</strong> ${param.seats}</p>
        <p><strong>Price per KM:</strong> ₹<fmt:formatNumber value="${param.price_per_km}" /></p>
        <p><strong>Description:</strong> ${param.description}</p>

        <form action="BookCarServlet" method="post">
            <input type="hidden" name="car_id" value="${param.car_id}">

            <label for="from_date">From Date:</label>
            <input type="date" name="from_date" required>

            <label for="to_date">To Date:</label>
            <input type="date" name="to_date" required>
            
            <label for="pickup_address">Pickup Address:</label>
            <input type="text" name="pickup_address" required placeholder="Enter pickup address">
            
            <label for="drop_address">Drop Address:</label>
            <input type="text" name="drop_address" required placeholder="Enter drop address">
            
            <label for="journey_distance">Total Kilometers:</label>
            <input type="number" id="journey_distance" name="journey_distance" required placeholder="Enter total kilometers" min="1" oninput="calculateTotalCost()">
            
            <div id="total_cost" class="cost-display"></div>
            
            <button type="submit">Book Now</button>
        </form>
    </div>
</c:if>
<%
    //} else {
%>
   <!--   <p class="error-message">No car details provided. Please go back and select a car.</p>-->
<%
    //}
    
    
%>

<!-- Error Message if Car Details are Missing -->
<c:if test="${empty param.car_name}">
    <p class="error-message">No car details provided. Please go back and select a car.</p>
</c:if>

<footer>
    <div class="container">
        <p>&copy; 2024 Rent A Ride. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
    </div>
</footer>

<!-- 

 -->
<script>
    const pricePerKm = parseFloat("${param.price_per_km != null ? param.price_per_km : 0}");

    function calculateTotalCost() {
        const journeyDistance = parseFloat(document.getElementById("journey_distance").value);
        if (!isNaN(pricePerKm) && !isNaN(journeyDistance)) {
            const totalCost = pricePerKm * journeyDistance;
            document.getElementById("total_cost").innerText = "Total Cost: ₹" + totalCost.toFixed(2);
        } else {
            document.getElementById("total_cost").innerText = "";
        }
    }
</script>



</body>
</html>
