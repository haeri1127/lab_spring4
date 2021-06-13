<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
	
	List<Map<String,Object>> empList = (List<Map<String,Object>>)request.getAttribute("haha");
	
	for(int i=0; i<empList.size(); i++){
		out.print(i+"번째 사원 : "+empList.get(i));
		out.print("<br>");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
ㅎㅇㅎㅇ
</body>
</html>