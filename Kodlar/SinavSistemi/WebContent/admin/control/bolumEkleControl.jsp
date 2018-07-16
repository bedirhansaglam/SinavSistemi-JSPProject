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
<jsp:useBean id="bolum" class="models.Bolum" scope="session" ></jsp:useBean>
<jsp:setProperty property="*" name="bolum"/>
<jsp:useBean id="bolumCrud" class="crud.BolumCRUD"></jsp:useBean>
<html>
<head>
</head>
<body>
<div id="main">
<%
if(bolumCrud.createBolum(bolum))
{response.sendRedirect("../bolum.jsp?sonuc=1");// 1 baþarýlý 2 baþarýsýz
	}
else
{response.sendRedirect("../bolum.jsp?sonuc=2");
	}
  %>

</div>
</body>
</html>
