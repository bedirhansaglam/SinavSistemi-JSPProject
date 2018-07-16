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
<jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
<jsp:useBean id="ders" class="models.Ders" scope="session" ></jsp:useBean>
<jsp:setProperty property="*" name="ders"/>
<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	
	if(dersCrud.updateDers(ders, id))
	{
		response.sendRedirect("../ders.jsp?sonuc=3");// 3 baþarýlý 4 baþarýsýz	
	}
	else
	{response.sendRedirect("../ders.jsp?sonuc=4");}
	}
  %>
</div>
</body>
</html>
