<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %>
<%@page import="java.sql.ResultSet"%>

<%
request.setCharacterEncoding("ISO-8859-9");
%>
<!DOCTYPE html>

<jsp:useBean id="adminCrud" class="islemler.Sayilar"></jsp:useBean>
<html>
<head>

</head>
<body>
<div id="main">
<%
if(session.getAttribute("admin_id")==null) //e�er giri� yap�lmam��sa giri� yapmak i�in i�lemleri ba�lat
{
String email=request.getParameter("email");
String sifre=request.getParameter("sifre");

ResultSet sonuc=adminCrud.adminGiris(email, sifre);

if (sonuc.next()) { //e�er bir sonu� varsa yani bu bilgilere ait email ve sifre varsa giris yap
    do {
    	session.setAttribute("admin_id", sonuc.getString("id"));
    	response.sendRedirect("../ogrenci.jsp");
    } while(sonuc.next());
} else {
	response.sendRedirect("../loginYonetici.jsp?sonuc=0"); //yoksa geri d�n
}
}
else //giri� yap�lm��sa ��k�lmak isteniyordur ��kmak i�in session yok edilir giris sayfas�na yonlendirilir
{
	session.invalidate();
	response.sendRedirect("../../index.jsp");}
  %>

</div>
</body>
</html>
