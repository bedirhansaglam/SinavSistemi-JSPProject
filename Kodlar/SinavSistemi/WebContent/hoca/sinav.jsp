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

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Sýnav ";
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
		mesaj+= "onaylam Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("4"))
		mesaj+= "onaylama Ýþlemi Baþarýsýz";
	else if(sonuc.equals("5"))
	{
		olumlumu=true;
		mesaj+= "onay silme Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("6"))
		mesaj+= "onay Silme Ýþlemi Baþarýsýz";	
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

 <%ResultSet rs=dersCrud.getVerilenDersler(hoca_id);

if(rs.next()){%>
 <div class="baslikcontainer"><label><%=baslik %></label></div>
<div class="formcontainer">
  <form action="<%=formaction %>" method="post">
  <div class="row">
	     <div class="col-25">
	       <label for="dname">Ders Adý:</label>
	     </div>
	     <div class="col-75">
			    <select name="ders_id" class="dropdown-select">
			    <% if(request.getParameter("id")!=null) //güncelleme bölümünde geçerli bölüm en üstte olsun diye bir kontrol
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
        <label for="fname">Sýnav Adý</label>
      </div>
      <div class="col-75">
        <select name="sinav_id" class="dropdown-select">
        <option value="1">Vize</option>
        <option value="2">Final</option>
        <option value="3">Bütünleme</option>
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
        <label for="lname">Soru Sayýsý</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="soru_sayisi"  required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Kitapcýk Sayýsý</label>
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
 <h3>Verilen dersiniz olmadýðý için lütfen önce ders ekleyiniz. Eðer ders eklediyseniz onaylanmasý için sistem yöneticiniz ile iletiþime geçiniz</h3></div>
 <%} 
 
 rs=sinavCrud.getHocaSinavBilgisi(hoca_id);
 %>
 <div class="baslikcontainer"><label>Onay Bekleyen Sýnav Görevleri</label></div>
 <%
 if(rs.next())
 {
%>
<div class="baslikcontainer"><label>Sýnav Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz sýnavýn ismini yazýnýz..."/></div>
 <div class="tablecontainer">
 <table id="myTable" class="tablolar">
  <tr class="header">
  	<th style="width:10%;">Sýnav Adý</th>
  	<th style="width:10%;">Tarih</th>
  	<th style="width:10%;">Saat</th>
  	<th style="width:10%;">Þehir</th>
  	<th style="width:10%;">Okul</th>
  	<th style="width:10%;">Sýnav Salonu</th>
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
ONAY BEKLEYEN SINAV GÖREVÝNÝZ BULUNMAMAKTADIR...
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
	    td = tr[i].getElementsByTagName("td")[0]; 
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