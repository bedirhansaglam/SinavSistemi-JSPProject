<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %>
<%
request.setCharacterEncoding("ISO-8859-9");
%>
<!DOCTYPE html>
<jsp:useBean id="akademisyenCrud" class="crud.akademisyenCRUD"></jsp:useBean>
<html>
<head>
</head>
<body>
<div id="main">
<%if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	
	if(akademisyenCrud.deleteAkademisyen(id))
	{
		response.sendRedirect("../akademisyen.jsp?sonuc=5");// 5 ba�ar�l� 6 ba�ar�s�z	
	}
	else
	{response.sendRedirect("../akademisyen.jsp?sonuc=6");}
	} %>
</div>
</body>
</html>
