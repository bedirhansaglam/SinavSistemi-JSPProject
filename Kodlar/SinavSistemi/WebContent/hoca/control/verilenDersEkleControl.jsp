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

<jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
<html>
<head>

</head>
<body>
<div id="main">
<%
int hoca_id,ders_id;
if(session.getAttribute("akademisyen_id")==null) //eðer giriþ süresi dolmuþsa
{
	response.sendRedirect("../loginHoca.jsp");
}
else //giriþ yapýlmýþsa
{
	if(request.getParameter("id")!=null) //ders_id gelmiþ ise
	{
		hoca_id=Integer.parseInt(session.getAttribute("akademisyen_id").toString());
		ders_id=Integer.parseInt(request.getParameter("id"));
		if(dersCrud.insertVerilenDers(hoca_id, ders_id))
		{
			response.sendRedirect("../ders.jsp?sonuc=1");
		}
		else
		{
			response.sendRedirect("../ders.jsp?sonuc=2");
		}
	}
	
}
  %>

</div>
</body>
</html>
