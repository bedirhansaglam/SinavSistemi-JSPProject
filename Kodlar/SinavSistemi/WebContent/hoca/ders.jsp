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
ArrayList<Integer> varolandersler=new ArrayList<Integer>();
%>
    <!DOCTYPE html>    
    <jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
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
		{mesaj+=" Ekleme ��lemi Ba�ar�yla Ger�ekle�ti";
		olumlumu=true;}
	else if(sonuc.equals("2"))//yeni kayit ba�ar�s�z
		mesaj+="Ekleme ��lemi Ba�ar�s�z";
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

 <div class="baslikcontainer"><label>Verilen Dersler</label></div>
 <div class="tablecontainer">
 <table id="VerilenDersler" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">B�l�m Ad�</th>
  	<th style="width:10%;">Ders Ad�</th>
  </tr>
  <%ResultSet verilendersler=dersCrud.getVerilenDersler(hoca_id);
  while(verilendersler.next())
  { varolandersler.add(Integer.parseInt(verilendersler.getString("ders_id")));
  %>
  <tr>
	<td><%=verilendersler.getString("bolum_adi") %></td>
	<td><%=verilendersler.getString("ders_adi") %></td>
  </tr>
<%} %>
</table>
 </div>
  <div class="baslikcontainer"><label>Onay Bekleyen Dersler</label></div>
 <div class="tablecontainer">
 <table id="onayBekleyenDersler" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">B�l�m Ad�</th>
  	<th style="width:10%;">Ders Ad�</th>
  </tr>
  <%ResultSet onaybekleyendersler=dersCrud.getHocaninOnayBekleyenDersleri(hoca_id);
  while(onaybekleyendersler.next())
  {
  varolandersler.add(Integer.parseInt(onaybekleyendersler.getString("ders_id")));%>
  <tr>
	<td><%=onaybekleyendersler.getString("bolum_adi") %></td>
	<td><%=onaybekleyendersler.getString("ders_adi") %></td>
  </tr>
<%} %>
</table>
 </div>
 
  <div class="baslikcontainer"><label>Ders Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz dersin ismini yaz�n�z..."/></div>
 <div class="baslikcontainer"><label>Ders Ekle</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:10%;">B�l�m Ad�</th>
  	<th style="width:10%;">Ders Ad�</th>
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
  ResultSet butundersler=dersCrud.readAllDers();
  while(butundersler.next())
  { if(dersVarmi(Integer.parseInt(butundersler.getString("ders_id")), varolandersler)){
  %>
  <tr>
	<td><%=butundersler.getString("bolum_adi") %></td>
	<td><%=butundersler.getString("ders_adi") %></td>
    <td><a href='control/verilenDersEkleControl.jsp?id=<%=butundersler.getString("ders_id") %>'><span class="glyphicon glyphicon-ok" style="font-size:24px; color:green;"></span></a></td>
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
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar al�n�yor


	  for (i = 0; i < tr.length; i++) { //tablodaki sat�r say�s� kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[1]; //Tablodaki etiket de�erlerinin s�ras�na g�re arama yap�l�yor dersadi b�l�m� 2.s�rada oldu�u i�in 1 nolu index kontrol edilir
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