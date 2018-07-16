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

//G�ncelleme b�l�m� kontrol ba�lang��
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Okul G�ncelle";
	formaction="control/okulGuncelleKontrol.jsp?id="+request.getParameter("id");
	butonname="G�ncelle";
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
//G�ncelleme b�l�m� kontrol son

//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Okul ";
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

 <div class="baslikcontainer"><label><%=baslik %></label></div>
<div class="formcontainer">
  <form action="<%=formaction %>" method="post">
   <div class="row">
	     <div class="col-25">
	       <label for="dname">�ehir:</label>
	     </div>
	     <div class="col-75">
			    <select name="sehir_id" class="dropdown-select" >
			    <% if(request.getParameter("id")!=null) //g�ncelleme b�l�m�nde ge�erli �nvan en �stte olsun diye bir kontrol
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
        <label for="fname">Okul Ad�</label>
      </div>
      <div class="col-75">
        <input type="text" id="fname" name="okul_adi"  value="<%=okul_adi%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">S�n�f Say�s�</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="sinif_sayisi"  value="<%=sinif_sayisi%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="email">S�n�f Kapasitesi</label>
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
 <div class="baslikcontainer"><label>Okul Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz okul ismini yaz�n�z..."/></div>
 <div class="baslikcontainer"><label>Okul Listesi</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:10%;">�ehir Ad�</th>
  	<th style="width:10%;">Okul Ad�</th>
  	<th style="width:10%;">S�n�f Say�s�</th>
    <th style="width:10%;">S�n�f Kapasitesi</th>
    <th style="width:10%;">G�ncelle</th>
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
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar al�n�yor


	  for (i = 0; i < tr.length; i++) { //tablodaki sat�r say�s� kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[1]; //Tablodaki etiket de�erlerinin s�ras�na g�re arama yap�l�yor okul isim b�l�m� 2.s�rada oldu�u i�in 1 nolu index kontrol edilir
	    if (td) {
	      if (td.innerHTML.toUpperCase().indexOf(filter) > -1) { //filtereye gore arama yap�l�yor eger deger -1 den buyukse deger gosteriliyor
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