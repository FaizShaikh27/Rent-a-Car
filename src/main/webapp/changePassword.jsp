<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="navbar.css">
	<link rel="stylesheet" href="footer.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        
        h2 {
            color: #4CAF50;
            width: 600px;
            margin:30px auto;
            
        }
        form {
            margin-top: 20px;
            width: 600px;
            margin: auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 600px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        footer{
        	margin-top: 39vh;
        	
        }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    String securityQuestion = "";
    String securityAnswer = request.getParameter("answer");
    String newPassword = request.getParameter("new_password");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_system", "root", "Faiz@2727");

        if (username != null) { // Ensure user is logged in
            if (securityAnswer != null && newPassword != null) {
                // Verify the security answer
                String sql = "SELECT answer FROM users WHERE username=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String correctAnswer = rs.getString("answer");

                    if (correctAnswer.equals(securityAnswer)) {
                        // Update the password
                        String updateSql = "UPDATE users SET password=? WHERE username=?";
                        PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                        updateStmt.setString(1, newPassword);
                        updateStmt.setString(2, username);
                        updateStmt.executeUpdate();
                        out.println("<h2>Password changed successfully!</h2>");
                    } else {
                        out.println("<h2>Security answer is incorrect!</h2>");
                    }
                }
            } else {
                // Get the security question
                String sqlQuestion = "SELECT security_question FROM users WHERE username=?";
                stmt = conn.prepareStatement(sqlQuestion);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    securityQuestion = rs.getString("security_question");
                }
            }
        } else {
            out.println("<h2>Please log in to change your password.</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
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
		 
		 
<div class="center">
	<h2>Change Password</h2>

<% if (securityQuestion != null && !securityQuestion.isEmpty()) { %>
    <form action="changePassword.jsp" method="post">
        <label for="security_question">Security Question:</label>
        <input type="text" value="<%= securityQuestion %>" readonly><br>
        
        <label for="answer">Answer:</label>
        <input type="text" name="answer" required><br>
        
        <label for="new_password">New Password:</label>
        <input type="password" name="new_password" required><br>
        
        <button type="submit">Change Password</button>
    </form>
<% } %>
</div>
		 


<footer>
	        <div class="container">
	            <p>&copy; 2024 RentARide. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
	        </div>
	    </footer>

</body>
</html>
