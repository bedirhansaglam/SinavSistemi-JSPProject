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
<jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
<html>
<head>
</head>
<body>
<%
if(request.getParameter("id")!=null)
{
if(dersCrud.ButunDersleriOnayla())
{response.sendRedirect("../dersonay.jsp?sonuc=1");// 1 ba�ar�l� 2 ba�ar�s�z
	}
else
{response.sendRedirect("../dersonay.jsp?sonuc=2");
	}
}
  %>

</body>
</html>
