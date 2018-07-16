package models;

public class Soru {

	int soru_id,hoca_id,ders_id;
	String soru;
	public int getSoru_id() {
		return soru_id;
	}
	public void setSoru_id(int soru_id) {
		this.soru_id = soru_id;
	}
	public int getHoca_id() {
		return hoca_id;
	}
	public void setHoca_id(int hoca_id) {
		this.hoca_id = hoca_id;
	}
	public int getDers_id() {
		return ders_id;
	}
	public void setDers_id(int ders_id) {
		this.ders_id = ders_id;
	}
	public String getSoru() {
		return soru;
	}
	public void setSoru(String soru) {
		this.soru = soru;
	}
	
	
}
