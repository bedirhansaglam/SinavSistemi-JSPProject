package islemler;

public class VeritabaniBaglantisi {

	static String kullaniciadi="root";
	static String sifre="";
	static String url="jdbc:mysql://localhost/sinavbina?characterEncoding=ISO-8859-9";
	static String driver="com.mysql.jdbc.Driver";

	public static String getKullaniciadi() {
		return kullaniciadi;
	}

	public static String getSifre() {
		return sifre;
	}

	public static String getUrl()
	{
		return url;
	}
	public static String getDriver()
	{
		return driver;
	}
}
