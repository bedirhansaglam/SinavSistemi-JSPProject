package crud;

import java.sql.*;
import models.Temsilci;
import islemler.VeritabaniBaglantisi;
public class TemsilciCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	public TemsilciCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createTemsilci(Temsilci temsilci)
	{
		try
		{
			cs=con.prepareCall ("{ CALL TemsilciEkle ( ?, ?, ?, ?, ?, ? )}");			
			cs.setString(1, temsilci.getAd());
			cs.setString(2, temsilci.getSoyad());
			cs.setString(3, temsilci.getEmail());
			cs.setString(4, temsilci.getSifre());
			cs.setInt(5, temsilci.getSehir_id());
			cs.setString(6, temsilci.getResim());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean updateTemsilci(Temsilci temsilci,int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL TemsilciGuncelle ( ?, ?, ?, ?, ?, ?,? )}");			
			cs.setString(1, temsilci.getAd());
			cs.setString(2, temsilci.getSoyad());
			cs.setString(3, temsilci.getEmail());
			cs.setString(4, temsilci.getSifre());
			cs.setInt(5, temsilci.getSehir_id());
			cs.setString(6, temsilci.getResim());
			cs.setInt(7, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
		
	}
	public ResultSet readAllTemsilci()
	{
		try
		{
			String query = "CALL ButunTemsilcileriGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet readTemsilci(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL TemsilciGetir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public boolean deleteTemsilci(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL TemsilciSil ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
}
