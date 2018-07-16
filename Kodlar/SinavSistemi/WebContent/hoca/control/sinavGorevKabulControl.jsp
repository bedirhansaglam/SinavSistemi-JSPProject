<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %>
<%
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("akademisyen_id")==null)
{
	response.sendRedirect("loginHoca.jsp");
	}
%>
<!DOCTYPE html>
<jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>

<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("sinav_id")!=null && request.getParameter("hoca_id")!=null)
{
	int sinav_id=Integer.parseInt(request.getParameter("sinav_id"));
	int hoca_id=Integer.parseInt(request.getParameter("hoca_id"));
	
	if(sinavCrud.HocaGorevKabul(sinav_id, hoca_id))
	{
		response.sendRedirect("../sinav.jsp?sonuc=3");
	}
	else
	{response.sendRedirect("../sinav.jsp?sonuc=4");}
	}
  %>
</div>
</body>
</html>
