<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rent A Car</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <style>
        .car-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }
        .car-card {
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 250px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
        .car-card img {
            width: 100%;
            height: auto;
            border-radius: 5px;
        }
        .car-card h3 {
            font-size: 18px;
            margin: 10px 0;
        }
        .car-card p {
            margin: 5px 0;
            color: #666;
        }
        .book-now-btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            text-decoration: none;
        }
        .book-now-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    // Check if the user is logged in
   
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_system", "root", "Faiz@2727");
        stmt = conn.createStatement();

        // Query to get available cars with image
        String sql = "SELECT cars.*, car_images.image_path FROM cars LEFT JOIN car_images ON cars.id = car_images.car_id WHERE cars.status='available'";
        rs = stmt.executeQuery(sql);
%>

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
                <li class="nav-element">
                    <a>Account</a>
                    <ul class="dropdown">    
                        <li class="nav-element"><a href="bookingStatus.jsp">Booking Status</a></li>
                        <li class="nav-element"><a href="changePassword.jsp">Change Password</a></li>
                        <li class="nav-element"><a href="myDetails.jsp">My Details</a></li>
                        <li class="nav-element"><a href="logout.jsp">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>

    <h2>Available Cars</h2>
    <div class="car-container">
        <%
            boolean hasCars = false; // Flag to check if there are cars
            while (rs.next()) {
                hasCars = true; // Set flag if at least one car is found
                String carName = rs.getString("car_name");
                String carNumber = rs.getString("car_number");
                String company = rs.getString("company");
                String carType = rs.getString("type");
                int seats = rs.getInt("seats");
                double pricePerKm = rs.getDouble("price_per_km");
                String description = rs.getString("description");
                String imagePath = rs.getString("image_path") != null ? rs.getString("image_path") : "no-image.png"; // Default image if not available
        %>
        <div class="car-card">
            <img src="<%= imagePath %>" alt="<%= carName %>">
            <h3><%= carName %></h3>
            <p><strong>Company:</strong> <%= company %></p>
            <p><strong>Car Number:</strong> <%= carNumber %></p>
            <p><strong>Type:</strong> <%= carType %></p>
            <p><strong>Seats:</strong> <%= seats %></p>
            <p><strong>Price per KM:</strong> ₹<%= pricePerKm %></p>
            <p><strong>Description:</strong> <%= description %></p>
            <form action="confirmBooking.jsp" method="get">
                <input type="hidden" name="car_id" value="<%= rs.getInt("id") %>">
                <input type="hidden" name="car_name" value="<%= carName %>">
                <input type="hidden" name="car_number" value="<%= carNumber %>">
                <input type="hidden" name="company" value="<%= company %>">
                <input type="hidden" name="type" value="<%= carType %>">
                <input type="hidden" name="seats" value="<%= seats %>">
                <input type="hidden" name="price_per_km" value="<%= pricePerKm %>">
                <input type="hidden" name="description" value="<%= description %>">
                <input type="hidden" name="image_path" value="<%= imagePath %>">
                <button type="submit" class="book-now-btn">Book Now</button>
            </form>
        </div>
        <%
            }
            if (!hasCars) {
        %>
            <p>No available cars at the moment.</p>
        <%
            }
        %>
    </div>
    
    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>

    <footer>
        <div class="container">
            <p>&copy; 2024 RentARide. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
        </div>
    </footer>

</body>
</html>
