<%
    session.invalidate(); // Invalidate the session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
