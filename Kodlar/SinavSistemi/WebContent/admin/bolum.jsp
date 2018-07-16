<%@page import="models.Bolum"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%
request.setCharacterEncoding("ISO-8859-9");
if(session.getAttribute("admin_id")==null)
{
	response.sendRedirect("loginYonetici.jsp");
	}
%>
    <!DOCTYPE html>
    <jsp:useBean id="bolumCrud" class="crud.BolumCRUD"></jsp:useBean>
    <jsp:useBean id="bolum" class="models.Bolum"></jsp:useBean>
<html>
<head>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%String butonname="Ekle";
String formaction="control/bolumEkleControl.jsp";
String bolumadi="";
String baslik="Bölüm Ekle";

//Güncelleme bölümü kontrol baþlangýç
if(request.getParameter("id")!=null)//güncelleme için sayfaya id gelmiþ ise
{	int id=Integer.parseInt(request.getParameter("id")); //id yi tut

	baslik="Bölüm Güncelle"; //baslik bölümünü deðiþtir
	
	butonname="Güncelle"; //buton ismini deðiþtir
	ResultSet rs=bolumCrud.readBolum(id); //Bolumler tablosundan ilgili bolumu getir
	while(rs.next())
	{bolumadi=rs.getString("bolum_adi"); //bolumadi inputuna , tablodan çektiðin veriyi aktar
	formaction="control/bolumGuncelleControl.jsp?id="+rs.getString("bolum_id");} //formaction bölümünü güncelle sayfasý olarak deðiþtir id yi get olarak gönder
	}
//Güncelleme bölümü kontrol son

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Bölüm";
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
        <label for="bname">Bölüm Adý</label>
      </div>
      <div class="col-75">
        <input type="text" id="bname" name="bolum_adi" placeholder="Bölüm Adý" value="<%=bolumadi%>" required>
      </div>
    </div>
        <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
   <div class="baslikcontainer"><label>Bölüm Ara </label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz bölümün ismini yazýnýz..."/></div>
 <div class="baslikcontainer"><label>BÖLÜM LÝSTESÝ</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
    <th style="width:20%;">Bölüm Adý</th>
    <th style="width:10%;">Güncelle</th>
    <th style="width:10%;">Sil</th>
  </tr>
  <% ResultSet rs=bolumCrud.readAllBolum();
  while(rs.next()) {%>
  <tr>
    <td><%=rs.getString("bolum_adi") %></td>
    <td><a href='bolum.jsp?id=<%=rs.getString("bolum_id")%>'><span class="glyphicon glyphicon-edit" style="font-size:24px; color:green;"></span></a></td>
    <td><a href='control/bolumSilControl.jsp?id=<%=rs.getString("bolum_id")%>'><span class="glyphicon glyphicon-remove" style="font-size:24px; color:red;"></span></a></td>
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