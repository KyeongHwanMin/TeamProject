<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "latterboard.LatterBoardDAO" %>
<%@ page import = "latterboard.LatterBoardDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<script>
	document.onkeydown = trapRefresh;
	function trapRefresh(){
		if(event.keyCode == 116){
			event.keyCode = 0;
			event.cancelBubble = true;
			event.returnValue = false;
			document.location.reload();
		}
	}
</script>
<%
	int pageSize = 16;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List articleList = null;
	LatterBoardDAO dao = new LatterBoardDAO();
	count = dao.getArticleCount();
	if(count > 0){
		articleList = dao.getArticles(startRow, endRow);
	}
	number = count-(currentPage-1)*pageSize;
	String id = (String)session.getAttribute("memId");
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ShopMallMain JSP</title>
</head>
<body>
<div align="center">
	<h3>[후기 게시판]</h3>
	<table border="1">
		<tr>
			<td align = "right" colspan="4">
			<input type="button" value = "글쓰기" onclick="writeForm.jsp" />
			</td>
		</tr>
		<%
		if(count == 0){%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">
					게시판에 저장된 글이 없습니다.
				</td>
			</tr>
		</table>

		<%}
		else{
			for(int i = 0; i < articleList.size(); i++) {
				LatterBoardDTO dto = (LatterBoardDTO)articleList.get(i);
				if(i % 4 == 0) { %>
					<tr align='center'>
				<%} %>
					<td>
					<table>
						<tr align='center'>
							<td>
								<a href="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
								<%
								if(dto.getFilepath() != null){%>
								<img src = "<%=dto.getFilepath() %>" width='150' height='150' />
								<%}else{%>
								<img src = "/TeamProject/Images/latterBoard/unnamed.gif" width='150' height='150' />
								<%}%>
								</a>
							</td>
						</tr>
						<tr align='center'>
							<td>
								<a href="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
								<%=dto.getSubject()%>
								</a>
							</td>
						</tr>
						<tr align='center'>
							<td>
								<%=dto.getWriter()%>
							</td>
						</tr>
						<tr align='center'>
							<td>
							<%=sdf.format(dto.getReg_date())%>
							</td>
						</tr>
					</table>
				</td>
				<%
				if(i % 3 == 3) {%>
					</tr>
				<%}
			}
		}%>	
	</table>
</div>
</body>
</html>