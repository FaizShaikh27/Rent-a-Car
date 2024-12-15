package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MarkBookingAsDoneServlet")
public class MarkBookingAsDoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        Connection conn = null;
        PreparedStatement psBooking = null;
        PreparedStatement psCar = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // First, get the car_id associated with the booking
            String getCarIdSql = "SELECT car_id FROM bookings WHERE id = ?";
            psBooking = conn.prepareStatement(getCarIdSql);
            psBooking.setInt(1, bookingId);
            int carId = 0;
            var rs = psBooking.executeQuery();
            if (rs.next()) {
                carId = rs.getInt("car_id");
            }

            // Now, update the booking status to done
            String markDoneSql = "UPDATE bookings SET status = 'done' WHERE id = ?";
            psBooking = conn.prepareStatement(markDoneSql);
            psBooking.setInt(1, bookingId);
            psBooking.executeUpdate();

            // Update the car status to available
            String updateCarSql = "UPDATE cars SET status = 'available' WHERE id = ?";
            psCar = conn.prepareStatement(updateCarSql);
            psCar.setInt(1, carId);
            psCar.executeUpdate();

            response.sendRedirect("bookingStatus.jsp?doneSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        } finally {
            try {
                if (psBooking != null) psBooking.close();
                if (psCar != null) psCar.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}