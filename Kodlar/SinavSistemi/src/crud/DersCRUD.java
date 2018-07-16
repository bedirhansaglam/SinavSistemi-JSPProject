package crud;

import java.sql.*;

import islemler.VeritabaniBaglantisi;
import models.Ders;
public class DersCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	private String ders_adi;
	private int bolum_id;
	
	public DersCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createDers(Ders ders)
	{
		ders_adi=ders.getDers_adi();
		bolum_id=ders.getBolum_id();
		
		try
		{
			String query = "INSERT INTO ders(ders_adi,bolum_id) values('"+ders_adi+"','"+bolum_id+"')"; stm.executeUpdate(query); 
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet readAllDers()
	{
		try
		{
			String query = "CALL ButunDersleriGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet readDers( int id)
	{
		try
		{
			String query = "SELECT ders.ders_id,ders.ders_adi,bolum.bolum_id,bolum.bolum_adi FROM ders,bolum WHERE ders.bolum_id=bolum.bolum_id AND ders_id='"+id+"'";
			resultSet=stm.executeQuery(query);

		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public boolean updateDers(Ders ders, int id)
	{
		bolum_id=ders.getBolum_id();
		ders_adi=ders.getDers_adi();
		
		try
		{
			String query = "UPDATE ders SET ders_adi='"+ders_adi+"', bolum_id='"+bolum_id+"' WHERE ders_id="+id+""; stm.executeUpdate(query); 
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean deleteDers(int id)
	{
		try
		{
			String query = "DELETE FROM ders WHERE ders_id="+id+""; stm.executeUpdate(query);
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
		
	}
	public boolean insertVerilenDers(int akademisyen_id,int ders_id)
	{ try
		{
			cs=con.prepareCall ("{ CALL DersVer ( ?, ? )}");
			cs.setInt(1, akademisyen_id);
			cs.setInt(2, ders_id);
			cs.execute();
			return true;
		}
	catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
		
	}
	public boolean approveVerilenDers(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL DersVerOnay ( ? )}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean dontApproveVerilenDers(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL DersVerOnaylama ( ? )}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet getAdminOnayBekleyenDersler()
	{
		try
		{
			String query = "CALL OnayBekleyenDersleriGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getHocaninOnayBekleyenDersleri(int hoca_id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL HocaOnayBekleyenDersler (?)}");
			cs.setInt(1, hoca_id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet getVerilenDersler(int hoca_id)
	{try
	{
		cs=con.prepareCall ("{ CALL VerilenDersleriGetir (?)}");
		cs.setInt(1, hoca_id);
		resultSet=cs.executeQuery();
		
	}
	catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
	return resultSet;
		
	}
	public boolean ButunDersleriOnayla() {
		
		try
		{
			cs=con.prepareCall ("{ CALL ButunVerilenDersleriOnayla();}");
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
}
