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
<jsp:useBean id="ders" class="models.Ders" scope="session" ></jsp:useBean>
<jsp:setProperty property="*" name="ders"/>
<jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
<html>
<head>
</head>
<body>
<%
if(dersCrud.createDers(ders))
{response.sendRedirect("../ders.jsp?sonuc=1");// 1 baþarýlý 2 baþarýsýz
	}
else
{response.sendRedirect("../ders.jsp?sonuc=2");
	}
  %>

</body>
</html>
