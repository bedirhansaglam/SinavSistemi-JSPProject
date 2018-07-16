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

<jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<html>
<head>

</head>
<body>
<div id="main">
<%
if(session.getAttribute("ogrenci_id")==null) //eðer giriþ yapýlmamýþsa giriþ yapmak için iþlemleri baþlat
{
String email=request.getParameter("email");
String sifre=request.getParameter("sifre");

ResultSet sonuc=ogrenciCrud.OgrenciGiris(email, sifre);

if (sonuc.next()) { //eðer bir sonuç varsa yani bu bilgilere ait email ve sifre varsa giris yap
    do {
    	session.setAttribute("ogrenci_id", sonuc.getString("ogrenci_no"));
    	response.sendRedirect("../ders.jsp");
    } while(sonuc.next());
} else {
	response.sendRedirect("../loginOgrenci.jsp?sonuc=0"); //yoksa geri dön
}
}
else //giriþ yapýlmýþsa çýkýlmak isteniyordur çýkmak için session yok edilir giris sayfasýna yonlendirilir
{
	session.invalidate();
	response.sendRedirect("../../index.jsp");}
  %>

</div>
</body>
</html>
