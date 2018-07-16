<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%
int ogrenci_id=0;
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("ogrenci_id")==null)
{
	response.sendRedirect("loginOgrenci.jsp");
	}
else
	ogrenci_id=Integer.parseInt(session.getAttribute("ogrenci_id").toString());
ArrayList<Integer> alinandersler=new ArrayList<Integer>();
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
		{mesaj+=" Ekleme Ýþlemi Baþarýyla Gerçekleþti";
		olumlumu=true;}
	else if(sonuc.equals("2"))//yeni kayit baþarýsýz
		mesaj+="Ekleme Ýþlemi Baþarýsýz";
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

 <div class="baslikcontainer"><label>Alýnan Dersler</label></div>
 <div class="tablecontainer">
 <table id="VerilenDersler" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Ders Adý</th>
  	<th style="width:10%;">Unvan</th>
  	<th style="width:10%;">Hoca Ad</th>
  	<th style="width:10%;">Hoca Soyad</th>
  </tr>
  <%ResultSet verilendersler=ogrenciCrud.getAlinanDersler(ogrenci_id);
  while(verilendersler.next())
  { alinandersler.add(Integer.parseInt(verilendersler.getString("ders_id")));
  %>
  <tr>
	<td><%=verilendersler.getString("ders_adi") %></td>
	<td><%=verilendersler.getString("unvan_adi") %></td>
	<td><%=verilendersler.getString("ad") %></td>
	<td><%=verilendersler.getString("soyad") %></td>
  </tr>
<%} %>
</table>
 </div>
  <div class="baslikcontainer"><label>Onay Bekleyen Dersler</label></div>
 <div class="tablecontainer">
 <table id="onayBekleyenDersler" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Ders Adý</th>
  	<th style="width:10%;">Unvan</th>
  	<th style="width:10%;">Hoca Ad</th>
  	<th style="width:10%;">Hoca Soyad</th>
  </tr>
  <%ResultSet onaybekleyendersler=ogrenciCrud.getOnayBekleyenDersler(ogrenci_id);
  while(onaybekleyendersler.next())
  {
  alinandersler.add(Integer.parseInt(onaybekleyendersler.getString("ders_id")));%>
  <tr>
	<td><%=onaybekleyendersler.getString("ders_adi") %></td>
	<td><%=onaybekleyendersler.getString("unvan_adi") %></td>
	<td><%=onaybekleyendersler.getString("ad") %></td>
	<td><%=onaybekleyendersler.getString("soyad") %></td>
  </tr>
<%} %>
</table>
 </div>
 
  <div class="baslikcontainer"><label>Ders Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz dersin ismini yazýnýz..."/></div>
 <div class="baslikcontainer"><label>Ders Ekle</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:10%;">Ders Adý</th>
  	<th style="width:10%;">Unvan</th>
  	<th style="width:10%;">Hoca Ad</th>
  	<th style="width:10%;">Hoca Soyad</th>
    <th style="width:10%;">Ekle</th>
  </tr>
  <%! static boolean dersVarmi(int ders_id, ArrayList<Integer> dersler)
  {
	  int sonuc=0;
	  sonuc=dersler.indexOf(ders_id);
	  if(sonuc==-1)
	  return true;
	  else return false;
  }%>
  <%
  ResultSet butundersler=ogrenciCrud.getAlinacakDersler(ogrenci_id);
  while(butundersler.next())
  { if(dersVarmi(Integer.parseInt(butundersler.getString("ders_id")), alinandersler)){
  %>
  <tr>
	<td><%=butundersler.getString("ders_adi") %></td>
	<td><%=butundersler.getString("unvan_adi") %></td>
	<td><%=butundersler.getString("ad") %></td>
	<td><%=butundersler.getString("soyad") %></td>
    <td><a href='control/alinanDersEkleControl.jsp?id=<%=butundersler.getString("ders_id")+"-"+butundersler.getString("akademisyen_id") %>'><span class="glyphicon glyphicon-ok" style="font-size:24px; color:green;"></span></a></td>
  </tr>
<%}} %>
</table>
 </div>
 
 <script type="text/javascript">
 function myFunction() {

	  var input, filter, table, tr, td, i; //degiskenler ataniyor
	  input = document.getElementById("ara"); //input nesnesi cekiliyor
	  filter = input.value.toUpperCase(); //buyuk kucuk harf sorurunu cozmek icin hepsi buyuk yapiliyor
	  table = document.getElementById("myTable"); //tablo nesnesi cekiliyor
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar alýnýyor


	  for (i = 0; i < tr.length; i++) { //tablodaki satýr sayýsý kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[1]; //Tablodaki etiket deðerlerinin sýrasýna göre arama yapýlýyor dersadi bölümü 2.sýrada olduðu için 1 nolu index kontrol edilir
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