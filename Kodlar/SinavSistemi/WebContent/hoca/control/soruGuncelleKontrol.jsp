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
<jsp:useBean id="soru" class="models.Soru"></jsp:useBean>
<jsp:setProperty property="*" name="soru"/>
<jsp:useBean id="soruCrud" class="crud.SoruCRUD"></jsp:useBean>
<jsp:useBean id="dogrucevap" class="models.Cevap"></jsp:useBean>
<jsp:useBean id="yanliscevap" class="models.Cevap"></jsp:useBean>
<jsp:useBean id="yanliscevap1" class="models.Cevap"></jsp:useBean>
<jsp:useBean id="yanliscevap2" class="models.Cevap"></jsp:useBean>
<jsp:useBean id="cevapCrud" class="crud.CevapCRUD"></jsp:useBean>
<html>
<head>

</head>
<body>
<div id="main">
<%
if(session.getAttribute("akademisyen_id")!=null) //eðer giriþ yapýlmýþsa iþlemleri yap
{
//sonuc 1 baþarýlý 2 baþarýsýz
int soru_id=Integer.parseInt(request.getParameter("id"));
int hoca_id=Integer.parseInt(session.getAttribute("akademisyen_id").toString());
soru.setHoca_id(hoca_id);

dogrucevap.setCevap(request.getParameter("cevap"));
yanliscevap.setCevap(request.getParameter("cevap1"));
yanliscevap1.setCevap(request.getParameter("cevap2"));
yanliscevap2.setCevap(request.getParameter("cevap3"));

dogrucevap.setDogrumu(1);
yanliscevap.setDogrumu(0);
yanliscevap1.setDogrumu(0);
yanliscevap2.setDogrumu(0);

dogrucevap.setSoru_id(soru_id);
yanliscevap.setSoru_id(soru_id);
yanliscevap1.setSoru_id(soru_id);
yanliscevap2.setSoru_id(soru_id);

dogrucevap.setCevap_id(Integer.parseInt(request.getParameter("cevap_id")));
yanliscevap.setCevap_id(Integer.parseInt(request.getParameter("cevap1_id")));
yanliscevap1.setCevap_id(Integer.parseInt(request.getParameter("cevap2_id")));
yanliscevap2.setCevap_id(Integer.parseInt(request.getParameter("cevap3_id")));

if(soruCrud.updateSoru(soru, soru_id)) //soru guncelle
{
	if(cevapCrud.updateCevap(dogrucevap, dogrucevap.getCevap_id()))
		if(cevapCrud.updateCevap(yanliscevap, yanliscevap.getCevap_id()))
			if(cevapCrud.updateCevap(yanliscevap1, yanliscevap1.getCevap_id()))
				if(cevapCrud.updateCevap(yanliscevap2, yanliscevap2.getCevap_id()))
					response.sendRedirect("../soru.jsp?sonuc=3");
}
else
{	response.sendRedirect("../soru.jsp?sonuc=4");
}
}
else 
{
	session.invalidate();
	response.sendRedirect("../loginHoca.jsp");}

  %>

</div>
</body>
</html>
