<%@ page language="java" contentType="text/html; charset=ISO-8859-9"
    pageEncoding="ISO-8859-9"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import = "java.io.*,java.util.*" %>
<%@ page import = "javax.servlet.*,java.text.*" %>
<%@ page import="java.util.Date" %>
<%
request.setCharacterEncoding("ISO-8859-9");
%>
<!DOCTYPE html>
<jsp:useBean id="sinavCrud" class="crud.SinavCRUD"></jsp:useBean>
<jsp:useBean id="mail" class="islemler.Mail"></jsp:useBean>
<html>
<head>
</head>
<body>
<div id="main">
<% if(request.getParameter("sinav_id")!=null)
{
	ArrayList<Integer> okul_id=new ArrayList<Integer>();
	ArrayList<Integer> temsilci_id=new ArrayList<Integer>();
	ArrayList<Integer> akademisyen_id=new ArrayList<Integer>();
	ArrayList<Integer> sehir_id=new ArrayList<Integer>();
	ArrayList<Integer> sinif_id=new ArrayList<Integer>();
	ArrayList<Integer> kitapcik_id=new ArrayList<Integer>();

	ResultSet sehirler=null,okul=null,temsilci=null,akademisyen=null,siniflar=null;
	
	int sinav_id,dersverenakademisyen_id,ders_id;
	sinav_id=Integer.parseInt(request.getParameter("sinav_id"));
	dersverenakademisyen_id=Integer.parseInt(request.getParameter("hoca_id"));
	ders_id=Integer.parseInt(request.getParameter("ders_id"));
	//****************************************************************SINAV ONAY EKLE - BAÞLANGIÇ-********************************************************
	sehirler=sinavCrud.getSehirler(ders_id, dersverenakademisyen_id);
	
	if(sehirler.next()) //öðrencilerin bulunduðu þehirler çekiliyor
	{
		do{
			sehir_id.add(Integer.parseInt(sehirler.getString("sehir_id")));
		}while(sehirler.next());
	}
	
	for(int i=0;i<sehir_id.size();i++)
	{
		//öðrencilerin bulunduðu þehirlerdeki okullardan rastgele  çekiliyor listeye atýlýyor
		okul=sinavCrud.getOkullar(sehir_id.get(i));
		if(okul.next()) 
		{
			do{
				okul_id.add(Integer.parseInt(okul.getString("okul_no")));
				out.print(" Þehir ID :"+sehir_id.get(i));
				out.print(" Okul ID :"+okul.getString("okul_no"));
			}while(okul.next());
		}
		
		//her okul için bir temsilci atanýyor
		temsilci=sinavCrud.getTemsilci();
		if(temsilci.next())
		{
			do{
				temsilci_id.add(Integer.parseInt(temsilci.getString("temsilci_id")));
				out.print(" Temsilci ID:"+temsilci.getString("temsilci_id"));
			}while(temsilci.next());
		}
	}
	
	//****************************************************************SINAV ONAY EKLE - SON-********************************************************
	for(int i=0;i<okul_id.size();i++)
	{
		
		sinavCrud.createSinavOnay(sinav_id, temsilci_id.get(i), okul_id.get(i)); //sýnav onay ekle burada yapýlýyor //burasý açýlacak
		siniflar=sinavCrud.getSalon(okul_id.get(i));
		if(siniflar.next())
		{
			do{
				sinif_id.add(Integer.parseInt(siniflar.getString("sinif_no")));
				out.print(" Sinif NO:"+siniflar.getString("sinif_no"));
			}while(siniflar.next());
		}
		// her okul için bir akademisyen atanýyor
		akademisyen=sinavCrud.getAkademisyen();
		if(akademisyen.next())
		{
			do{
				akademisyen_id.add(Integer.parseInt(akademisyen.getString("akademisyen_id")));
				System.out.print(" Akademisyen ID:"+akademisyen.getString("akademisyen_id"));
			}while(akademisyen.next());
			
		}
	}
	
	for(int i=0;i<okul_id.size();i++)
	{
		sinavCrud.createSinavSalonu(sinav_id, okul_id.get(i), sinif_id.get(i), akademisyen_id.get(i));
		ResultSet hoca_gorev_bilgisi=sinavCrud.getHocaSinavBilgisi(akademisyen_id.get(i));
		String email="",mesaj="";
		if(hoca_gorev_bilgisi.next())
		{
			do{
				email=hoca_gorev_bilgisi.getString("email");
				email="bedirhanssaglam@gmail.com"; //bu bölüm silindiðinde orjinal emaile mesaj gider
				mesaj="Sayýn "+ hoca_gorev_bilgisi.getString("ad")+" "+hoca_gorev_bilgisi.getString("soyad")+"   "+hoca_gorev_bilgisi.getString("tarih")+" Tarihinde "+hoca_gorev_bilgisi.getString("saat")+" saatinde "
						+hoca_gorev_bilgisi.getString("sehir_adi")+"  ilinde "+hoca_gorev_bilgisi.getString("okul_adi")+" okulunda "+hoca_gorev_bilgisi.getString("ders_adi")+" "+hoca_gorev_bilgisi.getString("sinav_adi")+" sýnavý yapýlacaktýr.Sorumlu olduðunuz sýnýf "
						+hoca_gorev_bilgisi.getString("sinif_adi")+" numaralý sýnýfdýr. Eðer Görevi Kabul etmek istiyorsanýz sisteme giriþ yapýp görevi onaylamanýz gerekmektedir.  Sistem Giriþ Linki : http://localhost:8080/SinavSistemi/hoca/sinav.jsp?hoca_id="+akademisyen_id.get(i);
				
			}while(hoca_gorev_bilgisi.next());
		}
		mail.Gonder(email, mesaj);
	}
	//*****************************************************************************************************************************
	
	//kitapcýklar getiriliyor
	ResultSet kitapciklar=sinavCrud.getKitacik_id(sinav_id);
	if(kitapciklar.next())
	{
		do{
			kitapcik_id.add(Integer.parseInt( kitapciklar.getString("kitapcik_no")));
		}
		while(kitapciklar.next());
	}
	//random sayi üretiliyor kitapciklar rastgele dagitilsin diye
	Random rand = new Random();
	int n = rand.nextInt(kitapcik_id.size());
	
	ResultSet Ogrenciler=sinavCrud.getOgrenciler(ders_id, dersverenakademisyen_id); // dersi alan ogrenciler getiriliyor
	for(int i=0;i<sinif_id.size();i++)
	{
		int j=0;
		ResultSet siralar=sinavCrud.getSiraId(sinif_id.get(i)); //sinifdaki siralar getiriliyor
		ArrayList<Integer> sira_id=new ArrayList<Integer>();
		if(siralar.next())
		{
			do{sira_id.add(Integer.parseInt(siralar.getString("sira_id")));}
			while(siralar.next());
		}
		if(Ogrenciler.next())
		{
			do{
		sinavCrud.createAdaylar(sinif_id.get(i),Integer.parseInt( Ogrenciler.getString("ogrenci_no")), sira_id.get(j), kitapcik_id.get(n)); //siralara sirayla adaylar ekleniyor
		j++;}
			while(Ogrenciler.next());
		}
	}
	

	if(sinavCrud.sinavOnayla(sinav_id))
	response.sendRedirect("../sinav.jsp?sonuc=1");
	else
		response.sendRedirect("../sinav.jsp?sonuc=2");
}
else
{response.sendRedirect("../sinav.jsp?sonuc=2");}
	
  %>
</div>
</body>
</html>
