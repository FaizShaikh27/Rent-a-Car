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

@WebServlet("/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String confirmation = request.getParameter("confirmation");
        int carId = Integer.parseInt(request.getParameter("carId"));

        if (!"confirm".equalsIgnoreCase(confirmation)) {
            // Redirect back to deleteCar.jsp with an error if confirmation is incorrect
            response.sendRedirect("deleteCar.jsp?carId=" + carId + "&error=Please%20type%20'confirm'%20to%20delete%20the%20car");
            return;
        }

        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "DELETE FROM cars WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, carId);

            int deleted = ps.executeUpdate();

            ps.close();
            conn.close();

            if (deleted > 0) {
                response.sendRedirect("manageCars.jsp?deleteSuccess=true");
            } else {
                response.sendRedirect("manageCars.jsp?deleteFailure=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        }
    }
}
