<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
request.setCharacterEncoding("ISO-8859-9");
session.invalidate();
%>
 <!DOCTYPE html>
<html>
<head>
<link href="css/loginYonetici.css" rel="stylesheet" type="text/css">
<title>SINAV S�STEM� HOCA G�R���</title>
</head>
<body>
<% if(request.getParameter("sonuc")!=null) { %>
<div class="alert-unsuccess">
 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
 Kullan�c� ad� yada �ifre hatal�
</div>
<%}//mesaj B�l�m� son %>
<div class="login">
	<h1>AKADEM�SYEN G�R���</h1>
    <form action="control/loginHocaControl.jsp"  method="post">
    	<input type="text" name="email" placeholder="email" required="required" />
        <input type="password" name="sifre" placeholder="�ifre" required="required" />
        <button type="submit" class="btn btn-primary btn-block btn-large">Giri� Yap</button>
    </form>
</div>
</body>
</html>