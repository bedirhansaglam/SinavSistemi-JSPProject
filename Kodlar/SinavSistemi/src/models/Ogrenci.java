package models;

public class Ogrenci {

	String ad,soyad,email,sifre,resim;
	int bolum_id,sehir_id;
	public String getAd() {
		return ad;
	}
	public void setAd(String ad) {
		this.ad = ad;
	}
	public String getSoyad() {
		return soyad;
	}
	public void setSoyad(String soyad) {
		this.soyad = soyad;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSifre() {
		return sifre;
	}
	public void setSifre(String sifre) {
		this.sifre = sifre;
	}
	public String getResim() {
		return resim;
	}
	public void setResim(String resim) {
		this.resim = resim;
	}
	public int getBolum_id() {
		return bolum_id;
	}
	public void setBolum_id(int bolum_id) {
		this.bolum_id = bolum_id;
	}
	public int getSehir_id() {
		return sehir_id;
	}
	public void setSehir_id(int sehir_id) {
		this.sehir_id = sehir_id;
	}
	
}
