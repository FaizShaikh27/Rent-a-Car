<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View All Bookings</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            color: #333;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #5D5FEF;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .back-button {
            padding: 10px 15px;
            background-color: #777;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            margin-bottom: 20px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #555;
        }
        .error-message {
            color: red;
            text-align: center;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <a href="admin.jsp" class="back-button">Back to Admin Dashboard</a>
    <h2>All Bookings</h2>
    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>User ID</th>
                <th>User Name</th>
                <th>Car ID</th>
                <th>Car Name</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>Pickup Address</th>
                <th>Drop Address</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
                String dbUser = "root";
                String dbPass = "Faiz@2727";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    String sql = "SELECT b.id as booking_id, u.id as user_id, u.name as user_name, b.car_id, c.car_name, b.from_date, b.to_date, b.pickup_address, b.drop_address, b.status FROM bookings b INNER JOIN users u ON b.user_id = u.id INNER JOIN cars c ON b.car_id = c.id";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("booking_id") %></td>
                            <td><%= rs.getInt("user_id") %></td>
                            <td><%= rs.getString("user_name") %></td>
                            <td><%= rs.getInt("car_id") %></td>
                            <td><%= rs.getString("car_name") %></td>
                            <td><%= rs.getDate("from_date") %></td>
                            <td><%= rs.getDate("to_date") %></td>
                            <td><%= rs.getString("pickup_address") %></td>
                            <td><%= rs.getString("drop_address") %></td>
                            <td><%= rs.getString("status") %></td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <tr>
                        <td colspan="10" class="error-message">Error loading bookings.</td>
                    </tr>
            <%
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</body>
</html>
