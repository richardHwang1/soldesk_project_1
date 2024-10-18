<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>
    <h2>회원가입</h2>

    <%
        
        String message = "";

        // POST REQUEST
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // 데이터베이스 연결 정보
            String url = "jdbc:mysql://database-1.c1ywc0cyclpd.ap-northeast-2.rds.amazonaws.com/test_db";
            String dbUser = "admin";
            String dbPassword = "password";

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // JDBC 드라이버 로드
                Class.forName("com.mysql.cj.jdbc.Driver");
                // 데이터베이스 연결
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // SQL 쿼리 작성
                String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);

                // 쿼리 실행
                int rows = pstmt.executeUpdate();

                if (rows > 0) {
                    message = "회원가입이 완료되었습니다!";
                } else {
                    message = "회원가입 실패. 다시 시도해 주세요.";
                }

            } catch (Exception e) {
                e.printStackTrace();
                message = "오류 발생: " + e.getMessage();
            } finally {
                // 자원 정리
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>
    

    <!-- 사용자 입력 폼 -->
    <form action="register.jsp" method="post">
        <label for="username">사용자 이름:</label>
        <input type="text" id="username" name="username" required><br><br>

        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="가입하기">
    </form>

    <!-- 결과 메시지 출력 -->
    <h3><%= message %></h3>
</body>
</html>

