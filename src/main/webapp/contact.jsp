<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
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
        .contact-info {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .contact-info h3 {
            color: #4CAF50;
            margin-bottom: 10px;
        }
        .contact-info p {
            margin: 10px 0;
            line-height: 1.6;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            resize: vertical;
        }
        button {
            background-color: #5D5FEF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #4CAF50;
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
    <h2>Contact Us</h2>
    <div class="contact-info">
        <h3>Our Address</h3>
        <p>1234 Rent A Ride Street<br>City, Country 12345</p>
        <h3>Phone</h3>
        <p>+1 (555) 123-4567</p>
        <h3>Email</h3>
        <p>info@rentaride.com</p>
    </div>

    <h3>Send Us a Message</h3>
    <form action="ContactServlet" method="post">
        <div class="form-group">
            <label for="name">Your Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="email">Your Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="5" required></textarea>
        </div>
        <button type="submit">Submit</button>
    </form>
</div>

<footer>
    <div class="container">
        <p>&copy; 2024 Rent A Ride. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
    </div>
</footer>

</body>
</html>
