<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %>

<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%
request.setCharacterEncoding("ISO-8859-9");
%>
<!DOCTYPE html>
<jsp:useBean id="akademisyen" class="models.Akademisyen"></jsp:useBean>
<jsp:setProperty property="*" name="akademisyen"/>
<jsp:useBean id="akademisyenCrud" class="crud.akademisyenCRUD"></jsp:useBean>
<html>
<head>

</head>
<body>
<div id="main">
<%

if(akademisyen.getResim()==null) //akademisyenin resmi yoksa sisstemdeki default resmi tanýmla
akademisyen.setResim("akademisyen.png");

if(akademisyenCrud.createAkademisyen(akademisyen)) //akademisyen ekle
{
  	response.sendRedirect("../akademisyen.jsp?sonuc=1");// 1 baþarýlý 2 baþarýsýz
}
else
{	response.sendRedirect("../akademisyen.jsp?sonuc=2");
}


  %>

</div>
</body>
</html>
