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
%>
    <!DOCTYPE html>    
    <jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>

 <div class="baslikcontainer"><label>Danýþman Bilgileri</label></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Fotoðraf</th>
  	<th style="width:10%;">Unvan</th>
  	<th style="width:10%;">Hoca Ad</th>
  	<th style="width:10%;">Hoca Soyad</th>
  	<th style="width:10%;">Hoca Email</th>
  </tr>
  <%ResultSet danismanbilgisi=ogrenciCrud.getDanismanBilgileri(ogrenci_id);
  while(danismanbilgisi.next())
  {
  %>
  <tr>
  <td><img src="../source/images/<%=danismanbilgisi.getString("resim") %>"  width="45" height="45" /></td>
	<td><%=danismanbilgisi.getString("unvan_adi") %></td>
	<td><%=danismanbilgisi.getString("ad") %></td>
	<td><%=danismanbilgisi.getString("soyad") %></td>
	<td><%=danismanbilgisi.getString("email") %></td>
  </tr>
<%} %>
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