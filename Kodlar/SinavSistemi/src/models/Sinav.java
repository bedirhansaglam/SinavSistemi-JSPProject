package models;

public class Sinav {
	int ders_id,akademisyen_id,soru_sayisi,kitapcik_sayisi;
	String sinav_adi,tarih,saat;
	
	public int getSoru_sayisi() {
		return soru_sayisi;
	}
	public void setSoru_sayisi(int soru_sayisi) {
		this.soru_sayisi = soru_sayisi;
	}
	public int getKitapcik_sayisi() {
		return kitapcik_sayisi;
	}
	public void setKitapcik_sayisi(int kitapcik_sayisi) {
		this.kitapcik_sayisi = kitapcik_sayisi;
	}
	public int getDers_id() {
		return ders_id;
	}
	public void setDers_id(int ders_id) {
		this.ders_id = ders_id;
	}
	public int getAkademisyen_id() {
		return akademisyen_id;
	}
	public void setAkademisyen_id(int akademisyen_id) {
		this.akademisyen_id = akademisyen_id;
	}
	public String getSinav_adi() {
		return sinav_adi;
	}
	public void setSinav_adi(String sinav_adi) {
		this.sinav_adi = sinav_adi;
	}
	public String getTarih() {
		return tarih;
	}
	public void setTarih(String tarih) {
		this.tarih = tarih;
	}
	public String getSaat() {
		return saat;
	}
	public void setSaat(String saat) {
		this.saat = saat;
	}
	

}
