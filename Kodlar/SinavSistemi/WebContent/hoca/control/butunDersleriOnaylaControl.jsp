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
<jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>

<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("id")!=null)
{

	if(ogrenciCrud.butunAlinanDersleriOnayla())
	{
		response.sendRedirect("../dersOnay.jsp?sonuc=1");
	}
	else
	{response.sendRedirect("../dersOnay.jsp?sonuc=2");}
	}
  %>
</div>
</body>
</html>
