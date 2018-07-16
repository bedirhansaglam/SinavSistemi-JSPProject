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
    <jsp:useBean id="akademisyenCrud" class="crud.akademisyenCRUD"></jsp:useBean>
<html>
<head>
</head>
<body >
<jsp:include page="panel.jsp"></jsp:include>
<%String butonname="Ekle";
String formaction="control/akademisyenEkleControl.jsp";
String baslik="Akademisyen Ekle";
String unvanadi="",bolumadi="",ad="",soyad="",email="",sifre="";
int bolum_id=0,unvan_id=0;

//G�ncelleme b�l�m� kontrol ba�lang��
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Akademisyen G�ncelle";
	formaction="control/akademisyenGuncelleKontrol.jsp?id="+request.getParameter("id");
	butonname="G�ncelle";
	
	ResultSet sonuc=akademisyenCrud.readAkademisyen(id);
	while(sonuc.next())
	{
		ad=sonuc.getString("ad");
		soyad=sonuc.getString("soyad");
		email=sonuc.getString("email");
		sifre=sonuc.getString("sifre");
		bolumadi=sonuc.getString("bolum_adi");
		unvanadi=sonuc.getString("unvan_adi");
		bolum_id=Integer.parseInt(sonuc.getString("bolum_id"));
		unvan_id=Integer.parseInt(sonuc.getString("unvan_id"));

	}
	}
//G�ncelleme b�l�m� kontrol son

//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Akademisyen";
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
        <label >Foto�raf</label>
      </div>
      <div class="col-75">
		<img id="blah" src="../source/images/foto.png"  width="96" height="96" />
		<input type='file' onchange="readURL(this);" />
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="fname">�sim</label>
      </div>
      <div class="col-75">
        <input type="text" id="fname" name="ad" placeholder="Akademisyen Ad�" value="<%=ad%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="lname">Soyisim</label>
      </div>
      <div class="col-75">
        <input type="text" id="lname" name="soyad" placeholder="Akademisyen Soyad�" value="<%=soyad%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="email">E-mail</label>
      </div>
      <div class="col-75">
		<input type="email" id="email" name="email" placeholder="Akademisyen E mail" value="<%=email%>" required>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="pword">�ifre</label>
      </div>
      <div class="col-75">
        <input type="password" id="pword" name="sifre" placeholder="Akademisyen �ifresi" value="<%=sifre%>" required>
      </div>
    </div>
    	<div class="row">
	     <div class="col-25">
	       <label for="dname">B�l�m Ad�:</label>
	     </div>
	     <div class="col-75">
			    <select name="bolum_id" class="dropdown-select">
			    <% if(request.getParameter("id")!=null) //g�ncelleme b�l�m�nde ge�erli b�l�m en �stte olsun diye bir kontrol
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
	       <label for="dname">Unvan:</label>
	     </div>
	     <div class="col-75">
			    <select name="unvan_id" class="dropdown-select">
			    <% if(request.getParameter("id")!=null) //g�ncelleme b�l�m�nde ge�erli �nvan en �stte olsun diye bir kontrol
			    {%> 
			    <option value=<%=unvan_id %>><%=unvanadi %></option>
			    <% }
			    ResultSet rsu=akademisyenCrud.readAllUnvan();
  while(rsu.next()) {
  if(unvan_id!=Integer.parseInt(rsu.getString("unvan_id")) && !unvanadi.equals(rsu.getString("unvan_adi"))){%>
			      <option value=<%=rsu.getString("unvan_id") %>><%=rsu.getString("unvan_adi") %></option>
<%}} %>
			    </select>
	     </div>
	 </div>
    <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
  <div class="baslikcontainer"><label>Akademisyen Ara </label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz akademisyenin ismini yaz�n�z..."/></div>
 <div class="baslikcontainer"><label>Akademisyen Listesi</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:10%;">Foto�raf</th>
  	<th style="width:10%;">Unvan</th>
    <th style="width:10%;">Ad</th>
    <th style="width:10%;">Soyad</th>
    <th style="width:10%;">Email</th>
    <th style="width:10%;">�ifre</th>
    <th style="width:10%;">B�l�m</th>
    <th style="width:10%;">G�ncelle</th>
    <th style="width:10%;">Sil</th>
  </tr>
  <%ResultSet hocalar=akademisyenCrud.readAllAkademisyen();
  while(hocalar.next())
  {%>
  <tr>
	<td><img src="../source/images/<%=hocalar.getString("resim") %>"  width="45" height="45" /></td>
	<td><%=hocalar.getString("unvan_adi") %></td>
	<td><%=hocalar.getString("ad") %></td>
<td><%=hocalar.getString("soyad") %></td>
<td><%=hocalar.getString("email") %></td>
<td><%=hocalar.getString("sifre") %></td>
<td><%=hocalar.getString("bolum_adi") %></td>
    <td><a href='akademisyen.jsp?id=<%=hocalar.getString("akademisyen_id") %>'><span class="glyphicon glyphicon-edit" style="font-size:24px; color:green;"></span></a></td>
    <td><a href='control/akademisyenSilControl.jsp?id=<%=hocalar.getString("akademisyen_id") %>'><span class="glyphicon glyphicon-remove" style="font-size:24px; color:red;"></span></a></td>
  </tr>
<%} %>
</table>
 </div>

 <script  src="js/index.js"></script>

 <script type="text/javascript">
 function myFunction() {

	  var input, filter, table, tr, td, i; //degiskenler ataniyor
	  input = document.getElementById("ara"); //input nesnesi cekiliyor
	  filter = input.value.toUpperCase(); //buyuk kucuk harf sorurunu cozmek icin hepsi buyuk yapiliyor
	  table = document.getElementById("myTable"); //tablo nesnesi cekiliyor
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar al�n�yor


	  for (i = 0; i < tr.length; i++) { //tablodaki sat�r say�s� kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[2]; //Tablodaki etiket de�erlerinin s�ras�na g�re arama yap�l�yor isim b�l�m� 3.s�rada oldu�u i�in 2 nolu index kontrol edilir
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