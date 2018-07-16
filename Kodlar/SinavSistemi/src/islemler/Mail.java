package islemler;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
public class Mail {

	String gonderici_mail_adresi="sunucuyazilimteknolojileritest@gmail.com";
	String gonderici_sifre="xudnw0g0";
	String aliciemail="";
	
	public boolean Gonder(String AliciEmailAdres, String Mesaj)
	{
			aliciemail=AliciEmailAdres;
		   // ozellik nesnesi olusturuluyor
		   Properties properties = System.getProperties();

		   // mail server ayarlari yapiliyor
		   properties.put("mail.smtp.host", "smtp.gmail.com");
		   properties.put("mail.smtp.port", "587");
		   properties.put("mail.smtp.starttls.enable", "true");
		   properties.put("mail.smtp.auth", "true"); 

		   //SSL sertifikasi kullanilmak istenirse bu ayarlar eklenir
		   properties.put("mail.smtp.socketFactory.port", "465");
		   properties.put("mail.smtp.socketFactory.class", 
		       "javax.net.ssl.SSLSocketFactory");
		   properties.put("mail.smtp.auth", "true");
		   properties.put("mail.smtp.port", "465");

		   // Mail icin session nesnesi olusturulur.
		   Session mailSession = Session.getInstance(properties,
		                           new javax.mail.Authenticator() {
		                    protected PasswordAuthentication getPasswordAuthentication() {
		                           return new PasswordAuthentication(gonderici_mail_adresi, gonderici_sifre);
		                    }
		             }); 

		   try {
		      // olusturulan sessiondan mimemesage nesnesi olusturulur
		      MimeMessage message = new MimeMessage(mailSession);
		      
		      // gonderici adresi set ediliyor
		      message.setFrom(new InternetAddress(gonderici_mail_adresi));
		      
		      // alici adresi set ediliyor
		      message.addRecipient(Message.RecipientType.TO,
		                               new InternetAddress(aliciemail));
		      // mail basligi set ediliyor
		      message.setSubject("SINAV GÖZETMENLÝK GÖREVÝ");
		      
		      // mail icerigi set ediliyor
		      message.setText(Mesaj);
		      
		      // mail gonderiliyor
		      Transport.send(message);
		      //mail gonderilir ise sonuc 1
		      return true;
		   } catch (MessagingException mex) {
		      mex.printStackTrace();
		    //mail gonderilemez ise sonuc 0
		     return false;
		   }
	}
}
