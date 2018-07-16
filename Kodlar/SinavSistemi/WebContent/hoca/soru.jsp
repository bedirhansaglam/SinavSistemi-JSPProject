<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@page import="java.sql.ResultSet"%>
<%
request.setCharacterEncoding("ISO-8859-9");
int hoca_id=0;
if(session.getAttribute("akademisyen_id")==null)
	response.sendRedirect("loginHoca.jsp");
else
	hoca_id=Integer.parseInt(session.getAttribute("akademisyen_id").toString());
	
%>
    <!DOCTYPE html>
    <jsp:useBean id="dersCrud" class="crud.DersCRUD"></jsp:useBean>
    <jsp:useBean id="cevapCrud" class="crud.CevapCRUD"></jsp:useBean>
    <jsp:useBean id="soruCrud" class="crud.SoruCRUD"></jsp:useBean>
<html>
<head>
<script type="text/javascript" src="js/index.js"></script>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%String butonname="Ekle";
String formaction="control/soruEkleControl.jsp";
String baslik="Soru Ekle";
String dersadi="",soru="",cevap="",cevap1="",cevap2="",cevap3="",cevap_id="",cevap_id_1="",cevap_id_2="",cevap_id_3="";
ArrayList<String> cevaplar=new ArrayList<String>();
int ders_id=0;

//Güncelleme bölümü kontrol baþlangýç
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Soru Güncelle";
	formaction="control/soruGuncelleKontrol.jsp?id="+request.getParameter("id");
	butonname="Güncelle";
	
	ResultSet sonuc=soruCrud.getSoru(id);
	while(sonuc.next())
	{
		soru=sonuc.getString("soru");
		dersadi=sonuc.getString("ders_adi");
		ders_id=Integer.parseInt(sonuc.getString("ders_id"));
	}
	ResultSet rscevap=cevapCrud.getAllCevap(id);
	while(rscevap.next())
	{
		cevaplar.add(rscevap.getString("cevap"));
		cevaplar.add(rscevap.getString("cevap_id"));
	}
	
	cevap=cevaplar.get(0);
	cevap1=cevaplar.get(2);
	cevap2=cevaplar.get(4);
	cevap3=cevaplar.get(6);
	
	cevap_id=cevaplar.get(1);
	cevap_id_1=cevaplar.get(3);
	cevap_id_2=cevaplar.get(5);
	cevap_id_3=cevaplar.get(7);
}
//Güncelleme bölümü kontrol son

//mesaj bölümü baþlangýç
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Soru ";
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
        <label for="fname">Soru</label>
      </div>
      <div class="col-75">
        <input type="text" id="fname" name="soru" placeholder="Lütfen sormak istedðiniz soruyu giriniz" value="<%=soru%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Doðru Cevap</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="cevap" placeholder="Lütfen doðru cevabý bu alana giriniz..." value="<%=cevap%>" required>
        <input type="hidden" id="lname" name="cevap_id" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap_id%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Yanlýþ Cevap 1</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="cevap1" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap1%>" required>
        <input type="hidden" id="lname" name="cevap1_id" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap_id_1%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Yanlýþ Cevap 2</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="cevap2" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap2%>" required>
        <input type="hidden" id="lname" name="cevap2_id" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap_id_2%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Yanlýþ Cevap 3</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="cevap3" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap3%>" required>
        <input type="hidden" id="lname" name="cevap3_id" placeholder="Lütfen yanlýþ bir cevabý bu alana giriniz..." value="<%=cevap_id_3%>" required>
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
 <%} %>
 

 <div class="baslikcontainer"><label>Soru Listesi</label></div>
  <div class="baslikcontainer"><label>Soru Ara :</label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istediðiniz soruyu yazýnýz..."/></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  	<th style="width:10%;">Ders Adý</th>
  	<th style="width:70%;">Soru</th>
<th style="width:10%;">Güncelle</th>
<th style="width:10%;">Sil</th>
  </tr>
  <%ResultSet sorular=soruCrud.getAllSoru();
  while(sorular.next())
  {%>
  <tr>
	<td><%=sorular.getString("ders_adi") %></td>
	<td><%=sorular.getString("soru") %></td>
    <td><a href='soru.jsp?id=<%=sorular.getString("soru_id") %>'><span class="glyphicon glyphicon-edit" style="font-size:24px; color:green;"></span></a></td>
    <td><a href='control/soruSilControl.jsp?id=<%=sorular.getString("soru_id") %>'><span class="glyphicon glyphicon-remove" style="font-size:24px; color:red;"></span></a></td>
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
	    td = tr[i].getElementsByTagName("td")[1]; //Tablodaki etiket deðerlerinin sýrasýna göre arama yapýlýyor isim bölümü 3.sýrada olduðu için 2 nolu index kontrol edilir
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