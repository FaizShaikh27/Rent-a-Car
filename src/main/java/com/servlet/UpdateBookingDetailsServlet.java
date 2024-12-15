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

@WebServlet("/UpdateBookingDetailsServlet")
public class UpdateBookingDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String pickupAddress = request.getParameter("pickupAddress");
        String dropAddress = request.getParameter("dropAddress");

        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "UPDATE bookings SET from_date = ?, to_date = ?, pickup_address = ?, drop_address = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ps.setString(3, pickupAddress);
            ps.setString(4, dropAddress);
            ps.setInt(5, bookingId);

            int updated = ps.executeUpdate();

            ps.close();
            conn.close();

            if (updated > 0) {
                response.sendRedirect("bookingStatus.jsp?updateSuccess=true");
            } else {
                response.sendRedirect("bookingStatus.jsp?updateFailure=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        }
    }
}
