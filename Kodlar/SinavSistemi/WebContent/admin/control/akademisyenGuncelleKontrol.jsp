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
<jsp:useBean id="akademisyen" class="models.Akademisyen"></jsp:useBean>
<jsp:setProperty property="*" name="akademisyen"/>

<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("id")!=null)
{
	int id=Integer.parseInt(request.getParameter("id"));
	if(akademisyen.getResim()==null)
		akademisyen.setResim("akademisyen.png");
	
	if(akademisyenCrud.updateAkademisyen(akademisyen, id))
	{
		response.sendRedirect("../akademisyen.jsp?sonuc=3");// 3 baþarýlý 4 baþarýsýz	
	}
	else
	{response.sendRedirect("../akademisyen.jsp?sonuc=4");}
	}
  %>
</div>
</body>
</html>
