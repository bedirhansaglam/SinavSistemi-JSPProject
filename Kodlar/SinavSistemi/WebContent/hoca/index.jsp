<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("akademisyen_id")==null)
{
	response.sendRedirect("loginHoca.jsp");
	}
%>
    <!DOCTYPE html>
<html>
<head>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>

<div class="baslikcontainer">
<label>HO�GELD�N�Z</label><br>
<label><span class="glyphicon glyphicon-book">&nbsp;</span>DERS ��LEMLER� : Bu b�l�mden verdi�iniz dersleri g�rebilir , yeni dersler ekleyebilir ve onay bekleyen derslerinizi g�rebilirsiniz Not:Ekledi�iniz yeni dersler y�netici onay� verilmeden kabul edilmez</label><br>
<label><span class="glyphicon glyphicon-book">&nbsp;</span>��RENC� DERS ONAY: Bu b�l�mden dan��man� oldu�unuz ��rencilerin se�mi� oldu�u dersleri onaylabilirsiniz.</label><br>
<label><span class="glyphicon glyphicon-question-sign">&nbsp;</span>SORU ��LEMLER�: Bu b�l�mden vermi� oldu�unuz dersler ile ilgili soru ekleyebilir , �nceden ekledi�iniz soruyu g�ncelleyebilir veya soruyu silebilirsiniz</label><br>
<label><span class="glyphicon glyphicon-list-alt">&nbsp;</span>SINAV ��LEMLER�: Bu b�l�mden vermi� oldu�unuz dersler ile ilgili s�navlar� olu�turabilirsiniz. Not: S�navlar y�netici onay� olmadan i�leme al�nmaz</label>
</div>

</body>
</html>