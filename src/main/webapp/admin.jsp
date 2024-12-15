<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null || !"admin".equals(username)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="admin-page.css" rel="stylesheet" />
</head>
<body>
    <div class="admin-dashboard">
        <!-- Header Section -->
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>This page is accessible to admin only.</p>
        </div>
        
        <!-- Button Row -->
        <div class="button-row">
            <a href="addACar.jsp" class="dashboard-btn">Add a Car</a>
            <a href="manageCars.jsp" class="dashboard-btn">Manage Cars</a>
            <a href="viewUsers.jsp" class="dashboard-btn">View All Users</a>
            <a href="viewAllBookings.jsp" class="dashboard-btn">View All Bookings</a>
            <a href="logout.jsp" class="dashboard-btn logout-btn">Logout</a>
        </div>

        <!-- Image Section -->
        <img src="administration.jpg" alt="Admin Section" class="dashboard-image">
    </div>
</body>
</html>
