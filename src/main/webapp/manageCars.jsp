<%@ page import="java.sql.*, java.io.*" %> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Cars</title>
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
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
            background-color: #fff;
        }

        th {
            background-color: #5D5FEF;
            color: white;
        }

        img {
            width: 100px;
            height: auto;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        button {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            background-color: #5D5FEF;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #4343d3;
        }

        .back-button {
            padding: 10px 15px;
            background-color: #777;
            text-decoration: none;
            color: white;
            border-radius: 5px;
            margin-bottom: 20px;
            display: inline-block;
        }

        .back-button:hover {
            background-color: #555;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table {
                font-size: 14px;
            }

            img {
                width: 80px; /* Smaller images on mobile */
            }
        }
    </style>
</head>
<body>
    <a href="admin.jsp" class="back-button">Back to Admin</a>
    <h2>Manage Car Listings</h2>
    <table>
        <tr>
            <th>Car Name</th>
            <th>Car Number</th>
            <th>Company</th>
            <th>Type</th>
            <th>Seats</th>
            <th>Price per KM</th> <!-- Updated field -->
            <th>Description</th>
            <th>Status</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <%
            // Database connection setup
            String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
            String dbUser = "root";
            String dbPass = "Faiz@2727";

            Connection conn = null;
            PreparedStatement psCar = null;
            PreparedStatement psImage = null;
            ResultSet rsCar = null;
            ResultSet rsImage = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                // Query to get all car details
                String sqlCar = "SELECT * FROM cars";
                psCar = conn.prepareStatement(sqlCar);
                rsCar = psCar.executeQuery();

                while (rsCar.next()) {
                    int carId = rsCar.getInt("id");
                    String carName = rsCar.getString("car_name");
                    String carNumber = rsCar.getString("car_number");
                    String company = rsCar.getString("company");
                    String type = rsCar.getString("type");
                    int seats = rsCar.getInt("seats");
                    double pricePerKm = rsCar.getDouble("price_per_km"); // Updated field
                    String description = rsCar.getString("description");
                    String status = rsCar.getString("status");

                    // Get the car image path
                    String sqlImage = "SELECT image_path FROM car_images WHERE car_id = ?";
                    psImage = conn.prepareStatement(sqlImage);
                    psImage.setInt(1, carId);
                    rsImage = psImage.executeQuery();
                    String imagePath = rsImage.next() ? rsImage.getString("image_path") : "no-image.jpg"; // default if no image

        %>
        <tr>
            <td><%= carName %></td>
            <td><%= carNumber %></td>
            <td><%= company %></td>
            <td><%= type %></td>
            <td><%= seats %></td>
            <td>Rs.<%= pricePerKm %></td> <!-- Updated field -->
            <td><%= description %></td>
            <td><%= status %></td>
            <td><img src="<%= imagePath %>" alt="Car Image"></td>
            <td class="action-buttons">
                <form action="UpdateCarServlet" method="get" style="display:inline;">
                    <input type="hidden" name="carId" value="<%= carId %>">
                    <button type="submit">Update</button>
                </form>
                <form action="deleteCar.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="carId" value="<%= carId %>">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rsCar != null) rsCar.close();
                if (rsImage != null) rsImage.close();
                if (psCar != null) psCar.close();
                if (psImage != null) psImage.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>
