<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }
        h2 {
            color: #4CAF50;
        }
        .logo {
            width: 100px; /* Adjust size as needed */
            height: auto;
            margin: 20px 0;
        }
        .message {
            font-size: 20px;
            margin: 20px 0;
        }
    </style>
    <script>
        // Redirect to index.jsp after 2 seconds
        setTimeout(function() {
            window.location.href = "index.jsp";
        }, 2000);
    </script>
</head>
<body>

<h2>Your Booking is Confirmed!</h2>
<img src="right-tick.png" alt="Booking Confirmed" class="logo"> <!-- Replace with actual logo path -->
<p class="message">Thank you for choosing us!</p>

</body>
</html>
