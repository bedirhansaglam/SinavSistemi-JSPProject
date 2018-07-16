<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%
request.setCharacterEncoding("ISO-8859-9");
%>
    <!DOCTYPE html>
<html>
<head>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>
<%String butonname="Ekle";
String formaction="sinavOnaylaControl.jsp";

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Sinav";
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
		mesaj+= "Güncelleme Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("4"))
		mesaj+= "Güncelleme Ýþlemi Baþarýsýz";
	else if(sonuc.equals("5"))
	{
		olumlumu=true;
		mesaj+= "Silme Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("6"))
		mesaj+= "Silme Ýþlemi Baþarýsýz";	
}

//mesaj Bölümü son
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
<%}

ResultSet onaybekleyensinavlar=sinavCrud.getOnayBekleyenSinavlar();
if(onaybekleyensinavlar.next()){
%>

<div class="baslikcontainer"><label>Sýnav Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz sýnavýn ismini yazýnýz..."/></div>
  <div class="baslikcontainer"><label>Onay Bekleyen Sýnavlar</label></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Dersi Veren Hoca</th>
  	<th style="width:10%;">Sýnav Adý</th>
  	<th style="width:10%;">Tarih</th>
  	<th style="width:10%;">Saat</th>
  	<th style="width:10%;">Soru Sayýsý</th>
  	<th style="width:10%;">Kitapcýk Sayýsý</th>
  	<th style="width:10%;">Onayla</th>
  </tr>
  <%
  do
  {
  %>
  <tr>
	<td><%=onaybekleyensinavlar.getString("unvan_adi")+" "+onaybekleyensinavlar.getString("ad")+" "+ onaybekleyensinavlar.getString("soyad") %></td>
	<td><%=onaybekleyensinavlar.getString("ders_adi")+" "+onaybekleyensinavlar.getString("sinav_adi") %></td>
	<td><%=onaybekleyensinavlar.getString("tarih") %></td>
	<td><%=onaybekleyensinavlar.getString("saat") %></td>
	<td><%=onaybekleyensinavlar.getString("soru_sayisi") %></td>
	<td><%=onaybekleyensinavlar.getString("kitapcik_sayisi") %></td>
	<td><a href='control/sinavOnaylaControl.jsp?sinav_id=<%=onaybekleyensinavlar.getString("sinav_id") %>&ders_id=<%=onaybekleyensinavlar.getString("ders_id")%>&hoca_id=<%=onaybekleyensinavlar.getString("sinav_hoca_id")%>'><span class="glyphicon glyphicon-ok" style="font-size:24px; color:green;"></span></a></td>
  </tr>
<%}while(onaybekleyensinavlar.next()); %>
</table>
 </div>
<%}
else{%>
<div class="alert-success">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
TEBRÝKLER HÝÇ ONAY BEKLEYEN SINAVINIZ YOK
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