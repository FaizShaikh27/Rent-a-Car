<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Rent-A-Ride</title>
<link rel="stylesheet" href="navbar.css">
<link rel="stylesheet" href="login-form.css">
<link rel="stylesheet" href="footer.css">
</head>
<body>

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
	<div class="main-content">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>
            
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>
            
            <input type="submit" value="Login">
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>
    
    
    <footer>
	        <div class="container">
	            <p>&copy; 2024 RentARide. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
	        </div>
	    </footer>
</body>
</html>