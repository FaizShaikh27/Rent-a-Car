package com.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/SaveCarServlet")
@MultipartConfig
public class SaveCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Car details from request parameters
        String carName = request.getParameter("car_name");
        String carNumber = request.getParameter("car_number");
        String company = request.getParameter("company");
        String type = request.getParameter("type");
        int seats = Integer.parseInt(request.getParameter("seats"));
        double pricePerKm = Double.parseDouble(request.getParameter("price_per_km")); // Updated field
        String description = request.getParameter("description");
        String status = request.getParameter("status");

        // Part object for the image
        Part imagePart = request.getPart("car_image");
        String fileName = imagePart.getSubmittedFileName();

        // Define paths: dynamic absolute path for storage and relative path for database
        String listingImagesPath = getServletContext().getRealPath("/ListingImages");
        String absolutePath = listingImagesPath + File.separator + fileName;
        String relativePath = "ListingImages/" + fileName; // Store this in the database

        // Ensure the directory exists
        File directory = new File(listingImagesPath);
        if (!directory.exists()) {
            directory.mkdirs(); // Create the directory if it doesn't exist
        }

        // Save image to the dynamically determined absolute path
        imagePart.write(absolutePath);

        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            // Insert car details into cars table
            String sqlCar = "INSERT INTO cars (car_name, car_number, company, type, seats, price_per_km, description, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmtCar = conn.prepareStatement(sqlCar, PreparedStatement.RETURN_GENERATED_KEYS);
            stmtCar.setString(1, carName);
            stmtCar.setString(2, carNumber);
            stmtCar.setString(3, company);
            stmtCar.setString(4, type);
            stmtCar.setInt(5, seats);
            stmtCar.setDouble(6, pricePerKm); // Updated field
            stmtCar.setString(7, description);
            stmtCar.setString(8, status);
            stmtCar.executeUpdate();

            // Get the generated car ID
            int carId = 0;
            var generatedKeys = stmtCar.getGeneratedKeys();
            if (generatedKeys.next()) {
                carId = generatedKeys.getInt(1);
            }

            // Insert image path in car_images table
            String sqlImage = "INSERT INTO car_images (car_id, image_path) VALUES (?, ?)";
            PreparedStatement stmtImage = conn.prepareStatement(sqlImage);
            stmtImage.setInt(1, carId);
            stmtImage.setString(2, relativePath); // Save relative path
            stmtImage.executeUpdate();

            response.getWriter().println("Car listing saved successfully!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving car listing: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
