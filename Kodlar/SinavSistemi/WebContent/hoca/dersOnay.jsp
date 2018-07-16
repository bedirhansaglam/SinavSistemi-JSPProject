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
//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Ders ";
if(request.getParameter("sonuc")!=null)
{	sonucVarmi=true;
	String sonuc=request.getParameter("sonuc");
	if(sonuc.equals("1")) //yeni kayit ba�ar�l�
		{mesaj+=" Onaylama ��lemi Ba�ar�yla Ger�ekle�ti";
		olumlumu=true;}
	else if(sonuc.equals("2"))//yeni kayit ba�ar�s�z
		mesaj+="Onaylama ��lemi Ba�ar�s�z";
	else if(sonuc.equals("3")) // G�ncelleme i�lemi ba�ar�l�
	{	olumlumu=true;
		mesaj+= "Onay Silme ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("4"))
		mesaj+= "Onay Silme ��lemi Ba�ar�s�z";
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
<%}//mesaj B�l�m� son %>
  <div class="baslikcontainer"><label>��RENC� DERS ONAY</label></div>
<% ResultSet onaybekleyendersler=ogrenciCrud.getButunOnayBekleyenDersler(hoca_id);
if(onaybekleyendersler.next()) {
%>
<div class="baslikcontainer"><label>Ders Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz dersin ismini yaz�n�z..."/></div>
  <div class="baslikcontainer"><label>Onay Bekleyen Dersler</label></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Ders Ad�</th>
  	<th style="width:10%;">Unvan</th>
  	<th style="width:10%;">Hoca Ad</th>
  	<th style="width:10%;">Hoca Soyad</th>
  	<th style="width:10%;">��renci Ad</th>
  	<th style="width:10%;">��renci Soyad</th>
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
 
  <div class="baslikcontainer" style="background-color: #4CAF50"><a href='control/butunDersleriOnaylaControl.jsp?id=1'><input type="submit" value="B�t�n Dersleri Onayla"></a></div>
<%}
else{%>
<div class="alert-success">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
TEBR�KLER H�� ONAY BEKLEYEN DERS�N�Z YOK
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
	    td = tr[i].getElementsByTagName("td")[0]; //Tablodaki etiket de�erlerinin s�ras�na g�re arama yap�l�yor dersadi b�l�m� 1.s�rada oldu�u i�in 0 nolu index kontrol edilir
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