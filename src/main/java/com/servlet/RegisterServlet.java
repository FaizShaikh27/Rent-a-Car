package com.servlet;

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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/RegisterServlet")

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String contactNumber = request.getParameter("contact_number");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String pincode = request.getParameter("pincode");
        String state = request.getParameter("state");
        String address = request.getParameter("address");
        String securityQuestion = request.getParameter("security_question");
        String answer = request.getParameter("answer");

        String dbURL = "jdbc:mysql://localhost:3306/car_rental_system";
        String dbUser = "root";
        String dbPass = "Faiz@2727";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            String sql = "INSERT INTO users (name, contact_number, email, username, password, gender, pincode, state, address, security_question, answer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, contactNumber);
            statement.setString(3, email);
            statement.setString(4, username);
            statement.setString(5, password);
            statement.setString(6, gender);
            statement.setString(7, pincode);
            statement.setString(8, state);
            statement.setString(9, address);
            statement.setString(10, securityQuestion);
            statement.setString(11, answer);

            int row = statement.executeUpdate();
            if (row > 0) {
                response.getWriter().println("Registration successful!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                dispatcher.forward(request, response);
            } else {
                response.getWriter().println("Error in registration.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database connection or query issue: " + e.getMessage());
        }
    }
}