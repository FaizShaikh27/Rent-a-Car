<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>About Us</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        h2 {
            color: #5D5FEF;
            text-align: center;
            margin-bottom: 20px;
        }
        .content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            line-height: 1.6;
        }
    </style>
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

<div class="container">
    <h2>About Us</h2>
    <div class="content">
        <p>Welcome to Rent A Ride, your trusted partner for convenient, affordable, and high-quality car rentals. We believe that renting a car should be a hassle-free experience, enabling you to explore new destinations with ease and comfort.</p>
        <p>Founded in 2024, Rent A Ride is committed to offering a diverse fleet of vehicles, from compact cars to spacious SUVs, ensuring that you can find the perfect vehicle for any occasion. We aim to provide transparent pricing, excellent customer support, and a seamless rental process that lets you focus on your journey, not the paperwork.</p>
        <p>Our mission is simple: to make car rentals accessible and reliable for everyone. Whether you're planning a road trip, need a ride for a business trip, or just want to experience the joy of driving something new, Rent A Ride is here to make it happen.</p>
        <p>Thank you for choosing us. Safe travels!</p>
    </div>
</div>

<footer>
    <div class="container">
        <p>&copy; 2024 Rent A Ride. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
    </div>
</footer>

</body>
</html>
