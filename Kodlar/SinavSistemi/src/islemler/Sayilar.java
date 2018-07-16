package islemler;
import java.sql.*;
public class Sayilar {
	private Connection con;
	private String driver="com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://localhost/sinavbina?characterEncoding=ISO-8859-9"; 
	private ResultSet resultSet = null;
	private CallableStatement cs;
	public Sayilar()
	{
		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile yüklendi."); } catch (Exception e) { System.out.println("JDBC surucu Yüklenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,"root","");System.out.println("Veritabanýna baðlanýldý.");}catch (Exception e) { System.out.println("Veri Tabanýna Baðlanýlamadý. Hata:"+e.getMessage()); System.exit(0); }
	}

	public ResultSet countOgrenci()
	{
		try
		{
			cs=con.prepareCall ("{ CALL CountOgrenci ()}");
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet countBolum()
	{
		try
		{
			cs=con.prepareCall ("{ CALL CountBolum ()}");
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet countAkademisyen()
	{
		try
		{
			cs=con.prepareCall ("{ CALL CountAkademisyen ()}");
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet countOkul()
	{
		try
		{
			cs=con.prepareCall ("{ CALL CountOkul ()}");
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
	public ResultSet adminGiris(String email,String sifre)
	{
		try
		{
			cs=con.prepareCall ("{ CALL adminGiris (?,?)}");
			cs.setString(1, email);
			cs.setString(2, sifre);
			resultSet=cs.executeQuery();
			
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}
}
