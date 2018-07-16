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
<jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<jsp:useBean id="ogrenci" class="models.Ogrenci"></jsp:useBean>
<jsp:setProperty property="*" name="ogrenci"/>
<head>
</head>
<body>
<div id="main">
<%
if(ogrenci.getResim()==null)
ogrenci.setResim("ogrenci.png");
if(ogrenciCrud.createOgrenci(ogrenci))
{
  	response.sendRedirect("../ogrenci.jsp?sonuc=1");// 1 baþarýlý 2 baþarýsýz
}
else
{	response.sendRedirect("../ogrenci.jsp?sonuc=2");
}

  %>

</div>
</body>
</html>
