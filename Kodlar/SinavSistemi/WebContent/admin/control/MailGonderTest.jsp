<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<jsp:useBean id="mail" class="islemler.Mail"></jsp:useBean>
</head>
<body>

<%
String mesaj=" Sýnav göreviniz gelmiþtir detaylar için link : http://localhost:8080/SinavSistemi/admin/sinav.jsp ";
String email="bedirhanssaglam@gmail.com";

if(mail.Gonder(email, mesaj))
	out.print("mesaj gitti");
else
	out.print("mesaj gitmedi");
%>
</body>
</html>