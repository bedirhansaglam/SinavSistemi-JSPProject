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

<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	
	if(dersCrud.approveVerilenDers(id))
	{
		response.sendRedirect("../sinav.jsp?sonuc=1");
	}
	else
	{response.sendRedirect("../sinav.jsp?sonuc=2");}
	}
  %>
</div>
</body>
</html>
