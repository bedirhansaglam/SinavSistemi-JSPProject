<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%request.setCharacterEncoding("ISO-8859-9");
int ogrenci_no=0;
if(session.getAttribute("ogrenci_id")==null)
	response.sendRedirect("loginOgrenci.jsp");
else
	ogrenci_no=Integer.parseInt(session.getAttribute("ogrenci_id").toString());
	
%>
    <!DOCTYPE html>    
    <jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%
ResultSet rs=sinavCrud.getOgrenciBilgisi(ogrenci_no);
 %>
 <div class="baslikcontainer"><label>SINAV B�LG�LER�</label></div>
 <%
 if(rs.next())
 {
%>
<div class="baslikcontainer"><label>S�nav Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz s�nav�n ismini yaz�n�z..."/></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">S�nav Ad�</th>
  	<th style="width:10%;">Tarih</th>
  	<th style="width:10%;">Saat</th>
  	<th style="width:10%;">Okul</th>
  	<th style="width:10%;">S�nav Salonu</th>
  	<th style="width:10%;">S�ra Numaras�</th>
  	<th style="width:10%;">Kitapc�k Numaras�</th>
  	<th style="width:10%;">Soru Say�s�</th>
  </tr>
 <% do {%>
  <tr>
	<td><%=rs.getString("ders_adi")+" "+rs.getString("sinav_adi") %></td>
	<td><%=rs.getString("tarih") %></td>
	<td><%=rs.getString("saat") %></td>
	<td><%=rs.getString("okul_adi") %></td>
	<td><%=rs.getString("sinif_adi") %></td>
	<td><%=rs.getString("sira_adi") %></td>
	<td><%=rs.getString("kitapcik_id") %></td>
	<td><%=rs.getString("soru_sayisi") %></td>
  </tr>
 
 <%}while(rs.next()); %>
 </table>
 </div>
 <%}else {%>
 <div class="alert-success">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
YAKINLARDA BULUNAN B�R SINAVINIZ YOK
</div>
 <%} %>
 <script type="text/javascript">
 function myFunction() {
	  var input, filter, table, tr, td, i; //degiskenler ataniyor
	  input = document.getElementById("ara"); //input nesnesi cekiliyor
	  filter = input.value.toUpperCase(); //buyuk kucuk harf sorurunu cozmek icin hepsi buyuk yapiliyor
	  table = document.getElementById("myTable"); //tablo nesnesi cekiliyor
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar al�n�yor

	  for (i = 0; i < tr.length; i++) { //tablodaki sat�r say�s� kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[0]; 
	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) { //filtereye gore arama yap�l�yor eger deger -1 den buyukse deger gosteriliyor
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