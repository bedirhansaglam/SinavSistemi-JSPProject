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
<jsp:useBean id="okulCrud" class="crud.OkulCRUD"></jsp:useBean>
<jsp:useBean id="okul" class="models.Okul"></jsp:useBean>
<jsp:setProperty property="*" name="okul"/>
<head>
</head>
<body>
<div id="main">
<%

if(okulCrud.createOkul(okul))
{
  	response.sendRedirect("../okul.jsp?sonuc=1");// 1 baþarýlý 2 baþarýsýz
}
else
{	response.sendRedirect("../okul.jsp?sonuc=2");
}

  %>

</div>
</body>
</html>
