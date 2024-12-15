<%@ page session="true" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rent-A-Ride</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="hero-section.css">
    <link rel="stylesheet" href="footer.css">
</head>
<body>
    <%-- Check if the user is logged in --%>
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

    <div class="hero-section">
        <video autoplay muted loop class="background-video">
            <source src="car.mp4" type="video/mp4">
        </video>
        <div class="hero-content">
            <h2>Drive with Us Safely</h2>
            <p>Rent our car from any city in India! Get the most secure and reliable cars on rent from us.</p>
            <a href="rentCar.jsp" class="cta-btn">Get a Car</a>
        </div>
    </div>
    
    <footer>
        <div class="container">
            <p>&copy; 2024 RentARide. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
        </div>
    </footer>
</body>
</html>
