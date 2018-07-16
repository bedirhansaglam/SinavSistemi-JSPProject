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

//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Sinav";
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
		mesaj+= "G�ncelleme ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("4"))
		mesaj+= "G�ncelleme ��lemi Ba�ar�s�z";
	else if(sonuc.equals("5"))
	{
		olumlumu=true;
		mesaj+= "Silme ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("6"))
		mesaj+= "Silme ��lemi Ba�ar�s�z";	
}

//mesaj B�l�m� son
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

<div class="baslikcontainer"><label>S�nav Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz s�nav�n ismini yaz�n�z..."/></div>
  <div class="baslikcontainer"><label>Onay Bekleyen S�navlar</label></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Dersi Veren Hoca</th>
  	<th style="width:10%;">S�nav Ad�</th>
  	<th style="width:10%;">Tarih</th>
  	<th style="width:10%;">Saat</th>
  	<th style="width:10%;">Soru Say�s�</th>
  	<th style="width:10%;">Kitapc�k Say�s�</th>
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
TEBR�KLER H�� ONAY BEKLEYEN SINAVINIZ YOK
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