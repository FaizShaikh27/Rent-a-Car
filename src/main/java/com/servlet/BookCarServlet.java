package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/BookCarServlet")
public class BookCarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Redirect if user is not logged in
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String carIdParam = request.getParameter("car_id");
        String fromDate = request.getParameter("from_date");
        String toDate = request.getParameter("to_date");
        String pickupAddress = request.getParameter("pickup_address");
        String dropAddress = request.getParameter("drop_address");
        String journeyDistanceParam = request.getParameter("journey_distance");

        if (carIdParam == null || fromDate == null || toDate == null || pickupAddress == null || 
            dropAddress == null || journeyDistanceParam == null) {
            response.sendRedirect("error.jsp?message=Missing booking information.");
            return;
        }

        int carId;
        double journeyDistance;
        try {
            carId = Integer.parseInt(carIdParam);
            journeyDistance = Double.parseDouble(journeyDistanceParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp?message=Invalid number format.");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental_system", "root", "Faiz@2727")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Fetch car details
            String carSql = "SELECT car_number, price_per_km FROM cars WHERE id=?";
            String carNumber = null;
            double pricePerKilometer = 0.0;

            try (PreparedStatement carStmt = conn.prepareStatement(carSql)) {
                carStmt.setInt(1, carId);
                try (ResultSet rs = carStmt.executeQuery()) {
                    if (rs.next()) {
                        carNumber = rs.getString("car_number");
                        pricePerKilometer = rs.getDouble("price_per_km");
                    } else {
                        response.sendRedirect("error.jsp?message=Car not found.");
                        return;
                    }
                }
            }

            // Calculate total cost
            double totalCost = journeyDistance * pricePerKilometer;

            // Insert booking details
            String bookingSql = "INSERT INTO bookings (user_id, car_id, from_date, to_date, pickup_address, drop_address, car_number, journey_distance, total_cost) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement bookingStmt = conn.prepareStatement(bookingSql)) {
                bookingStmt.setInt(1, userId);
                bookingStmt.setInt(2, carId);
                bookingStmt.setString(3, fromDate);
                bookingStmt.setString(4, toDate);
                bookingStmt.setString(5, pickupAddress);
                bookingStmt.setString(6, dropAddress);
                bookingStmt.setString(7, carNumber);
                bookingStmt.setDouble(8, journeyDistance);
                bookingStmt.setDouble(9, totalCost);
                bookingStmt.executeUpdate();
            }

            // Update car status to booked
            String updateCarSql = "UPDATE cars SET status='booked' WHERE id=?";
            try (PreparedStatement updateCarStmt = conn.prepareStatement(updateCarSql)) {
                updateCarStmt.setInt(1, carId);
                updateCarStmt.executeUpdate();
            }

            response.sendRedirect("bookingConfirmation.jsp"); // Redirect to confirmation page

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database driver not found.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Database error.");
        }
    }
}
