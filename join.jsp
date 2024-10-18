<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Join</title>
</head>
<body>
    <h1>Join</h1>
    <form method="post" action="joinAction.jsp">
        <label for="userID">ID:</label>
        <input type="text" id="userID" name="userID" required>
        <br>
        <label for="userPassword">Password:</label>
        <input type="password" id="userPassword" name="userPassword" required>
        <br>
        <input type="submit" value="Join">
    </form>
</body>
</html>