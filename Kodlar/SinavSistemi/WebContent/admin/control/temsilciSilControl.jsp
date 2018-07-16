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

<jsp:useBean id="temsilciCrud" class="crud.TemsilciCRUD"></jsp:useBean>
<html>
<head>
</head>
<body>
<div id="main">
<%if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	
	if(temsilciCrud.deleteTemsilci(id))
	{
		response.sendRedirect("../temsilci.jsp?sonuc=5");// 5 baþarýlý 6 baþarýsýz	
	}
	else
	{response.sendRedirect("../temsilci.jsp?sonuc=6");}
	} %>
</div>
</body>
</html>
