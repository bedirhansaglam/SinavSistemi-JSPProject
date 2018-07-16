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
int soru_id;
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

if(soruCrud.createSoru(soru)) //soru ekle
{
	ResultSet rssoru_id=soruCrud.getSoruID(soru.getDers_id(), soru.getSoru()); //yeni eklenen soru id çekiliyor
	if (rssoru_id.next()) { 
	    do {
	    	soru_id=Integer.parseInt(rssoru_id.getString("soru_id"));
	    	dogrucevap.setSoru_id(soru_id);
	    	yanliscevap.setSoru_id(soru_id);
	    	yanliscevap1.setSoru_id(soru_id);
	    	yanliscevap2.setSoru_id(soru_id);
	    	if(cevapCrud.createCevap(dogrucevap)) //doðru cevabý ekle
	    		if(cevapCrud.createCevap(yanliscevap)) //yanlýþ cevabý ekle
	    			if(cevapCrud.createCevap(yanliscevap1))//yanlýþ cevabý ekle
	    				if(cevapCrud.createCevap(yanliscevap2))//yanlýþ cevabý ekle
	    					response.sendRedirect("../soru.jsp?sonuc=1"); //soru ve cevaplarý eklendiyse soru sayfasýna git
	    } while(rssoru_id.next());
	}
	else{response.sendRedirect("../soru.jsp?sonuc=2");}
  	
}
else
{	response.sendRedirect("../soru.jsp?sonuc=2");
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
