package crud;

import java.sql.*;

import islemler.VeritabaniBaglantisi;

import models.Okul;
public class OkulCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	public OkulCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createOkul(Okul okul)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OkulEkle ( ?, ?, ?, ?)}");
			cs.setInt(1,okul.getSehir_id());
			cs.setString(2, okul.getOkul_adi());
			cs.setInt(3, okul.getSinif_sayisi());
			cs.setInt(4, okul.getSinif_kapasitesi());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public boolean updateOkul(Okul okul,int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OkulGuncelle ( ?, ?, ?, ?,?)}");
			cs.setInt(1,okul.getSehir_id());
			cs.setString(2, okul.getOkul_adi());
			cs.setInt(3, okul.getSinif_sayisi());
			cs.setInt(4, okul.getSinif_kapasitesi());
			cs.setInt(5, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean deleteOkul(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL OkulSil ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet getAllOkul()
	{
		try
		{
			String query = "CALL ButunOkullariGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getOkul(int id)
	{try
	{
		cs=con.prepareCall ("{ CALL OkulGetir (?)}");
		cs.setInt(1, id);
		resultSet=cs.executeQuery();
		
	}
	catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
	return resultSet;
		
	}
	public ResultSet getOkulBySehirId(int id)
	{try
	{
		cs=con.prepareCall ("{ CALL OkulGetirSehir (?)}");
		cs.setInt(1, id);
		resultSet=cs.executeQuery();
		
	}
	catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
	return resultSet;
	}
	
}
