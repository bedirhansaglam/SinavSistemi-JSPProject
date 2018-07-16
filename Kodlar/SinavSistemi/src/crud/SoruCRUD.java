package crud;
import java.sql.*;
import islemler.VeritabaniBaglantisi;

import models.Soru;

public class SoruCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	public SoruCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createSoru(Soru soru)
	{
		try
		{
			cs=con.prepareCall ("{ CALL SoruEkle ( ?, ?, ?)}");
			cs.setInt(1, soru.getDers_id());
			cs.setInt(2, soru.getHoca_id());
			cs.setString(3, soru.getSoru());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean updateSoru(Soru soru,int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL SoruGuncelle ( ?, ?, ?,?)}");
			cs.setInt(1, soru.getDers_id());
			cs.setInt(2, soru.getHoca_id());
			cs.setString(3, soru.getSoru());
			cs.setInt(4, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet getAllSoru()
	{
		try
		{
			String query = "CALL ButunSorularýGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getSoru(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL SoruGetir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public boolean deleteSoru(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL SoruSil ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public ResultSet getSoruID(int ders_id,String soru)
	{
		try
		{
			cs=con.prepareCall ("{ CALL SoruIdGetir (?,?)}");
			cs.setInt(1, ders_id);
			cs.setString(2, soru);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
}
