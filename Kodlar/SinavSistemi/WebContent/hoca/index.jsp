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
<label>HOÞGELDÝNÝZ</label><br>
<label><span class="glyphicon glyphicon-book">&nbsp;</span>DERS ÝÞLEMLERÝ : Bu bölümden verdiðiniz dersleri görebilir , yeni dersler ekleyebilir ve onay bekleyen derslerinizi görebilirsiniz Not:Eklediðiniz yeni dersler yönetici onayý verilmeden kabul edilmez</label><br>
<label><span class="glyphicon glyphicon-book">&nbsp;</span>ÖÐRENCÝ DERS ONAY: Bu bölümden danýþmaný olduðunuz öðrencilerin seçmiþ olduðu dersleri onaylabilirsiniz.</label><br>
<label><span class="glyphicon glyphicon-question-sign">&nbsp;</span>SORU ÝÞLEMLERÝ: Bu bölümden vermiþ olduðunuz dersler ile ilgili soru ekleyebilir , önceden eklediðiniz soruyu güncelleyebilir veya soruyu silebilirsiniz</label><br>
<label><span class="glyphicon glyphicon-list-alt">&nbsp;</span>SINAV ÝÞLEMLERÝ: Bu bölümden vermiþ olduðunuz dersler ile ilgili sýnavlarý oluþturabilirsiniz. Not: Sýnavlar yönetici onayý olmadan iþleme alýnmaz</label>
</div>

</body>
</html>