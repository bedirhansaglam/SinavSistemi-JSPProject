package crud;

import java.sql.*;
import islemler.VeritabaniBaglantisi;
import models.Sinav;

public class SinavCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	public SinavCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createSinav(Sinav sinav)
	{
		try
		{	cs=con.prepareCall ("{ CALL SinavEkle ( ?,?,?,?,?,?,?)}");
			cs.setString(1, sinav.getSinav_adi());
			cs.setInt(2, sinav.getDers_id());
			cs.setString(3, sinav.getTarih());
			cs.setString(4, sinav.getSaat());
			cs.setInt(5, sinav.getAkademisyen_id());
			cs.setInt(6, sinav.getSoru_sayisi());
			cs.setInt(7, sinav.getKitapcik_sayisi());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet getSonEklenenSinav_id()
	{
		try
		{
			cs=con.prepareCall ("{ CALL  SonEklenenSinaviGetir ()}");
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet getKitacik_id(int sinav_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL  KitapcikGetir (?)}");
			cs.setInt(1, sinav_id);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet getRandomSoru(int hoca_id,int ders_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL  RastgeleSoruGetir (?,?)}");
			cs.setInt(1, hoca_id);
			cs.setInt(2, ders_id);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
public boolean kitapcikSorusuEkle(int kitapcik_id,int soru_id)
{
	try
	{	cs=con.prepareCall ("{ CALL KitapcikSorusuOlustur ( ?,?)}");
		cs.setInt(1, kitapcik_id);
		cs.setInt(2, soru_id);
		cs.execute();
		return true;
	}
	catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}}
	public boolean sinavOnayla(int id)
	{
		try
		{	cs=con.prepareCall ("{ CALL SinavOnayla ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean sinavSil(int id)
	{
		try
		{	cs=con.prepareCall ("{ CALL SinavSil ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet getOnayBekleyenSinavlar()
	{
		try
		{
			cs=con.prepareCall ("{ CALL OnayBekleyenSinavlariGetir ()}");
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	
	public ResultSet getSehirler(int ders_id,int dersverenakademisyen_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL DersiAlanOgrencininBulunduguSehir (?,?)}");
			cs.setInt(1, ders_id);
			cs.setInt(2, dersverenakademisyen_id);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getOgrenciler(int ders_id,int dersverenakademisyen_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL DersiAlanOgrencileriGetir (?,?)}");
			cs.setInt(1, ders_id);
			cs.setInt(2, dersverenakademisyen_id);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getSiraId(int sinif_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL SiraIdGetir (?)}");
			cs.setInt(1, sinif_id);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getOkullar(int sehir_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL RastgeleOkulGetir (?)}");
			cs.setInt(1, sehir_id); 
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	
	public ResultSet getHocaSinavBilgisi(int hoca_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL HocaGorevBilgisiGetir (?)}");
			cs.setInt(1, hoca_id); 
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public boolean HocaGorevKabul(int sinav_id,int hoca_id)
	{
		try
		{	cs=con.prepareCall ("{ CALL HocaGorevKabul ( ?,?)}");
			cs.setInt(1, sinav_id);
			cs.setInt(2, hoca_id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean HocaGorevIptal(int sinav_id,int hoca_id,int yeni_hoca_id)
	{
		try
		{	cs=con.prepareCall ("{ CALL HocaGorevIptal ( ?,?,?)}");
			cs.setInt(1, sinav_id);
			cs.setInt(2, hoca_id);
			cs.setInt(3, yeni_hoca_id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public ResultSet getAkademisyen()
	{
		try
		{
			cs=con.prepareCall ("{ CALL RastgeleAkademisyenGetir ()}");
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getTemsilci()
	{
		try
		{
			cs=con.prepareCall ("{ CALL RastgeleTemsilciGetir ()}");
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	
	public ResultSet getSalon(int okul_no)
	{
		try
		{
			
			cs=con.prepareCall ("{ CALL RastgeleSinavSalonuGetir (?)}");
			cs.setInt(1, okul_no);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) {	System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		
		return resultSet;
	}
	
	public ResultSet getOgrenciBilgisi(int ogrenci_no)
	{
		try
		{
			
			cs=con.prepareCall ("{ CALL OgrenciSinavBilgisiGetir (?)}");
			cs.setInt(1, ogrenci_no);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) {	System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		
		return resultSet;
	}
	public boolean createSinavOnay(int sinav_id,int temsilci_id,int okul_id)
	{
		try
		{	cs=con.prepareCall ("{ CALL SinavOnayEkle ( ?,?,?)}");
			cs.setInt(1, sinav_id);
			cs.setInt(2, temsilci_id);
			cs.setInt(3, okul_id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean createSinavSalonu(int sinav_id,int okul_id,int sinif_id,int hoca_id)
	{
		try
		{	cs=con.prepareCall ("{ CALL SalonEkle ( ?,?,?,?)}");
			cs.setInt(1, sinav_id);
			cs.setInt(2, okul_id);
			cs.setInt(3, sinif_id);
			cs.setInt(4, hoca_id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean createAdaylar(int salon_id,int ogrenci_id,int sira_id,int kitapcik_id)
	{
		try
		{	cs=con.prepareCall ("{ CALL AdayEkle ( ?,?,?,?)}");
			cs.setInt(1, salon_id);
			cs.setInt(2, ogrenci_id);
			cs.setInt(3, sira_id);
			cs.setInt(4, kitapcik_id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
}
