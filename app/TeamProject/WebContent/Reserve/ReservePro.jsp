<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page 
		import java.sql.Connection;
		import java.sql.PreparedStatement;
		import java.sql.ResultSet;

		import connection.ConnectionDAO;
%>

 <h1>예약페이지 Pro</h1>

<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto"  class="Reserve.ReserveDTO" />
<jsp:setProperty property="*" name="dto"/>

<%  
	String guest = (String)session.getAttribute("memid");
	ReserveDAO dao = new ReserveDAO();
	dao.insertReservation(dto);
	dto = dao.Reserveinfo(guest);	
%>

