<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>


<%
request.setCharacterEncoding("ISO-8859-9");
int hoca_id=0;
if(session.getAttribute("akademisyen_id")==null)
{	response.sendRedirect("loginHoca.jsp");	}
else
	hoca_id=Integer.parseInt(session.getAttribute("akademisyen_id").toString());
%>
<!DOCTYPE html>
<html>
<head>
<jsp:useBean id="sinav" class="models.Sinav"></jsp:useBean>
<jsp:setProperty property="*" name="sinav"/>
<jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>
</head>
<body>
<div id="main">
<%//sonuc 1 baþarýlý 2 baþarýsýz
if(session.getAttribute("akademisyen_id")!=null) //eðer giriþ yapýlmýþsa iþlemleri yap
{
String deger=request.getParameter("sinav_id").toString();
String sinav_adi="Vize";
if(deger.equals("2"))
	sinav_adi="Final";
else if(deger.equals("3"))
	sinav_adi="Bütünleme";

sinav.setAkademisyen_id(hoca_id);
sinav.setSinav_adi(sinav_adi);

int sinav_id=0;
ResultSet rs_sinav=null;
ArrayList<Integer> kitapcik_id=new ArrayList<Integer>();
if(sinavCrud.createSinav(sinav))
{
	//yeni eklediðimiz sinavýn id si çekiliyor
	rs_sinav=sinavCrud.getSonEklenenSinav_id();
	if(rs_sinav.next())
	{
		do{
			sinav_id=Integer.parseInt(rs_sinav.getString("sinav_id"));
		}while(rs_sinav.next());
	}
	
	//sinavdaki kitapcýk id leri çekiliyor
	rs_sinav=sinavCrud.getKitacik_id(sinav_id);
	if(rs_sinav.next())
	{
		do{
			kitapcik_id.add(Integer.parseInt(rs_sinav.getString("kitapcik_no")));
		}while(rs_sinav.next());
	}
	
	//kitapcik sorularý oluþturuluyor
	for(int i=0;i<kitapcik_id.size();i++) //kitapcik id leri getiriliyor
	{
		for(int j=0;j<sinav.getSoru_sayisi();j++) //soru sayisi cekiliyor
		{
			rs_sinav=sinavCrud.getRandomSoru(sinav.getAkademisyen_id(), sinav.getDers_id()); //rastgele soru cekiliyor veritabanýndan
			
			if(rs_sinav.next())
			{
				do{
					sinavCrud.kitapcikSorusuEkle(kitapcik_id.get(i),Integer.parseInt( rs_sinav.getString("soru_id"))); //cekilen rastgele soru ekleniyor
				}while(rs_sinav.next());
			}
			
		}
	}
	//böylelikle sinav ve kitapcýklar oluþturulmuþ oluyor sýnavýn uygulanabilmesi için yönetici onayý gerekiyor
	response.sendRedirect("../sinav.jsp?sonuc=1");
	}
else
	response.sendRedirect("../sinav.jsp?sonuc=2");

}
else 
{
	session.invalidate();
	response.sendRedirect("../loginHoca.jsp");}

  %>

</div>
</body>
</html>
