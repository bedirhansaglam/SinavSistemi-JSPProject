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
<jsp:useBean id="bolumCrud" class="crud.BolumCRUD"></jsp:useBean>
<jsp:useBean id="bolum" class="models.Bolum" scope="session" ></jsp:useBean>
<jsp:setProperty property="*" name="bolum"/>
<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	
	if(bolumCrud.updateBolum(bolum,id))
	{
		response.sendRedirect("../bolum.jsp?sonuc=3");// 3 baþarýlý 4 baþarýsýz	
	}
	else
	{response.sendRedirect("../bolum.jsp?sonuc=4");}
	}
  %>
</div>
</body>
</html>
