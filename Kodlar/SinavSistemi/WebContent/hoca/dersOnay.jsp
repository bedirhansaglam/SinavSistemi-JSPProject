<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%
int hoca_id=0;
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("akademisyen_id")==null)
{
	response.sendRedirect("loginHoca.jsp");
	}
else
	hoca_id=Integer.parseInt(session.getAttribute("akademisyen_id").toString());
%>
    <!DOCTYPE html>    
    <jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%
//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Ders ";
if(request.getParameter("sonuc")!=null)
{	sonucVarmi=true;
	String sonuc=request.getParameter("sonuc");
	if(sonuc.equals("1")) //yeni kayit baþarýlý
		{mesaj+=" Onaylama Ýþlemi Baþarýyla Gerçekleþti";
		olumlumu=true;}
	else if(sonuc.equals("2"))//yeni kayit baþarýsýz
		mesaj+="Onaylama Ýþlemi Baþarýsýz";
	else if(sonuc.equals("3")) // Güncelleme iþlemi baþarýlý
	{	olumlumu=true;
		mesaj+= "Onay Silme Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("4"))
		mesaj+= "Onay Silme Ýþlemi Baþarýsýz";
}

%>
<%if(sonucVarmi && olumlumu) { %>
<div class="alert-success">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
<%=mesaj %>
</div>
<%}else if(sonucVarmi && !olumlumu) { %>
<div class="alert-unsuccess">
 <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
<%=mesaj %>
</div>
<%}//mesaj Bölümü son %>
  <div class="baslikcontainer"><label>ÖÐRENCÝ DERS ONAY</label></div>
<% ResultSet onaybekleyendersler=ogrenciCrud.getButunOnayBekleyenDersler(hoca_id);
if(onaybekleyendersler.next()) {
%>
<div class="baslikcontainer"><label>Ders Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz dersin ismini yazýnýz..."/></div>
  <div class="baslikcontainer"><label>Onay Bekleyen Dersler</label></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Ders Adý</th>
  	<th style="width:10%;">Unvan</th>
  	<th style="width:10%;">Hoca Ad</th>
  	<th style="width:10%;">Hoca Soyad</th>
  	<th style="width:10%;">Öðrenci Ad</th>
  	<th style="width:10%;">Öðrenci Soyad</th>
  	<th style="width:10%;">Onayla</th>
  	<th style="width:10%;">Sil</th>
  </tr>
  <%
  do
  {
  %>
  <tr>
	<td><%=onaybekleyendersler.getString("ders_adi") %></td>
	<td><%=onaybekleyendersler.getString("unvan_adi") %></td>
	<td><%=onaybekleyendersler.getString("hoca_adi") %></td>
	<td><%=onaybekleyendersler.getString("hoca_soyadi") %></td>
	<td><%=onaybekleyendersler.getString("ad") %></td>
	<td><%=onaybekleyendersler.getString("soyad") %></td>
	<td><a href='control/dersOnaylaControl.jsp?id=<%=onaybekleyendersler.getString("id") %>'><span class="glyphicon glyphicon-ok" style="font-size:24px; color:green;"></span></a></td>
	<td><a href='control/dersOnaylaSilControl.jsp?id=<%=onaybekleyendersler.getString("id") %>'><span class="glyphicon glyphicon-trash" style="font-size:24px; color:red;"></span></a></td>
  </tr>
<%}while(onaybekleyendersler.next()); %>
</table>
 </div>
 
  <div class="baslikcontainer" style="background-color: #4CAF50"><a href='control/butunDersleriOnaylaControl.jsp?id=1'><input type="submit" value="Bütün Dersleri Onayla"></a></div>
<%}
else{%>
<div class="alert-success">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
TEBRÝKLER HÝÇ ONAY BEKLEYEN DERSÝNÝZ YOK
</div>
 
 <%} %>
 <script type="text/javascript">
 function myFunction() {

	  var input, filter, table, tr, td, i; //degiskenler ataniyor
	  input = document.getElementById("ara"); //input nesnesi cekiliyor
	  filter = input.value.toUpperCase(); //buyuk kucuk harf sorurunu cozmek icin hepsi buyuk yapiliyor
	  table = document.getElementById("myTable"); //tablo nesnesi cekiliyor
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar alýnýyor


	  for (i = 0; i < tr.length; i++) { //tablodaki satýr sayýsý kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[0]; //Tablodaki etiket deðerlerinin sýrasýna göre arama yapýlýyor dersadi bölümü 1.sýrada olduðu için 0 nolu index kontrol edilir
	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) { //filtereye gore arama yapýlýyor eger deger -1 den buyukse deger gosteriliyor
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";//filtreden gecemeyen degerler gosterilmiyor
	      }
	    } 
	  }
	}
 </script>
</body>
</html>