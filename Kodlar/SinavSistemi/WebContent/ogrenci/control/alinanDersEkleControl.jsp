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
<jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<html>
<head>

</head>
<body>
<div id="main">
<%//sonuc 1 ba�ar�l� 2 ba�ar�s�z
if(session.getAttribute("ogrenci_id")!=null) //e�er giri� yap�lm��sa i�lemleri yap
{
	if(request.getParameter("id")!=null)
	{
		String id=request.getParameter("id");
		String[] kelime;
		kelime=id.split("-");
		int ders_id,hoca_id;
		
		ders_id=Integer.parseInt(kelime[0]);
		hoca_id=Integer.parseInt(kelime[1]);
		
	int ogrenci_id=Integer.parseInt(session.getAttribute("ogrenci_id").toString());
	if(ogrenciCrud.DersAl(ogrenci_id,ders_id,hoca_id))
		response.sendRedirect("../ders.jsp?sonuc=1");
	else
		response.sendRedirect("../ders.jsp?sonuc=2");
		}

}
else 
{
	session.invalidate();
	response.sendRedirect("../loginOgrenci.jsp");}

  %>

</div>
</body>
</html>
