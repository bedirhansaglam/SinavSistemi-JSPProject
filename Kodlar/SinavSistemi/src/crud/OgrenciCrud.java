package crud;

import models.Ogrenci;
import java.sql.*;

import islemler.VeritabaniBaglantisi;
public class OgrenciCrud {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	public OgrenciCrud()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createOgrenci(Ogrenci ogrenci)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciEkle ( ?, ?, ?, ?, ?, ?, ? )}");
			cs.setInt(1, ogrenci.getBolum_id());
			cs.setString(2, ogrenci.getResim());
			cs.setString(3, ogrenci.getAd());
			cs.setString(4, ogrenci.getSoyad());
			cs.setString(5, ogrenci.getEmail());
			cs.setString(6, ogrenci.getSifre());
			cs.setInt(7, ogrenci.getSehir_id());
			cs.execute(); //Öðrenci eklendi
			
			String query = "CALL SonKayitOlanOgrenciyiGetir()"; //Öðrencinin idsini ve bölüm id sini al
			resultSet=stm.executeQuery(query);
			
			if (resultSet.next()) { 
			    do {
			    	cs=con.prepareCall ("{ CALL DanismanEkle ( ?, ? )}");
					cs.setInt(1,Integer.parseInt(resultSet.getString("bolum_id")));
					cs.setInt(2, Integer.parseInt(resultSet.getString("ogrenci_no")));
					cs.execute();
			    } while(resultSet.next());
			}
			
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public ResultSet readAllOgrenci()
	{
		try
		{
			String query = "CALL ButunOgrencileriGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	
	public ResultSet readOgrenci(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciGetir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public boolean updateOgrenci(Ogrenci ogrenci,int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciGuncelle ( ?, ?, ?, ?, ?, ?, ?,? )}");
			cs.setInt(1, ogrenci.getBolum_id());
			cs.setString(2, ogrenci.getResim());
			cs.setString(3, ogrenci.getAd());
			cs.setString(4, ogrenci.getSoyad());
			cs.setString(5, ogrenci.getEmail());
			cs.setString(6, ogrenci.getSifre());
			cs.setInt(7, ogrenci.getSehir_id());
			cs.setInt(8, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public boolean deleteOgrenci(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciSil ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public ResultSet getAlinacakDersler(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciDersleriGetir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet getAlinanDersler(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AlinanDersleriGetir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet getOnayBekleyenDersler(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciOnayBekleyenDersler (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet getButunOnayBekleyenDersler(int hoca_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciButunOnayBekleyenDersler (?)}");
			cs.setInt(1,hoca_id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet getDanismanBilgileri(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL DanismanBilgileriniGetir (?)}");
			cs.setInt(1,id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	
	public ResultSet OgrenciGiris(String email,String sifre)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OgrenciGiris (?,?)}");
			cs.setString(1, email);
			cs.setString(2, sifre);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public boolean DersAl(int ogrenci_id,int ders_id,int hoca_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AlinanDersEkle ( ?,?,?)}");
			cs.setInt(1, ogrenci_id);
			cs.setInt(2, ders_id);
			cs.setInt(3, hoca_id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public boolean alinanDersOnayla(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AlinanDersOnayla ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public boolean alinanDersOnaylama(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AlinanDersOnaylama ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public boolean butunAlinanDersleriOnayla()
	{
		try
		{
			cs=con.prepareCall ("{ CALL ButunAlinanDersleriOnayla ( )}");
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
}
