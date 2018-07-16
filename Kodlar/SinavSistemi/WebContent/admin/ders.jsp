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

//G�ncelleme b�l�m� kontrol ba�lang��
if(request.getParameter("id")!=null)
{	int id=Integer.parseInt(request.getParameter("id"));
	baslik="Ders G�ncelle";
	formaction="control/dersGuncelleControl.jsp?id="+request.getParameter("id");
	butonname="G�ncelle";
	ResultSet Sonuc=dersCrud.readDers(id);
	while(Sonuc.next())
	{
		dersadi=Sonuc.getString("ders_adi");
		bolumadi=Sonuc.getString("bolum_adi");
		bolum_id=Integer.parseInt(Sonuc.getString("bolum_id"));
	}
	}
//G�ncelleme b�l�m� kontrol son

//mesaj b�l�m� ba�lang��
boolean sonucVarmi=false;
boolean olumlumu=false;
String mesaj="Ders";
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
	       <label for="dname">B�l�m Ad�:</label>
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
        <label for="dname">Ders Ad�:</label>
      </div>
      <div class="col-75">
        <input type="text" id="dname" name="ders_adi" placeholder="Ders Ad�" value="<%=dersadi%>" required>
      </div>
    </div>
        <div class="row">
      <input type="submit" value="<%=butonname%>">
    </div>
  </form>
 </div>
    <div class="baslikcontainer"><label>Ders Ara </label><input type="text" id="ara" onkeyup="myFunction()" placeholder="Aramak istedi�iniz ders ismini yaz�n�z..."/></div>
 <div class="baslikcontainer"><label>DERS L�STES�</label></div>
 <div class="tablecontainer">
 <table id="myTable">
  <tr class="header">
  <th style="width:20%;">Ders Ad�</th>
    <th style="width:20%;">B�l�m Ad�</th>
    <th style="width:10%;">G�ncelle</th>
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