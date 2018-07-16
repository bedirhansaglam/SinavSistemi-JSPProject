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
    <jsp:useBean id="bolumCrud" class="crud.BolumCRUD"></jsp:useBean>
    <jsp:useBean id="sehirbilgisi" class="islemler.AdresBilgisi"></jsp:useBean>
    <jsp:useBean id="ogrenciCrud" class="crud.OgrenciCrud"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%String butonname="Ekle";
String formaction="control/ogrenciEkleControl.jsp";
String baslik="Öðrenci Ekle";
String sehiradi="",bolumadi="",ad="",soyad="",email="",sifre="";
int bolum_id=0,sehir_id=0;

//Güncelleme bölümü kontrol baþlangýç
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Öðrenci Güncelle";
	formaction="control/ogrenciGuncelleKontrol.jsp?id="+request.getParameter("id");
	butonname="Güncelle";
	
	ResultSet sonuc=ogrenciCrud.readOgrenci(id);
	while(sonuc.next())
	{
		ad=sonuc.getString("ad");
		soyad=sonuc.getString("soyad");
		email=sonuc.getString("email");
		sifre=sonuc.getString("sifre");
		bolumadi=sonuc.getString("bolum_adi");
		sehiradi=sonuc.getString("sehir_adi");
		bolum_id=Integer.parseInt(sonuc.getString("bolum_id"));
		sehir_id=Integer.parseInt(sonuc.getString("sehir_id"));

	}
	}
//Güncelleme bölümü kontrol son

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Öðrenci ";
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
	       <label for="dname">Bölüm Adý:</label>
	     </div>
	     <div class="col-75">
			    <select name="bolum_id" class="dropdown-select">
			    <% if(request.getParameter("id")!=null) //güncelleme bölümünde geçerli bölüm en üstte olsun diye bir kontrol
			    {%>
			    <option value=<%=bolum_id %>><%=bolumadi %></option>
			    <% }
			    ResultSet rs=bolumCrud.readAllBolum();
  while(rs.next()) {
  if(bolum_id!=Integer.parseInt(rs.getString("bolum_id")) && !bolumadi.equals(rs.getString("bolum_adi"))){%>
			      <option value=<%=rs.getString("bolum_id") %>><%=rs.getString("bolum_adi") %></option>
<%}} %>
			    </select>
	     </div>
	 </div>
  <div class="row">
      <div class="col-25">
        <label >Fotoðraf</label>
      </div>
      <div class="col-75">
		<img id="blah" src="../source/images/foto.png"  width="96" height="96" />
		<input type='file' onchange="readURL(this);" />
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="fname">Ýsim</label>
      </div>
      <div class="col-75">
        <input type="text" id="fname" name="ad" placeholder="Ýsim" value="<%=ad%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Soyisim</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="soyad" placeholder="Soyisim" value="<%=soyad%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="email">E-mail</label>
      </div>
      <div class="col-75">
		<input type="email" id="email" name="email" placeholder="E mail" value="<%=email%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="pword">Þifre</label>
      </div>
      <div class="col-75">
        <input type="password" id="pword" name="sifre" placeholder="Þifre" value="<%=sifre%>" required>
      </div>
    </div>
    	
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
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
 <div class="baslikcontainer"><label>Öðrenci Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz öðrencinin ismini yazýnýz..."/></div>
 <div class="baslikcontainer"><label>Öðrenci Listesi</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:10%;">Fotoðraf</th>
  	<th style="width:10%;">Bölüm Adý</th>
  	<th style="width:10%;">Ad</th>
    <th style="width:10%;">Soyad</th>
    <th style="width:10%;">Email</th>
    <th style="width:10%;">Þifre</th>
    <th style="width:10%;">Þehir</th>
    <th style="width:10%;">Güncelle</th>
    <th style="width:10%;">Sil</th>
  </tr>
  <%ResultSet ogrenciler=ogrenciCrud.readAllOgrenci();
  while(ogrenciler.next())
  {%>
  <tr>
	<td><img src="../source/images/<%=ogrenciler.getString("resim") %>"  width="45" height="45" /></td> 
	<td><%=ogrenciler.getString("bolum_adi") %></td>
	<td><%=ogrenciler.getString("ad") %></td>
<td><%=ogrenciler.getString("soyad") %></td>
<td><%=ogrenciler.getString("email") %></td>
<td><%=ogrenciler.getString("sifre") %></td>
<td><%=ogrenciler.getString("sehir_adi") %></td>
    <td><a href='ogrenci.jsp?id=<%=ogrenciler.getString("ogrenci_no") %>'><span class="glyphicon glyphicon-edit" style="font-size:24px; color:green;"></span></a></td>
    <td><a href='control/ogrenciSilControl.jsp?id=<%=ogrenciler.getString("ogrenci_no") %>'><span class="glyphicon glyphicon-remove" style="font-size:24px; color:red;"></span></a></td>
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
	    td = tr[i].getElementsByTagName("td")[2]; //Tablodaki etiket deðerlerinin sýrasýna göre arama yapýlýyor isim bölümü 3.sýrada olduðu için 2 nolu index kontrol edilir
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