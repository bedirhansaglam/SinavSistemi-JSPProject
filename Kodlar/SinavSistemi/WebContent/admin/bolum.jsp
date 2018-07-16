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
String baslik="B�l�m Ekle";

//G�ncelleme b�l�m� kontrol ba�lang��
if(request.getParameter("id")!=null)//g�ncelleme i�in sayfaya id gelmi� ise
{	int id=Integer.parseInt(request.getParameter("id")); //id yi tut

	baslik="B�l�m G�ncelle"; //baslik b�l�m�n� de�i�tir
	
	butonname="G�ncelle"; //buton ismini de�i�tir
	ResultSet rs=bolumCrud.readBolum(id); //Bolumler tablosundan ilgili bolumu getir
	while(rs.next())
	{bolumadi=rs.getString("bolum_adi"); //bolumadi inputuna , tablodan �ekti�in veriyi aktar
	formaction="control/bolumGuncelleControl.jsp?id="+rs.getString("bolum_id");} //formaction b�l�m�n� g�ncelle sayfas� olarak de�i�tir id yi get olarak g�nder
	}
//G�ncelleme b�l�m� kontrol son

//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="B�l�m";
if(request.getParameter("sonuc")!=null)
{	sonucVarmi=true;
	String sonuc=request.getParameter("sonuc");
	if(sonuc.equals("1")) //yeni kayit ba�ar�l�
		{mesaj+=" Ekleme ��lemi Ba�ar�yla Ger�ekle�ti";
		olumlumu=true;}
	else if(sonuc.equals("2"))//yeni kayit ba�ar�s�z
		mesaj+=" Ekleme ��lemi Ba�ar�s�z";
	else if(sonuc.equals("3")) // G�ncelleme i�lemi ba�ar�l�
	{	olumlumu=true;
		mesaj+= " G�ncelleme ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("4"))
		mesaj+= " G�ncelleme ��lemi Ba�ar�s�z";
	else if(sonuc.equals("5"))
	{
		olumlumu=true;
		mesaj+= " Silme ��lemi Ba�ar�yla Ger�ekle�ti";
	}
	else if(sonuc.equals("6"))
		mesaj+= " Silme ��lemi Ba�ar�s�z";	
}

//mesaj B�l�m� son
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
        <label for="bname">B�l�m Ad�</label>
      </div>
      <div class="col-75">
        <input type="text" id="bname" name="bolum_adi" placeholder="B�l�m Ad�" value="<%=bolumadi%>" required>
      </div>
    </div>
        <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
   <div class="baslikcontainer"><label>B�l�m Ara </label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz b�l�m�n ismini yaz�n�z..."/></div>
 <div class="baslikcontainer"><label>B�L�M L�STES�</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
    <th style="width:20%;">B�l�m Ad�</th>
    <th style="width:10%;">G�ncelle</th>
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
	  tr = table.getElementsByTagName("tr"); //tablodaki satirlar al�n�yor


	  for (i = 0; i < tr.length; i++) { //tablodaki sat�r say�s� kadar dongu baslatiliyor
	    td = tr[i].getElementsByTagName("td")[0]; //Tablodaki etiket de�erlerinin s�ras�na g�re arama yap�l�yor b�l�m ad� b�l�m� 1.s�rada oldu�u i�in 0 nolu index kontrol edilir
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