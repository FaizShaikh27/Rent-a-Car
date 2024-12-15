<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View All Users</title>
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

        .back-button, .view-activity-button {
            padding: 10px 15px;
            background-color: #777;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            margin-bottom: 20px;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        .back-button:hover, .view-activity-button:hover {
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
    <h2>All Registered Users</h2>
    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Contact Number</th>
                <th>Email</th>
                <th>Gender</th>
                <th>Pincode</th>
                <th>State</th>
                <th>Address</th>
                <th>Actions</th>
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
                    String sql = "SELECT id, name, contact_number, email, gender, pincode, state, address FROM users";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("contact_number") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("gender") %></td>
                            <td><%= rs.getString("pincode") %></td>
                            <td><%= rs.getString("state") %></td>
                            <td><%= rs.getString("address") %></td>
                            <td>
                                <a href="viewUserActivity.jsp?userId=<%= rs.getInt("id") %>" class="view-activity-button">View Activity</a>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <tr>
                        <td colspan="9" class="error-message">Error loading users.</td>
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
