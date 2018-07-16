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
    <jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
<html>
<head>
 <link rel="stylesheet" href="css/dropdown.css">
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%String butonname="Ekle";
String formaction="control/dersEkleControl.jsp";
String baslik="Ders Ekle";
String dersadi="",bolumadi="";
int bolum_id=0;

//Güncelleme bölümü kontrol baþlangýç
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Ders Güncelle";
	formaction="control/dersGuncelleControl.jsp?id="+request.getParameter("id");
	butonname="Güncelle";
	ResultSet Sonuc=dersCrud.readDers(id);
	while(Sonuc.next())
	{
		dersadi=Sonuc.getString("ders_adi");
		bolumadi=Sonuc.getString("bolum_adi");
		bolum_id=Integer.parseInt(Sonuc.getString("bolum_id"));
	}
	}
//Güncelleme bölümü kontrol son

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Ders";
if(request.getParameter("sonuc")!=null)
{	sonucVarmi=true;
	String sonuc=request.getParameter("sonuc");
	if(sonuc.equals("1")) //yeni kayit baþarýlý
		{mesaj+=" Ekleme Ýþlemi Baþarýyla Gerçekleþti";
		olumlumu=true;}
	else if(sonuc.equals("2"))//yeni kayit baþarýsýz
		mesaj+=" Ekleme Ýþlemi Baþarýsýz";
	else if(sonuc.equals("3")) // Güncelleme iþlemi baþarýlý
	{	olumlumu=true;
		mesaj+= " Güncelleme Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("4"))
		mesaj+= " Güncelleme Ýþlemi Baþarýsýz";
	else if(sonuc.equals("5"))
	{
		olumlumu=true;
		mesaj+= " Silme Ýþlemi Baþarýyla Gerçekleþti";
	}
	else if(sonuc.equals("6"))
		mesaj+= " Silme Ýþlemi Baþarýsýz";	
}

//mesaj Bölümü son
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
<%} %>
 <div class="baslikcontainer"><label><%=baslik %></label></div>
<div class="formcontainer">
  <form action="<%=formaction %>" method="post">
	<div class="row">
	     <div class="col-25">
	       <label for="dname">Bölüm Adý:</label>
	     </div>
	     <div class="col-75">
			    <select name="bolum_id" class="dropdown-select">
			    <% if(request.getParameter("id")!=null)
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
        <label for="dname">Ders Adý:</label>
      </div>
      <div class="col-75">
        <input type="text" id="dname" name="ders_adi" placeholder="Ders Adý" value="<%=dersadi%>" required>
      </div>
    </div>
        <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
    <div class="baslikcontainer"><label>Ders Ara </label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz ders ismini yazýnýz..."/></div>
 <div class="baslikcontainer"><label>DERS LÝSTESÝ</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:20%;">Ders Adý</th>
    <th style="width:20%;">Bölüm Adý</th>
    <th style="width:10%;">Güncelle</th>
    <th style="width:10%;">Sil</th>
  </tr>
  <%  rs=dersCrud.readAllDers();
  while(rs.next()) {%>
  <tr>
  	<td><%=rs.getString("ders_adi") %></td>
    <td><%=rs.getString("bolum_adi")%></td>
    <td><a href='ders.jsp?id=<%=rs.getString("ders_id") %>'><span class="glyphicon glyphicon-edit" style="font-size:24px; color:green;"></span></a></td>
    <td><a href='control/dersSilControl.jsp?id=<%=rs.getString("ders_id") %>'><span class="glyphicon glyphicon-remove" style="font-size:24px; color:red;"></span></a></td>
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
	    td = tr[i].getElementsByTagName("td")[0]; //Tablodaki etiket deðerlerinin sýrasýna göre arama yapýlýyor bölüm adý bölümü 1.sýrada olduðu için 0 nolu index kontrol edilir
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