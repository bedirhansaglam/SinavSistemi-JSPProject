package models;

public class Cevap {

	int cevap_id,soru_id;
	int dogrumu;
	String cevap;
	
	public int getCevap_id() {
		return cevap_id;
	}
	public void setCevap_id(int cevap_id) {
		this.cevap_id = cevap_id;
	}
	public int getSoru_id() {
		return soru_id;
	}
	public void setSoru_id(int soru_id) {
		this.soru_id = soru_id;
	}
	public int getDogrumu() {
		return dogrumu;
	}
	public void setDogrumu(int dogrumu) {
		this.dogrumu = dogrumu;
	}
	public String getCevap() {
		return cevap;
	}
	public void setCevap(String cevap) {
		this.cevap = cevap;
	}
	
}
