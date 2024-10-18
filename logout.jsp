<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%
    // 세션 무효화
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate(); // 세션 무효화
    }

    // 로그아웃 후 로그인 페이지로 리다이렉트
    response.sendRedirect("index.jsp?logout=true");
%>