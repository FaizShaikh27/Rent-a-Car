package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/UpdateCarServlet")
public class UpdateCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));

        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "SELECT * FROM cars WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, carId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("carId", rs.getInt("id"));
                request.setAttribute("carName", rs.getString("car_name"));
                request.setAttribute("carNumber", rs.getString("car_number"));
                request.setAttribute("company", rs.getString("company"));
                request.setAttribute("type", rs.getString("type"));
                request.setAttribute("seats", rs.getInt("seats"));
                request.setAttribute("pricePerKm", rs.getDouble("price_per_km")); // Updated field
                request.setAttribute("description", rs.getString("description"));
                request.setAttribute("status", rs.getString("status"));
            }

            rs.close();
            ps.close();
            conn.close();

            // Forward to updateCar.jsp with car details
            RequestDispatcher dispatcher = request.getRequestDispatcher("updateCar.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        String carName = request.getParameter("carName");
        String carNumber = request.getParameter("carNumber");
        String company = request.getParameter("company");
        String type = request.getParameter("type");
        int seats = Integer.parseInt(request.getParameter("seats"));
        double pricePerKm = Double.parseDouble(request.getParameter("pricePerKm")); // Updated field
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // If status is changed to available, delete associated bookings
            if ("available".equals(status)) {
                String deleteBookingsSQL = "DELETE FROM bookings WHERE car_id = ?";
                PreparedStatement deleteStmt = conn.prepareStatement(deleteBookingsSQL);
                deleteStmt.setInt(1, carId);
                deleteStmt.executeUpdate();
                deleteStmt.close();
            }

            String sql = "UPDATE cars SET car_name = ?, car_number = ?, company = ?, type = ?, seats = ?, price_per_km = ?, description = ?, status = ? WHERE id = ?"; // Updated field
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, carName);
            ps.setString(2, carNumber);
            ps.setString(3, company);
            ps.setString(4, type);
            ps.setInt(5, seats);
            ps.setDouble(6, pricePerKm); // Updated field
            ps.setString(7, description);
            ps.setString(8, status);
            ps.setInt(9, carId);

            int updated = ps.executeUpdate();

            ps.close();
            conn.close();

            if (updated > 0) {
                response.sendRedirect("manageCars.jsp?updateSuccess=true");
            } else {
                response.sendRedirect("manageCars.jsp?updateFailure=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
