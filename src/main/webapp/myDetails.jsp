<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Details</title>
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
        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
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
        	margin-top: 5vh;
        	
        }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String name = "", contactNumber = "", email = "", gender = "", pincode = "", state = "", address = "";

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_system", "root", "Faiz@2727");

        // Fetch user details
        String sql = "SELECT name, contact_number, email, gender, pincode, state, address FROM users WHERE username=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            contactNumber = rs.getString("contact_number");
            email = rs.getString("email");
            gender = rs.getString("gender");
            pincode = rs.getString("pincode");
            state = rs.getString("state");
            address = rs.getString("address");
        }

        // Update user details
        if (request.getParameter("update") != null) {
            name = request.getParameter("name");
            contactNumber = request.getParameter("contact_number");
            email = request.getParameter("email");
            gender = request.getParameter("gender");
            pincode = request.getParameter("pincode");
            state = request.getParameter("state");
            address = request.getParameter("address");

            String updateSql = "UPDATE users SET name=?, contact_number=?, email=?, gender=?, pincode=?, state=?, address=? WHERE username=?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, name);
            updateStmt.setString(2, contactNumber);
            updateStmt.setString(3, email);
            updateStmt.setString(4, gender);
            updateStmt.setString(5, pincode);
            updateStmt.setString(6, state);
            updateStmt.setString(7, address);
            updateStmt.setString(8, username);
            updateStmt.executeUpdate();

            out.println("<h2>Details updated successfully!</h2>");
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
		 
<h2>My Details</h2>

<form action="myDetails.jsp" method="post">
    <label for="name">Name:</label>
    <input type="text" name="name" value="<%= name %>" required><br>

    <label for="contact_number">Contact Number:</label>
    <input type="text" name="contact_number" value="<%= contactNumber %>" required><br>

    <label for="email">Email:</label>
    <input type="email" name="email" value="<%= email %>" required><br>

    <label for="gender">Gender:</label>
    <select name="gender" required>
        <option value="Male" <%= gender.equals("Male") ? "selected" : "" %>>Male</option>
        <option value="Female" <%= gender.equals("Female") ? "selected" : "" %>>Female</option>
        <option value="Other" <%= gender.equals("Other") ? "selected" : "" %>>Other</option>
    </select><br>

    <label for="pincode">Pincode:</label>
    <input type="text" name="pincode" value="<%= pincode %>" required><br>

    <label for="state">State:</label>
    <input type="text" name="state" value="<%= state %>" required><br>

    <label for="address">Address:</label>
    <input type="text" name="address" value="<%= address %>" required><br>

    <button type="submit" name="update">Update Details</button>
</form>

<footer>
	        <div class="container">
	            <p>&copy; 2024 RentARide. All Rights Reserved. <a href="terms.jsp">Terms</a> | <a href="privacy.jsp">Privacy</a></p>
	        </div>
	    </footer>


</body>
</html>
