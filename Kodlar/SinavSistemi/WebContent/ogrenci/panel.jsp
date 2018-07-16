<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
    <%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<%String adsoyad="";
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("ogrenci_id")!=null)
{
	
	int id=Integer.parseInt(session.getAttribute("ogrenci_id").toString());
	ResultSet ogrencibilgisi=ogrenciCrud.readOgrenci(id);
	while(ogrencibilgisi.next())
	{
		adsoyad=ogrencibilgisi.getString("ad")+" "+ogrencibilgisi.getString("soyad")+" Hoþgeldiniz";
	}
	}
%>
<!DOCTYPE html>
<html lang="tr" >
<head>
 <title>Öðrenci Paneli</title>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
<link rel='stylesheet prefetch' href='http://cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.3/animate.min.css'>
<link rel='stylesheet prefetch' href='http://cdnjs.cloudflare.com/ajax/libs/animate.css/3.2.3/animate.min.css'>
 <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <nav class="navbar navbar-inverse navbar-fixed-top bg">
  <div class="container bg" >
    <div class="collapse navbar-collapse bg">
      <ul class="nav navbar-nav navbar-right ">
        <li><a href="index.jsp"><span class="glyphicon glyphicon-user">&nbsp;</span><%=adsoyad %></a></li>
        <li><a href="control/loginOgrenciControl.jsp">Çýkýþ</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="container-fluid">
  <div class="col-md-3">
    <div id="sidebar">
      <ul class="nav navbar-nav side-bar">
        <li class="side-bar"><a href="ders.jsp"><span class="glyphicon glyphicon-book">&nbsp;</span>Ders Ýþlemleri</a></li>
        <li class="side-bar"><a href="sinav.jsp"><span class="glyphicon glyphicon-list-alt">&nbsp;</span>Sýnav Bilgileri</a></li>
        <li class="side-bar"><a href="danisman.jsp"><span class="glyphicon glyphicon-education">&nbsp;</span>Danýþman Bilgileri</a></li>
      </ul>
    </div>
  </div>
  

</div>
<script src='js/jquery.min.js'></script>
<script src='js/bootstrap.min.js'></script>
</body>

</html>
