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

<html>
<jsp:useBean id="temsilci" class="models.Temsilci"></jsp:useBean>
<jsp:useBean id="temsilciCrud" class="crud.TemsilciCRUD"></jsp:useBean>
<jsp:setProperty property="*" name="temsilci"/>
<head>
</head>
<body>
<div id="main">
<%
if(temsilci.getResim()==null)
	temsilci.setResim("temsilci.png");
if(temsilciCrud.createTemsilci(temsilci))
{
  	response.sendRedirect("../temsilci.jsp?sonuc=1");// 1 baþarýlý 2 baþarýsýz
}
else
{	response.sendRedirect("../temsilci.jsp?sonuc=2");
}

  %>

</div>
</body>
</html>
