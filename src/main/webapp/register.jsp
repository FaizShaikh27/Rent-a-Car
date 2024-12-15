<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register | Rent-A-Ride</title>
<link rel="stylesheet" href="navbar.css">
<link rel="stylesheet" href="register-form.css">
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
		 
	<div class="form-container">
        <h2 class="form-title">Register</h2>
        <form action="RegisterServlet" method="post" class="register-form">
            <label for="name" class="form-label">Name:</label>
            <input type="text" id="name" name="name" class="form-input" required><br>

            <label for="contact_number" class="form-label">Contact Number:</label>
            <input type="text" id="contact_number" name="contact_number" class="form-input" required><br>

            <label for="email" class="form-label">Email:</label>
            <input type="email" id="email" name="email" class="form-input" required><br>

            <label for="username" class="form-label">Username:</label>
            <input type="text" id="username" name="username" class="form-input" required><br>

            <label for="password" class="form-label">Password:</label>
            <input type="password" id="password" name="password" class="form-input" required><br>

            <label for="gender" class="form-label">Gender:</label>
            <select id="gender" name="gender" class="form-select" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select><br>

            <label for="pincode" class="form-label">Pincode:</label>
            <input type="text" id="pincode" name="pincode" class="form-input" required><br>

            <label for="state" class="form-label">State:</label>
            <input type="text" id="state" name="state" class="form-input" required><br>

            <label for="address" class="form-label">Address:</label>
            <textarea id="address" name="address" class="form-textarea" required></textarea><br>

            <label for="security_question" class="form-label">Security Question:</label>
            <select id="security_question" name="security_question" class="form-select" required>
                <option value="What is the name of your best friend?">What is the name of your best friend?</option>
                <option value="What is the name of your school?">What is the name of your school?</option>
                <option value="What is your favorite book?">What is your favorite book?</option>
            </select><br>

            <label for="answer" class="form-label">Answer:</label>
            <input type="text" id="answer" name="answer" class="form-input" required><br>

            <input type="submit" value="Register" class="form-submit">
        </form>
        <p class="form-footer">Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
    
    <footer>
	        <div class="container">
	            <p>&copy; 2024 RentARide. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
	        </div>
	    </footer>
</body>
</html>