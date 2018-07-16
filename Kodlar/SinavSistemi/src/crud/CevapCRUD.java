package crud;
import java.sql.*;
import islemler.VeritabaniBaglantisi;
import models.Cevap;

public class CevapCRUD {

	private Connection con;
	private String driver=VeritabaniBaglantisi.getDriver();
	private String url=VeritabaniBaglantisi.getUrl(); 
	private ResultSet resultSet = null;
	private CallableStatement cs;

	public CevapCRUD()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile y�klendi."); } catch (Exception e) { System.out.println("JDBC surucu Y�klenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,VeritabaniBaglantisi.getKullaniciadi(),VeritabaniBaglantisi.getSifre());System.out.println("Veritaban�na ba�lan�ld�.");}catch (Exception e) { System.out.println("Veri Taban�na Ba�lan�lamad�. Hata:"+e.getMessage()); System.exit(0); }
	}
	
	public boolean createCevap(Cevap cevap)
	{
		try
		{
			cs=con.prepareCall ("{ CALL CevapEkle ( ?, ?, ?)}");
			cs.setInt(1, cevap.getSoru_id());
			cs.setInt(2, cevap.getDogrumu());
			cs.setString(3, cevap.getCevap());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public boolean updateCevap(Cevap cevap,int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL CevapGuncelle ( ?, ?, ?,?)}");
			cs.setInt(1, cevap.getSoru_id());
			cs.setInt(2, cevap.getDogrumu());
			cs.setString(3, cevap.getCevap());
			cs.setInt(4, cevap.getCevap_id());
			cs.execute();
			return true;
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); return false;}
	}
	public ResultSet getAllCevap(int id)
	{
		try
		{
			cs=con.prepareCall ("{ CALL ButunCevaplar�Getir (?)}");
			cs.setInt(1, id);
			resultSet=cs.executeQuery();
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
}
