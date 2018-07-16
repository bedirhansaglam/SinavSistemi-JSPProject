package crud;
import java.sql.*;
import islemler.VeritabaniBaglantisi;
import models.Akademisyen;
public class akademisyenCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private Statement stm;
	private ResultSet resultSet = null;
	private CallableStatement cs;
	
	
	public akademisyenCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile y�klendi."); } catch (Exception e) { System.out.println("JDBC surucu Y�klenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritaban�na ba�lan�ld�.");}catch (Exception e) { System.out.println("Veri Taban�na Ba�lan�lamad�. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createAkademisyen(Akademisyen akademisyen)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AkademisyenEkle ( ?, ?, ?, ?, ?, ?, ? )}");
			cs.setString(1, akademisyen.getAd());
			cs.setString(2, akademisyen.getSoyad());
			cs.setString(3, akademisyen.getEmail());
			cs.setString(4, akademisyen.getSifre());
			cs.setInt(5, akademisyen.getBolum_id());
			cs.setInt(6, akademisyen.getUnvan_id());
			cs.setString(7, akademisyen.getResim());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	
	public ResultSet readAllAkademisyen()
	{
		try
		{
			String query = "CALL ButunAkademisyenleriGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet readAllUnvan()
	{
		try
		{
			String query = "CALL UnvanGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	
	public ResultSet readAkademisyen(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AkademisyenGetir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public ResultSet GirisControl(String email,String sifre)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AkademisyenGiris (?,?)}");
			cs.setString(1, email);
			cs.setString(2, sifre);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
		
	}
	public boolean updateAkademisyen(Akademisyen akademisyen,int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AkademisyenGuncelle ( ?, ?, ?, ?, ?, ?, ?,? )}");
			cs.setString(1, akademisyen.getAd());
			cs.setString(2, akademisyen.getSoyad());
			cs.setString(3, akademisyen.getEmail());
			cs.setString(4, akademisyen.getSifre());
			cs.setInt(5, akademisyen.getBolum_id());
			cs.setInt(6, akademisyen.getUnvan_id());
			cs.setString(7, akademisyen.getResim());
			cs.setInt(8, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean deleteAkademisyen(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL AkademisyenSil ( ?)}");
			cs.setInt(1, id);
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
}
