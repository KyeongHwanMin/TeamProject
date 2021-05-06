<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  파일 업로드를 하기 위한 클래스 -->
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<!-- 파일 이름 중복검사 후 중복일 경우 자동으로 다른 이름으로 교체해줌.. -->
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import = "java.util.Enumeration" %>
<%@ page import = "java.io.File" %>
<%@ page import = "latterboard.LatterBoardDAO"%>
<%@ page import = "java.sql.Timestamp"%>


<jsp:useBean id="dto" class="latterboard.LatterBoardDTO"/>
<jsp:setProperty name="dto" property="*" />

<%
	// 파일저장경로, 포맷사이즈, 한글파일 인코딩 처리
	String savePath = request.getRealPath("/Images/latterBoard");
	int maxSize = 1024*1024*50; // 50Mb
	String enc = "UTF-8";
	DefaultFileRenamePolicy drp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,savePath,maxSize,enc,drp);
	
	String on = mr.getOriginalFileName("file"); // 원본 파일명
	dto.setFilename(on);
	String sn = mr.getFilesystemName("file"); // 업로드된 파일명
	dto.setRealname(sn);
	dto.setFilepath("/TeamProject/Images/latterBoard/"+on);
	
	
	String id = (String)session.getAttribute("memId");
	dto.setReg_date(new Timestamp(System.currentTimeMillis()));
	dto.setIp(request.getRemoteAddr());
	dto.setWriter(id);
	
	
	LatterBoardDAO dao = new LatterBoardDAO();
	dao.insertArticle(dto);
	
	response.sendRedirect("latterBoard.jsp");
%>