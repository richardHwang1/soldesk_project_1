<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <style>
        body { font-family: Arial, sans-serif; }
        form { margin-top: 20px; }
    </style>
</head>
<body>
    <h1>로그인</h1>
    <form action="login.jsp" method="post">
        <label for="username">사용자 이름:</label><br>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">비밀번호:</label><br>
        <input type="password" id="password" name="password" required><br><br>
        <input type="submit" value="로그인">
    </form>

    <%
        // 로그인 처리
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            String jdbcUrl = "jdbc:mysql://database-1.c1ywc0cyclpd.ap-northeast-2.rds.amazonaws.com/test_db";
            String dbUser = "admin";
            String dbPassword = "password";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // 데이터베이스 연결
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // 사용자 인증 쿼리
                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                
                rs = pstmt.executeQuery();

                // 로그인 성공
                if (rs.next()) {
                    out.println("<p>로그인 성공! 환영합니다, " + username + "님.</p>");
                    
                    session.setAttribute("username", username);
                    response.sendRedirect("index.jsp");
                } else {
                    out.println("<p>로그인 실패: 사용자 이름 또는 비밀번호가 잘못되었습니다.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>오류 발생: " + e.getMessage() + "</p>");
            } finally {
                // 자원 해제
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</body>
</html>
