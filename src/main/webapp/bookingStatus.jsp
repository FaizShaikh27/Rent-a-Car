<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link rel="stylesheet" href="navbar.css">
    <link rel="stylesheet" href="footer.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h2 {
            color: #4CAF50;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        footer {
            margin-top: 90vh;
            margin-bottom: 0;
        }
    </style>
</head>
<body>

<%
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_system", "root", "Faiz@2727");

        // Query to get all bookings for the logged-in user
        String sql = "SELECT b.*, c.car_name, c.car_number FROM bookings b INNER JOIN cars c ON b.car_id = c.id WHERE b.user_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        rs = stmt.executeQuery();
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

<h2>My Bookings</h2>

<table>
    <tr>
        <th>Car Name</th>
        <th>Car Number</th>
        <th>From Date</th>
        <th>To Date</th>
        <th>Pickup Address</th>
        <th>Drop Address</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    <%
        while (rs.next()) {
            String carName = rs.getString("car_name");
            String carNumber = rs.getString("car_number");
            String fromDate = rs.getString("from_date");
            String toDate = rs.getString("to_date");
            String pickupAddress = rs.getString("pickup_address");
            String dropAddress = rs.getString("drop_address");
            String status = rs.getString("status");
            int bookingId = rs.getInt("id"); // Assuming you have the booking ID

            String statusMessage = "";
            if ("cancelled".equals(status)) {
                statusMessage = "Cancelled";
            } else if ("done".equals(status)) {
                statusMessage = "Done";
            }
    %>
    <tr>
        <td><%= carName %></td>
        <td><%= carNumber %></td>
        <td><%= fromDate %></td>
        <td><%= toDate %></td>
        <td><%= pickupAddress %></td>
        <td><%= dropAddress %></td>
        <td><%= statusMessage.isEmpty() ? "Active" : statusMessage %></td>
        <td>
            <% if (statusMessage.isEmpty()) { %>
                <form action="CancelBookingServlet" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= bookingId %>">
                    <button type="submit">Cancel</button>
                </form>
                <form action="MarkBookingAsDoneServlet" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= bookingId %>">
                    <button type="submit">Done</button>
                </form>
                <form action="updateBooking.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= bookingId %>">
                    <button type="submit">Update</button>
                </form>
            <% } else { %>
                <span><%= statusMessage %></span>
            <% } %>
        </td>
    </tr>
    <%
        }
    %>
</table>

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
