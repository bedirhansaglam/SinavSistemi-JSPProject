<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %>
<%
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("akademisyen_id")==null)
{
	response.sendRedirect("loginHoca.jsp");
	}
%>
<!DOCTYPE html>
<jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>
<jsp:useBean id="mail" class="islemler.Mail"></jsp:useBean>
<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("sinav_id")!=null && request.getParameter("hoca_id")!=null)
{
	int sinav_id=Integer.parseInt(request.getParameter("sinav_id"));
	int hoca_id=Integer.parseInt(request.getParameter("hoca_id"));
	int yeni_hoca_id=0;
	
	ResultSet yeniakademisyen=sinavCrud.getAkademisyen();
	if(yeniakademisyen.next())
	{
		do{
			yeni_hoca_id=Integer.parseInt(yeniakademisyen.getString("akademisyen_id"));
		}while(yeniakademisyen.next());
	}
	
	if(sinavCrud.HocaGorevIptal(sinav_id, hoca_id, yeni_hoca_id))
	{
		ResultSet hoca_gorev_bilgisi=sinavCrud.getHocaSinavBilgisi(yeni_hoca_id);
		String email="",mesaj="";
		if(hoca_gorev_bilgisi.next())
		{
			do{
				email=hoca_gorev_bilgisi.getString("email");
				email="bedirhanssaglam@gmail.com"; //bu b�l�m silindi�inde orjinal emaile mesaj gider
				mesaj="Say�n "+ hoca_gorev_bilgisi.getString("ad")+" "+hoca_gorev_bilgisi.getString("soyad")+"   "+hoca_gorev_bilgisi.getString("tarih")+" Tarihinde "+hoca_gorev_bilgisi.getString("saat")+" saatinde "
						+hoca_gorev_bilgisi.getString("sehir_adi")+"  ilinde "+hoca_gorev_bilgisi.getString("okul_adi")+" okulunda "+hoca_gorev_bilgisi.getString("ders_adi")+" "+hoca_gorev_bilgisi.getString("sinav_adi")+" s�nav� yap�lacakt�r.Sorumlu oldu�unuz s�n�f "
						+hoca_gorev_bilgisi.getString("sinif_adi")+" numaral� s�n�fd�r. E�er G�revi Kabul etmek istiyorsan�z sisteme giri� yap�p g�revi onaylaman�z gerekmektedir.  Sistem Giri� Linki : http://localhost:8080/SinavSistemi/hoca/sinav.jsp?hoca_id="+yeni_hoca_id;
				
			}while(hoca_gorev_bilgisi.next());
		}
		mail.Gonder(email, mesaj);
		response.sendRedirect("../sinav.jsp?sonuc=5");
	}
	else
	{response.sendRedirect("../sinav.jsp?sonuc=6");}
	}
  %>
</div>
</body>
</html>
