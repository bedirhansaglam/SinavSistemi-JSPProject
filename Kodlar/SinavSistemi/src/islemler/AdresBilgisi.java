package islemler;


import java.sql.*;
public class AdresBilgisi {
	private Connection con;
	private String driver="com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://localhost/sinavbina?characterEncoding=ISO-8859-9"; 
	private Statement stm;
	private ResultSet resultSet = null;
	
	public AdresBilgisi()
	{

		try { Class.forName(driver).newInstance(); System.out.println("JDBC surucu basari ile y�klendi."); } catch (Exception e) { System.out.println("JDBC surucu Y�klenemedi. Hata:"+e.getMessage()); System.exit(0); }
		try{con=DriverManager.getConnection(url,"root","");System.out.println("Veritaban�na ba�lan�ld�.");}catch (Exception e) { System.out.println("Veri Taban�na Ba�lan�lamad�. Hata:"+e.getMessage()); System.exit(0); }
		try {stm=con.createStatement();}catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0); }
	}

	public ResultSet SehirGetir()
	{
		try
		{
			String query = "CALL SehirGetir()";
			resultSet=stm.executeQuery(query);
		}
		catch (Exception e) { System.out.println("Hata:"+e.getMessage()); System.exit(0);}
		return resultSet;
	}

}
