<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Booking</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h2 {
            color: #4CAF50;
        }
        form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="date"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #5D5FEF;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #4343d3;
        }
    </style>
</head>
<body>

<%
    Integer bookingId = Integer.parseInt(request.getParameter("bookingId"));
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_system", "root", "Faiz@2727");
        
        // Fetch booking details
        String sql = "SELECT * FROM bookings WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bookingId);
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            String fromDate = rs.getString("from_date");
            String toDate = rs.getString("to_date");
            String pickupAddress = rs.getString("pickup_address");
            String dropAddress = rs.getString("drop_address");
%>

<h2>Update Booking Details</h2>
<form action="UpdateBookingDetailsServlet" method="post">
    <input type="hidden" name="bookingId" value="<%= bookingId %>">
    
    <label>From Date:</label>
    <input type="date" name="fromDate" value="<%= fromDate %>" required>
    
    <label>To Date:</label>
    <input type="date" name="toDate" value="<%= toDate %>" required>
    
    <label>Pickup Address:</label>
    <input type="text" name="pickupAddress" value="<%= pickupAddress %>" required>
    
    <label>Drop Address:</label>
    <input type="text" name="dropAddress" value="<%= dropAddress %>" required>
    
    <button type="submit">Update Booking</button>
</form>

<%
        } else {
            out.println("<p>Booking not found.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

</body>
</html>
