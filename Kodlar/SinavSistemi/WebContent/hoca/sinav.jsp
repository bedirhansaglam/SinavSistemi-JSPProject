<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%request.setCharacterEncoding("ISO-8859-9");
int hoca_id=0;
if(request.getParameter("hoca_id")!=null)
{
	session.setAttribute("akademisyen_id",request.getParameter("hoca_id"));
	}
if(session.getAttribute("akademisyen_id")==null)
{
	response.sendRedirect("loginHoca.jsp");
	}
else
	hoca_id=Integer.parseInt(session.getAttribute("akademisyen_id").toString());
%>
    <!DOCTYPE html>    
    <jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
    <jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%
String butonname="Ekle";
String formaction="control/sinavEkleControl.jsp";
String baslik="Sinav Ekle";
String dersadi="";
int ders_id=0;

//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="S�nav ";
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
		mesaj+= "onaylam ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("4"))
		mesaj+= "onaylama ��lemi Ba�ar�s�z";
	else if(sonuc.equals("5"))
	{
		olumlumu=true;
		mesaj+= "onay silme ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("6"))
		mesaj+= "onay Silme ��lemi Ba�ar�s�z";	
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

 <%ResultSet rs=dersCrud.getVerilenDersler(hoca_id);

if(rs.next()){%>
 <div class="baslikcontainer"><label><%=baslik %></label></div>
<div class="formcontainer">
  <form action="<%=formaction %>" method="post">
  <div class="row">
	     <div class="col-25">
	       <label for="dname">Ders Ad�:</label>
	     </div>
	     <div class="col-75">
			    <select name="ders_id" class="dropdown-select">
			    <% if(request.getParameter("id")!=null) //g�ncelleme b�l�m�nde ge�erli b�l�m en �stte olsun diye bir kontrol
			    {%>
			    <option value=<%=ders_id %>><%=dersadi %></option>
			    <% }
			    
 do {
  if(ders_id!=Integer.parseInt(rs.getString("ders_id")) && !dersadi.equals(rs.getString("ders_adi"))){%>
			      <option value=<%=rs.getString("ders_id") %>><%=rs.getString("ders_adi") %></option>
<%}}while(rs.next()); %>
			    </select>
	     </div>
	 </div>
    <div class="row">
      <div class="col-25">
        <label for="fname">S�nav Ad�</label>
      </div>
      <div class="col-75">
        <select name="sinav_id" class="dropdown-select">
        <option value="1">Vize</option>
        <option value="2">Final</option>
        <option value="3">B�t�nleme</option>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Tarih</label>
      </div>
      <div class="col-75">
        <input type="date" id="lname" name="tarih"  required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Saat</label>
      </div>
      <div class="col-75">
        <input type="time" id="lname" name="saat"  required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Soru Say�s�</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="soru_sayisi"  required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Kitapc�k Say�s�</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="kitapcik_sayisi"  required>
      </div>
    </div>
    <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
 <%}else{ %>
 <div class="baslikcontainer"><label><%=baslik %></label></div>
 <div class="formcontainer">
 <h3>Verilen dersiniz olmad��� i�in l�tfen �nce ders ekleyiniz. E�er ders eklediyseniz onaylanmas� i�in sistem y�neticiniz ile ileti�ime ge�iniz</h3></div>
 <%} 
 
 rs=sinavCrud.getHocaSinavBilgisi(hoca_id);
 %>
 <div class="baslikcontainer"><label>Onay Bekleyen S�nav G�revleri</label></div>
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
  	<th style="width:10%;">�ehir</th>
  	<th style="width:10%;">Okul</th>
  	<th style="width:10%;">S�nav Salonu</th>
  	<th style="width:10%;">Onayla</th>
  	<th style="width:10%;">Sil</th>
  </tr>
 <% do {%>
  <tr>
	<td><%=rs.getString("ders_adi")+" "+rs.getString("sinav_adi") %></td>
	<td><%=rs.getString("tarih") %></td>
	<td><%=rs.getString("saat") %></td>
	<td><%=rs.getString("sehir_adi") %></td>
	<td><%=rs.getString("okul_adi") %></td>
	<td><%=rs.getString("sinif_adi") %></td>
	<td><a href='control/sinavGorevKabulControl.jsp?sinav_id=<%=rs.getString("sinav_id") %>&hoca_id=<%=hoca_id%>'><span class="glyphicon glyphicon-ok" style="font-size:24px; color:green;"></span></a></td>
  <td><a href='control/sinavGorevIptalControl.jsp?sinav_id=<%=rs.getString("sinav_id") %>&hoca_id=<%=hoca_id%>'><span class=" glyphicon glyphicon-trash" style="font-size:24px; color:red;"></span></a></td>
  </tr>
 
 <%}while(rs.next()); %>
 </table>
 </div>
 <%}else {%>
 <div class="alert-success">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
ONAY BEKLEYEN SINAV G�REV�N�Z BULUNMAMAKTADIR...
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