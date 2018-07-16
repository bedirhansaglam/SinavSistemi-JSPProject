package crud;
import java.sql.*;
import models.Bolum;
import islemler.VeritabaniBaglantisi;
public class BolumCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	
	private String bolum_adi;
	
	public BolumCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile y�klendi."); } catch (Exception e) { System.out.println("JDBC surucu Y�klenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritaban�na ba�lan�ld�.");}catch (Exception e) { System.out.println("Veri Taban�na Ba�lan�lamad�. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createBolum(Bolum bolum)
	{
		bolum_adi=bolum.getBolum_adi();
		try
		{
			String query = "INSERT INTO bolum(bolum_adi) values('"+bolum_adi+"')"; stm.executeUpdate(query); 
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public ResultSet readAllBolum()
	{
		try
		{
			String query = "SELECT * FROM bolum";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet readBolum(int id)
	{
		try
		{
			String query = "SELECT * FROM bolum WHERE bolum_id='"+id+"'";
			resultSet=stm.executeQuery(query);

		}
		catch (Exception e) { System.out.println("Bir tane data okuma hatas� ;Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public boolean updateBolum(Bolum bolum,int id)
	{
		bolum_adi=bolum.getBolum_adi();
		try
		{
			String query = "UPDATE bolum SET bolum_adi='"+bolum_adi+"'WHERE bolum_id="+id+""; stm.executeUpdate(query); 
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
		
	}
	
	public boolean deleteBolum(int id)
	{
		try
		{
			String query = "DELETE FROM bolum WHERE bolum_id="+id+""; stm.executeUpdate(query);
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
		
	}
}
