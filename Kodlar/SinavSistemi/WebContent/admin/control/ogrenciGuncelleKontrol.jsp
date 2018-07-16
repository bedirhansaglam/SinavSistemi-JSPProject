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
<jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<jsp:useBean id="ogrenci" class="models.Ogrenci"></jsp:useBean>
<jsp:setProperty property="*" name="ogrenci"/>

<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	if(ogrenci.getResim()==null)
		ogrenci.setResim("ogrenci.png");
	
	if(ogrenciCrud.updateOgrenci(ogrenci, id))
	{
		response.sendRedirect("../ogrenci.jsp?sonuc=3");// 3 baþarýlý 4 baþarýsýz	
	}
	else
	{response.sendRedirect("../ogrenci.jsp?sonuc=4");}
	}
  %>
</div>
</body>
</html>
