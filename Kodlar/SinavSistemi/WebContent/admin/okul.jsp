<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("admin_id")==null)
{
	response.sendRedirect("loginYonetici.jsp");
	}
%>
    <!DOCTYPE html>
    <jsp:useBean id="sehirbilgisi" class="islemler.AdresBilgisi"></jsp:useBean>
    <jsp:useBean id="okulCrud" class="crud.OkulCRUD"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%String butonname="Ekle";
String formaction="control/okulEkleControl.jsp";
String baslik="Okul Ekle";
String sehiradi="",sinif_sayisi="",sinif_kapasitesi="",okul_adi="";
int sehir_id=0;

//Güncelleme bölümü kontrol baþlangýç
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Okul Güncelle";
	formaction="control/okulGuncelleKontrol.jsp?id="+request.getParameter("id");
	butonname="Güncelle";
	ResultSet sonuc=okulCrud.getOkul(id);
	while(sonuc.next())
	{
		okul_adi=sonuc.getString("okul_adi");
		sinif_sayisi=sonuc.getString("sinif_sayisi");
		sinif_kapasitesi=sonuc.getString("sinif_kapasitesi");
		sehiradi=sonuc.getString("sehir_adi");
		sehir_id=Integer.parseInt(sonuc.getString("sehir_id"));

	}
	}
//Güncelleme bölümü kontrol son

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Okul ";
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

 <div class="baslikcontainer"><label><%=baslik %></label></div>
<div class="formcontainer">
  <form action="<%=formaction %>" method="post">
   <div class="row">
	     <div class="col-25">
	       <label for="dname">Þehir:</label>
	     </div>
	     <div class="col-75">
			    <select name="sehir_id" class="dropdown-select" >
			    <% if(request.getParameter("id")!=null) //güncelleme bölümünde geçerli ünvan en üstte olsun diye bir kontrol
			    {%> 
			    <option value=<%=sehir_id %>><%=sehiradi %></option>
			    <% }
			    ResultSet rsu=sehirbilgisi.SehirGetir();
  while(rsu.next()) {
  if(sehir_id!=Integer.parseInt(rsu.getString("il_no")) && !sehiradi.equals(rsu.getString("isim"))){%>
			      <option value=<%=rsu.getString("il_no") %>><%=rsu.getString("isim") %></option>
<%}} %>
			    </select>
	     </div>
	 </div>
    <div class="row">
      <div class="col-25">
        <label for="fname">Okul Adý</label>
      </div>
      <div class="col-75">
        <input type="text" id="fname" name="okul_adi"  value="<%=okul_adi%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Sýnýf Sayýsý</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="sinif_sayisi"  value="<%=sinif_sayisi%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="email">Sýnýf Kapasitesi</label>
      </div>
      <div class="col-75">
		<input type="text" id="email" name="sinif_kapasitesi" value="<%=sinif_kapasitesi%>" required>
      </div>
    </div>
    <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
 <div class="baslikcontainer"><label>Okul Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz okul ismini yazýnýz..."/></div>
 <div class="baslikcontainer"><label>Okul Listesi</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:10%;">Þehir Adý</th>
  	<th style="width:10%;">Okul Adý</th>
  	<th style="width:10%;">Sýnýf Sayýsý</th>
    <th style="width:10%;">Sýnýf Kapasitesi</th>
    <th style="width:10%;">Güncelle</th>
    <th style="width:10%;">Sil</th>
  </tr>
  <%ResultSet okullar=okulCrud.getAllOkul();
  while(okullar.next())
  {%>
  <tr>
	<td><%=okullar.getString("sehir_adi") %></td>
	<td><%=okullar.getString("okul_adi") %></td>
<td><%=okullar.getString("sinif_sayisi") %></td>
<td><%=okullar.getString("sinif_kapasitesi") %></td>
    <td><a href='okul.jsp?id=<%=okullar.getString("okul_no") %>'><span class="glyphicon glyphicon-edit" style="font-size:24px; color:green;"></span></a></td>
    <td><a href='control/okulSilControl.jsp?id=<%=okullar.getString("okul_no") %>'><span class="glyphicon glyphicon-remove" style="font-size:24px; color:red;"></span></a></td>
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
	    td = tr[i].getElementsByTagName("td")[1]; //Tablodaki etiket deðerlerinin sýrasýna göre arama yapýlýyor okul isim bölümü 2.sýrada olduðu için 1 nolu index kontrol edilir
	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) { //filtereye gore arama yapýlýyor eger deger -1 den buyukse deger gosteriliyor
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";//filteden gecemeyen degerler gosterilmiyor
	      }
	    } 
	  }
	}
 </script>
</body>
</html>