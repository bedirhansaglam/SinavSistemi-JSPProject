<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="tr" >
<jsp:useBean id="sayilar" class="islemler.Sayilar"></jsp:useBean>
<head>
  <meta charset="UTF-8">
  <title>SINAV SÝSTEMÝ</title>
  	<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
  	<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css'>
	<link rel='stylesheet prefetch' href='https://neo.speedyapplication.com/Portals/_default/Skins/NEO/core/css/base/base.css'>
  	<link rel="stylesheet" href="css/style.css">
</head>
<body style="background-color:#333232">

<% String okul="",bolum="",akademisyen="",ogrenci="";
ResultSet sayi=sayilar.countAkademisyen();
while(sayi.next())
	akademisyen=sayi.getString("akademisyen_sayisi");

sayi=sayilar.countBolum();
while(sayi.next())
	bolum=sayi.getString("bolum_sayisi");
sayi=sayilar.countOgrenci();
while(sayi.next())
	ogrenci=sayi.getString("ogrenci_sayisi");
sayi=sayilar.countOkul();
while(sayi.next())
	okul=sayi.getString("okul_sayisi");
%>

  <div class="back-image content-116">
	<div class="spd-padding-top-bottom-100" style="background:rgba(0,0,0,.8);">
	<div class="spd-row">
		<div class="spd-col-md-3 spd-col-sm-3 text-center pos-rel">
		<span class="counter" style="display: inline-block;"><%=okul %></span>
			<div class="orange-line"></div>
      <h5 class="counterBoxDetails"> OKUL </h5>
		</div>
		
		<div class="spd-col-md-3 spd-col-sm-3 text-center">
		<span class="counter" style="display: inline-block;"><%=bolum %></span>
			<div class="orange-line"></div>
      <h5 class="counterBoxDetails"> BÖLÜM </h5>
			
		</div>
		
		<div class="spd-col-md-3 spd-col-sm-3 text-center">
		<span class="counter" style="display: inline-block;"><%=akademisyen %></span>
		<div class="orange-line"></div>
	    <h5 class="counterBoxDetails"> AKADEMÝSYEN</h5>
		</div>
		
		<div class="spd-col-md-3 spd-col-sm-3 text-center">
		<span class="counter" style="display: inline-block;"><%=ogrenci %></span>
		<div class="orange-line"></div>
      	<h5 class="counterBoxDetails"> ÖÐRENCÝ </h5>
		</div>
		</div>
	</div>
</div>
<div class="back-image content-116">
	<div class="spd-padding-top-bottom-100" style="background:rgba(0,0,0,.8);" >
	<div class="spd-row">
	
	<div class="spd-col-md-3 spd-col-sm-3 text-center " style=" margin-left:150px">
	<a href="ogrenci/loginOgrenci.jsp">
	<label style="color:#fff">ÖÐRENCÝ GÝRÝÞÝ</label>
	<img  src="source/images/ogrenci.png" width="256" height="256"/></a>
	</div>
		
	<div class="spd-col-md-3 spd-col-sm-3 text-center">
	<label style="color:#fff">AKADEMÝSYEN GÝRÝÞÝ</label>
	<a href="hoca/loginHoca.jsp"><img  src="source/images/yetkili.png" width="200" height="200"/></a>
	</div>
	
	<div class="spd-col-md-3 spd-col-sm-3 text-center">
	<label style="color:#fff">ADMÝN GÝRÝÞÝ</label>
	<a href="admin/loginYonetici.jsp"><img  src="source/images/admin.png" width="200" height="200"/></a>
	</div>
	
	</div>
</div>

</div>

	<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
	<script src='http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js'></script>
	<script src='https://bfintal.github.io/Counter-Up/jquery.counterup.min.js'></script>
	<script  src="js/index.js"></script>
</body>

</html>
