-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 06 Haz 2018, 01:25:47
-- Sunucu sürümü: 5.7.14
-- PHP Sürümü: 7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `sinavbina`
--

DELIMITER $$
--
-- Yordamlar
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdayEkle` (INOUT `p_sinif_id` INT(11), INOUT `p_ogrenci_id` INT(11), INOUT `p_sira_id` INT(11), INOUT `p_kitapcik_id` INT(11))  NO SQL
INSERT INTO sinav_aday(sinav_aday.sinif_id,sinav_aday.ogrenci_id,sinav_aday.sira_id,sinav_aday.kitapcik_id) VALUES(p_sinif_id,p_ogrenci_id,p_sira_id,p_kitapcik_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `adminGiris` (INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50))  NO SQL
SELECT admin.id FROM admin WHERE admin.email=p_email AND admin.sifre=p_sifre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AkademisyenEkle` (INOUT `p_ad` VARCHAR(50), INOUT `p_soyad` VARCHAR(50), INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50), INOUT `p_bolum_id` INT(11), INOUT `p_unvan_id` INT(11), INOUT `p_resim` VARCHAR(50))  NO SQL
INSERT INTO akademisyen(ad, soyad, email, sifre, bolum_id, unvan_id, resim) VALUES (p_ad,p_soyad, p_email, p_sifre, p_bolum_id, p_unvan_id, p_resim)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AkademisyenGetir` (INOUT `id` INT(11))  NO SQL
SELECT akademisyen.*,bolum.bolum_adi,unvanlar.unvan_adi FROM akademisyen,bolum,unvanlar WHERE akademisyen.bolum_id=bolum.bolum_id AND akademisyen.unvan_id=unvanlar.unvan_id AND akademisyen.akademisyen_id=id ORDER BY bolum.bolum_adi$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AkademisyenGiris` (INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50))  NO SQL
SELECT * FROM akademisyen WHERE akademisyen.email=p_email AND akademisyen.sifre=p_sifre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AkademisyenGuncelle` (INOUT `p_ad` VARCHAR(50), INOUT `p_soyad` VARCHAR(50), INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50), INOUT `p_bolum_id` INT(11), INOUT `p_unvan_id` INT(11), INOUT `p_resim` VARCHAR(50), INOUT `p_id` INT(11))  NO SQL
UPDATE akademisyen SET akademisyen.ad=p_ad, akademisyen.soyad=p_soyad,akademisyen.email=p_email,akademisyen.sifre=p_sifre,akademisyen.bolum_id=p_bolum_id,akademisyen.unvan_id=p_unvan_id,akademisyen.resim=p_resim WHERE akademisyen.akademisyen_id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AkademisyenSil` (INOUT `id` INT)  NO SQL
DELETE FROM akademisyen WHERE akademisyen.akademisyen_id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AlinanDersEkle` (INOUT `p_ogrenci_id` INT(11), INOUT `p_ders_id` INT(11), INOUT `p_hoca_id` INT(11))  NO SQL
INSERT INTO alinandersler(alinandersler.ogrenci_no,alinandersler.ders_no,alinandersler.hoca_id) VALUES(p_ogrenci_id,p_ders_id,p_hoca_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AlinanDersleriGetir` (INOUT `p_ogrenci_id` INT(11))  NO SQL
SELECT ders.ders_adi,ders.ders_id,unvanlar.unvan_adi,akademisyen.ad,akademisyen.soyad FROM akademisyen,unvanlar,ders,alinandersler WHERE akademisyen.unvan_id=unvanlar.unvan_id AND alinandersler.ders_no=ders.ders_id AND alinandersler.hoca_id=akademisyen.akademisyen_id AND alinandersler.onay=1 AND alinandersler.ogrenci_no=p_ogrenci_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AlinanDersOnayla` (INOUT `p_id` INT(11))  NO SQL
UPDATE alinandersler SET alinandersler.onay=1 WHERE alinandersler.id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AlinanDersOnaylama` (INOUT `p_id` INT(11))  NO SQL
DELETE FROM alinandersler WHERE alinandersler.id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunAkademisyenleriGetir` ()  NO SQL
SELECT akademisyen.akademisyen_id,akademisyen.resim,akademisyen.ad,akademisyen.soyad,akademisyen.email,akademisyen.sifre,bolum.bolum_adi,unvanlar.unvan_adi FROM akademisyen,bolum,unvanlar WHERE akademisyen.bolum_id=bolum.bolum_id AND akademisyen.unvan_id=unvanlar.unvan_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunAlinanDersleriOnayla` ()  NO SQL
UPDATE alinandersler SET alinandersler.onay=1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunCevaplarıGetir` (INOUT `p_soru_id` INT(11))  NO SQL
SELECT cevap.* FROM cevap,soru WHERE cevap.soru_id=soru.soru_id AND cevap.soru_id=p_soru_id ORDER BY cevap.dogrumu DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunDersleriGetir` ()  NO SQL
SELECT ders.ders_id,ders.ders_adi,bolum.bolum_id,bolum.bolum_adi FROM ders,bolum WHERE ders.bolum_id=bolum.bolum_id ORDER BY bolum.bolum_adi$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunOgrencileriGetir` ()  NO SQL
SELECT ogrenci.*,bolum.bolum_adi,iller.isim AS sehir_adi FROM ogrenci,bolum,iller WHERE ogrenci.bolum_id=bolum.bolum_id AND ogrenci.sehir_id=iller.il_no ORDER BY bolum.bolum_adi$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunOkullariGetir` ()  NO SQL
SELECT okul.*,iller.isim AS sehir_adi FROM okul,iller WHERE okul.sehir_id=iller.il_no ORDER BY iller.isim$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunSorularıGetir` ()  NO SQL
SELECT soru.*,ders.ders_adi,akademisyen.ad,akademisyen.soyad FROM soru,ders,akademisyen WHERE soru.ders_id=ders.ders_id AND akademisyen.akademisyen_id=soru.hoca_id ORDER BY ders.ders_adi$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunTemsilcileriGetir` ()  NO SQL
SELECT temsilci.*,iller.isim AS sehir_adi FROM temsilci,iller WHERE temsilci.sehir_id=iller.il_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ButunVerilenDersleriOnayla` ()  NO SQL
UPDATE verilendersler SET verilendersler.onay=1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CevapEkle` (INOUT `p_soru_id` INT(11), INOUT `p_dogrumu` INT(1), INOUT `p_cevap` VARCHAR(1000))  NO SQL
INSERT INTO cevap(cevap.soru_id,cevap.dogrumu,cevap.cevap) VALUES (p_soru_id,p_dogrumu,p_cevap)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CevapGuncelle` (INOUT `p_soru_id` INT(11), INOUT `p_dogrumu` INT(1), INOUT `p_cevap` VARCHAR(1000), INOUT `p_cevap_id` INT(11))  NO SQL
UPDATE cevap SET cevap.soru_id=p_soru_id,cevap.dogrumu=p_dogrumu,cevap.cevap=p_cevap WHERE cevap.cevap_id=p_cevap_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountAkademisyen` ()  NO SQL
SELECT COUNT(akademisyen.akademisyen_id) AS akademisyen_sayisi FROM akademisyen$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountBolum` ()  NO SQL
SELECT COUNT(bolum.bolum_id) AS bolum_sayisi FROM bolum$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountOgrenci` ()  NO SQL
SELECT COUNT(ogrenci.ogrenci_no) AS ogrenci_sayisi FROM ogrenci$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CountOkul` ()  NO SQL
SELECT COUNT(okul.okul_no) AS okul_sayisi FROM okul$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanismanBilgileriniGetir` (INOUT `p_ogrenci_id` INT(11))  NO SQL
SELECT akademisyen.ad,akademisyen.soyad,unvanlar.unvan_adi,akademisyen.email,akademisyen.resim FROM akademisyen,unvanlar,danisman WHERE danisman.danisman_id=akademisyen.akademisyen_id AND akademisyen.unvan_id=unvanlar.unvan_id AND danisman.ogrenci_id=p_ogrenci_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DanismanEkle` (INOUT `p_bolum_id` INT(11), INOUT `p_ogrenci_id` INT(11))  NO SQL
BEGIN
DECLARE x INT;

SELECT @x:=akademisyen.akademisyen_id FROM akademisyen WHERE akademisyen.bolum_id=p_bolum_id
ORDER BY RAND()
LIMIT 1;

INSERT INTO danisman(danisman.ogrenci_id,danisman.danisman_id) VALUES(p_ogrenci_id,@x);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DersEkle` (INOUT `bolum` INT, INOUT `adi` TEXT CHARSET utf8)  NO SQL
INSERT INTO ders(ders_adi,bolum_id) values(adi,bolum)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DersiAlanOgrencileriGetir` (INOUT `p_ders_id` INT(11), INOUT `p_ders_veren_hoca_id` INT(11))  NO SQL
SELECT DISTINCT ogrenci.ogrenci_no FROM ogrenci,alinandersler WHERE alinandersler.ogrenci_no=ogrenci.ogrenci_no AND alinandersler.ders_no=p_ders_id AND alinandersler.hoca_id=p_ders_veren_hoca_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DersiAlanOgrencininBulunduguSehir` (INOUT `p_ders_id` INT(11), INOUT `p_ders_veren_hoca_id` INT(11))  NO SQL
SELECT DISTINCT ogrenci.sehir_id FROM ogrenci,alinandersler WHERE alinandersler.ogrenci_no=ogrenci.ogrenci_no AND alinandersler.ders_no=p_ders_id AND alinandersler.hoca_id=p_ders_veren_hoca_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DersVer` (INOUT `p_hoca_id` INT(11), INOUT `p_ders_id` INT(11))  NO SQL
INSERT INTO verilendersler(verilendersler.akademisyen_id,verilendersler.ders_id) VALUES(p_hoca_id,p_ders_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DersVerOnay` (INOUT `p_id` INT(11))  NO SQL
UPDATE verilendersler SET verilendersler.onay=1 WHERE verilendersler.id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DersVerOnaylama` (INOUT `p_id` INT(11))  NO SQL
DELETE FROM verilendersler WHERE verilendersler.id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GorevKabuluBekleyenSinavlariGetir` ()  NO SQL
SELECT sinav.*,ders.ders_adi,akademisyen.ad,akademisyen.soyad, unvanlar.unvan_adi FROM sinav,akademisyen,ders,unvanlar,sinav_onay WHERE sinav.onay=1 AND akademisyen.unvan_id=unvanlar.unvan_id AND ders.ders_id=sinav.ders_id AND sinav.sinav_hoca_id=akademisyen.akademisyen_id AND sinav_onay.sinav_id=sinav.sinav_id AND sinav_onay.gorev_kabul=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HocaGorevBilgisiGetir` (INOUT `p_hoca_id` INT(11))  NO SQL
SELECT sinav.sinav_id,ders.ders_adi ,sinav.sinav_adi , sinav.saat , sinav.tarih, akademisyen.ad,akademisyen.soyad , akademisyen.email, iller.isim AS sehir_adi,okul.okul_adi,siniflar.sinif_adi FROM sinav,ders,akademisyen,siniflar,okul,sinav_salonu,iller WHERE ders.ders_id=sinav.ders_id AND akademisyen.akademisyen_id=sinav_salonu.hoca_id AND okul.sehir_id=iller.il_no AND sinav_salonu.sinav_id=sinav.sinav_id AND sinav_salonu.okul_id=okul.okul_no AND sinav_salonu.sinif_id=siniflar.sinif_no AND sinav_salonu.hoca_id=p_hoca_id AND sinav_salonu.hoca_onay=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HocaGorevIptal` (INOUT `p_sinav_id` INT(11), INOUT `p_hoca_id` INT(11), INOUT `p_y_hoca_id` INT(11))  NO SQL
UPDATE sinav_salonu SET sinav_salonu.hoca_id=p_y_hoca_id WHERE sinav_salonu.sinav_id=p_sinav_id AND sinav_salonu.hoca_id=p_hoca_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HocaGorevKabul` (INOUT `p_sinav_id` INT(11), INOUT `p_hoca_id` INT(11))  NO SQL
UPDATE sinav_salonu SET sinav_salonu.hoca_onay=1 WHERE sinav_salonu.hoca_id=p_hoca_id AND sinav_salonu.sinav_id=p_sinav_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HocaOnayBekleyenDersler` (INOUT `p_hoca_id` INT(11))  NO SQL
SELECT ders.* ,bolum.bolum_adi FROM ders,bolum,verilendersler WHERE verilendersler.onay='0' AND verilendersler.ders_id=ders.ders_id AND ders.bolum_id=bolum.bolum_id AND verilendersler.akademisyen_id=p_hoca_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `IlceGetir` (INOUT `sehir_id` INT(11))  NO SQL
SELECT ilceler.ilce_no,ilceler.isim FROM ilceler,iller WHERE ilceler.il_no=iller.il_no AND iller.il_no=sehir_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `KitapcikGetir` (INOUT `p_sinav_id` INT(11))  NO SQL
SELECT kitapcik.kitapcik_no FROM kitapcik WHERE kitapcik.sinav_id=p_sinav_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `KitapcikSorusuOlustur` (INOUT `p_k_id` INT(11), INOUT `p_soru_id` INT(11))  NO SQL
INSERT INTO kitapcik_soru(kitapcik_soru.kitapcik_id,kitapcik_soru.soru_id) VALUES (p_k_id,p_soru_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciButunOnayBekleyenDersler` (INOUT `p_hoca_id` INT(11))  NO SQL
SELECT alinandersler.id,ogrenci.ad,ogrenci.soyad,ders.ders_adi,akademisyen.ad as hoca_adi,akademisyen.soyad as hoca_soyadi , unvanlar.unvan_adi FROM alinandersler,unvanlar,akademisyen,ogrenci,ders,danisman WHERE alinandersler.ogrenci_no=ogrenci.ogrenci_no AND alinandersler.ders_no=ders.ders_id AND alinandersler.hoca_id=akademisyen.akademisyen_id AND akademisyen.unvan_id=unvanlar.unvan_id AND alinandersler.onay=0 AND danisman.danisman_id=p_hoca_id AND danisman.ogrenci_id=ogrenci.ogrenci_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciDersleriGetir` (INOUT `p_ogrenci_id` INT(11))  NO SQL
SELECT ders.ders_id,ders.ders_adi,unvanlar.unvan_adi,akademisyen.akademisyen_id,akademisyen.ad,akademisyen.soyad FROM akademisyen,unvanlar,ders,verilendersler,ogrenci WHERE akademisyen.unvan_id=unvanlar.unvan_id AND verilendersler.ders_id=ders.ders_id AND akademisyen.akademisyen_id=verilendersler.akademisyen_id AND ders.bolum_id=ogrenci.bolum_id AND verilendersler.onay=1 AND ogrenci.ogrenci_no=p_ogrenci_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciEkle` (INOUT `p_bolum_id` INT(11), INOUT `p_resim` VARCHAR(50), INOUT `p_ad` VARCHAR(50), INOUT `p_soyad` VARCHAR(50), INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50), IN `p_sehir_id` INT(11))  NO SQL
INSERT INTO ogrenci(ogrenci.bolum_id,ogrenci.resim,ogrenci.ad,ogrenci.soyad,ogrenci.email,ogrenci.sifre,ogrenci.sehir_id) VALUES (p_bolum_id,p_resim,p_ad,p_soyad,p_email,p_sifre,p_sehir_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciGetir` (INOUT `id` INT(11))  NO SQL
SELECT ogrenci.*,bolum.bolum_adi,iller.isim AS sehir_adi FROM ogrenci,bolum,iller WHERE ogrenci.bolum_id=bolum.bolum_id AND ogrenci.sehir_id=iller.il_no AND ogrenci.ogrenci_no=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciGiris` (INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50))  NO SQL
SELECT ogrenci.* FROM ogrenci WHERE ogrenci.email=p_email AND ogrenci.sifre=p_sifre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciGuncelle` (INOUT `p_bolum_id` INT(11), INOUT `p_resim` VARCHAR(50), INOUT `p_ad` VARCHAR(50), INOUT `p_soyad` VARCHAR(50), INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50), INOUT `p_sehir_id` INT(11), INOUT `p_ogrenci_no` INT(11))  NO SQL
UPDATE ogrenci SET ogrenci.bolum_id=p_bolum_id,ogrenci.resim=p_resim,ogrenci.ad=p_ad,ogrenci.soyad=p_soyad,ogrenci.email=p_email,ogrenci.sifre=p_sifre,ogrenci.sehir_id=p_sehir_id WHERE ogrenci.ogrenci_no=p_ogrenci_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciOnayBekleyenDersler` (INOUT `p_ogrenci_id` INT(11))  NO SQL
SELECT ders.ders_adi,ders.ders_id,unvanlar.unvan_adi,akademisyen.ad,akademisyen.soyad FROM akademisyen,unvanlar,ders,alinandersler WHERE akademisyen.unvan_id=unvanlar.unvan_id AND alinandersler.ders_no=ders.ders_id AND alinandersler.hoca_id=akademisyen.akademisyen_id AND alinandersler.onay=0 AND alinandersler.ogrenci_no=p_ogrenci_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciSil` (INOUT `id` INT(11))  NO SQL
DELETE FROM ogrenci WHERE ogrenci.ogrenci_no=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OgrenciSinavBilgisiGetir` (INOUT `p_ogrenci_id` INT(11))  NO SQL
SELECT ders.ders_adi,sinav.*,siralar.sira_adi,sinav_aday.kitapcik_id, okul.okul_adi,siniflar.sinif_adi FROM sinav_aday,sinav_salonu,sinav,ders,siralar,okul,siniflar WHERE sinav_aday.sinif_id=sinav_salonu.sinif_id AND sinav_aday.ogrenci_id=p_ogrenci_id AND sinav_salonu.sinav_id=sinav.sinav_id AND ders.ders_id=sinav.ders_id AND siralar.sira_id=sinav_aday.sira_id AND sinav_salonu.okul_id=okul.okul_no AND sinav_salonu.sinif_id=siniflar.sinif_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OkulEkle` (INOUT `p_sehir_id` INT(11), INOUT `p_okul_adi` VARCHAR(1000), INOUT `p_sinif_sayisi` INT(11), INOUT `p_sinif_kapasitesi` INT(11))  NO SQL
INSERT INTO okul(okul.sehir_id,okul.okul_adi,okul.sinif_sayisi,okul.sinif_kapasitesi) VALUES (p_sehir_id,p_okul_adi,p_sinif_sayisi,p_sinif_kapasitesi)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OkulGetir` (INOUT `okul_id` INT(11))  NO SQL
SELECT okul.*,iller.isim AS sehir_adi FROM okul,iller WHERE okul.okul_no=okul_id AND okul.sehir_id=iller.il_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OkulGetirSehir` (INOUT `sehir_id` INT(11))  NO SQL
SELECT okul.*,iller.isim AS sehir_adi FROM okul,iller WHERE okul.sehir_id=sehir_id AND okul.sehir_id=iller.il_no$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OkulGuncelle` (INOUT `p_sehir_id` INT(11), INOUT `p_okul_adi` VARCHAR(1000), INOUT `p_sinif_sayisi` INT(11), INOUT `p_sinif_kapasitesi` INT(11), INOUT `p_okul_id` INT(11))  NO SQL
UPDATE okul SET okul.sehir_id=p_sehir_id, okul.okul_adi=p_okul_adi, okul.sinif_sayisi=p_sinif_sayisi, okul.sinif_kapasitesi=p_sinif_kapasitesi WHERE okul.okul_no=p_okul_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OkulSil` (INOUT `okul_id` INT(11))  NO SQL
DELETE FROM okul WHERE okul.okul_no=okul_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OnayBekleyenDersleriGetir` ()  NO SQL
SELECT verilendersler.id,ders.* ,bolum.bolum_adi,akademisyen.ad,akademisyen.soyad,unvanlar.unvan_adi FROM ders,bolum,verilendersler,akademisyen,unvanlar WHERE verilendersler.onay=0 AND verilendersler.ders_id=ders.ders_id AND ders.bolum_id=bolum.bolum_id AND verilendersler.akademisyen_id=akademisyen.akademisyen_id AND unvanlar.unvan_id=akademisyen.unvan_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `OnayBekleyenSinavlariGetir` ()  NO SQL
SELECT sinav.*,ders.ders_adi,akademisyen.ad,akademisyen.soyad, unvanlar.unvan_adi FROM sinav,akademisyen,ders,unvanlar WHERE sinav.onay=0 AND akademisyen.unvan_id=unvanlar.unvan_id AND ders.ders_id=sinav.ders_id AND sinav.sinav_hoca_id=akademisyen.akademisyen_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RastgeleAkademisyenGetir` ()  NO SQL
SELECT akademisyen.akademisyen_id FROM akademisyen
ORDER BY RAND()
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RastgeleOkulGetir` (INOUT `p_sehir_id` INT)  NO SQL
SELECT okul.okul_no FROM okul WHERE okul.sehir_id=p_sehir_id
ORDER BY RAND()
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RastgeleSinavSalonuGetir` (INOUT `p_okulno` INT(11))  NO SQL
SELECT siniflar.sinif_no FROM siniflar WHERE siniflar.okul_no=p_okulno
ORDER BY RAND()
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RastgeleSoruGetir` (INOUT `p_hoca_id` INT(11), INOUT `p_ders_id` INT(11))  NO SQL
SELECT soru.soru_id FROM soru WHERE soru.hoca_id=p_hoca_id AND soru.ders_id=p_ders_id
ORDER BY RAND()
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RastgeleTemsilciGetir` ()  NO SQL
SELECT temsilci.temsilci_id FROM temsilci 
ORDER BY RAND()
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SalonEkle` (INOUT `p_sinav_id` INT(11), INOUT `p_okul_id` INT(11), INOUT `p_sinif_id` INT(11), INOUT `p_hoca_id` INT(11))  NO SQL
INSERT INTO sinav_salonu(sinav_salonu.sinav_id,sinav_salonu.okul_id,sinav_salonu.sinif_id,sinav_salonu.hoca_id) VALUES(p_sinav_id,p_okul_id,p_sinif_id,p_hoca_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SehirGetir` ()  NO SQL
SELECT * FROM iller$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SinavEkle` (INOUT `p_sinav_adi` VARCHAR(1000), INOUT `p_ders_id` INT(11), INOUT `p_tarih` VARCHAR(50), INOUT `p_saat` VARCHAR(50), INOUT `p_hoca_id` INT(11), INOUT `p_soru_sayisi` INT(11), INOUT `p_kitapcik_sayisi` INT(11))  NO SQL
INSERT INTO sinav(sinav.sinav_adi,sinav.ders_id,sinav.tarih,sinav.saat,sinav.sinav_hoca_id,sinav.soru_sayisi,sinav.kitapcik_sayisi) VALUES (p_sinav_adi,p_ders_id,p_tarih,p_saat,p_hoca_id,p_soru_sayisi,p_kitapcik_sayisi)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SinavGorevKabul` (INOUT `p_hoca_id` INT(11))  NO SQL
UPDATE sinav_onay SET sinav_onay.gorev_kabul=1 WHERE sinav_onay.gorevli_akademisyen_id=p_hoca_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SinavOnayEkle` (IN `p_sinav_id` INT(11), INOUT `p_temsilci_id` INT(11), INOUT `p_okul_id` INT(11))  NO SQL
INSERT INTO sinav_onay(sinav_onay.sinav_id,sinav_onay.temsilci_id,sinav_onay.okul_id) VALUES (p_sinav_id,p_temsilci_id,p_okul_id)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SinavOnayla` (INOUT `p_id` INT(11))  NO SQL
UPDATE sinav SET sinav.onay=1 WHERE sinav.sinav_id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SinavSil` (INOUT `p_id` INT(11))  NO SQL
DELETE FROM sinav WHERE sinav.sinav_id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SinifEkle` (IN `sayi` INT, IN `kapasite` INT, IN `okul_no` INT)  BEGIN

  DECLARE x INT;
  SET x = 1;
  
  WHILE x <= sayi DO
  	INSERT INTO siniflar(siniflar.okul_no,siniflar.sinif_adi,siniflar.kapasite) VALUES(okul_no,okul_no+'A'+x,kapasite);
  	SET x = x + 1;
  END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SiraIdGetir` (INOUT `p_sinif_id` INT(11))  NO SQL
SELECT siralar.sira_id FROM siralar WHERE siralar.sinif_id=p_sinif_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SonEklenenSinaviGetir` ()  NO SQL
SELECT sinav.sinav_id FROM sinav ORDER BY  sinav.sinav_id DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SonKayitOlanOgrenciyiGetir` ()  NO SQL
SELECT ogrenci.ogrenci_no ,ogrenci.bolum_id 
FROM ogrenci ORDER BY ogrenci.ogrenci_no DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SoruEkle` (INOUT `p_ders_id` INT(11), INOUT `p_hoca_id` INT(11), INOUT `p_soru` VARCHAR(1000))  NO SQL
INSERT INTO soru(soru.ders_id,soru.hoca_id,soru.soru) VALUES (p_ders_id,p_hoca_id,p_soru)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SoruGetir` (INOUT `p_soru_id` INT(11))  NO SQL
SELECT soru.*,ders.ders_adi,akademisyen.ad,akademisyen.soyad FROM soru,ders,akademisyen WHERE soru.ders_id=ders.ders_id AND akademisyen.akademisyen_id=soru.hoca_id AND soru.soru_id=p_soru_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SoruGuncelle` (INOUT `p_ders_id` INT(11), INOUT `p_hoca_id` INT(11), INOUT `p_soru` VARCHAR(1000), IN `p_soru_id` INT(11))  NO SQL
UPDATE soru SET soru.ders_id=p_ders_id,soru.hoca_id=p_hoca_id,soru.soru=p_soru WHERE soru.soru_id=p_soru_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SoruIdGetir` (INOUT `p_ders_id` INT(11), INOUT `p_soru` VARCHAR(1000))  NO SQL
SELECT soru.soru_id FROM soru WHERE soru.ders_id=p_ders_id AND soru.soru=p_soru$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SoruSil` (INOUT `p_soru_id` INT(11))  NO SQL
DELETE FROM soru WHERE soru.soru_id=p_soru_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TemsilciEkle` (INOUT `p_ad` VARCHAR(50), INOUT `p_soyad` VARCHAR(50), INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50), INOUT `p_sehir_id` INT(11), IN `p_resim` VARCHAR(50))  NO SQL
INSERT INTO temsilci(temsilci.ad,temsilci.soyad,temsilci.email,temsilci.sifre,temsilci.sehir_id,temsilci.resim) VALUES (p_ad,p_soyad,p_email,p_sifre,p_sehir_id,p_resim)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TemsilciGetir` (INOUT `id` INT(11))  NO SQL
SELECT temsilci.*,iller.isim AS sehir_adi FROM temsilci,iller WHERE temsilci.sehir_id=iller.il_no AND temsilci.temsilci_id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TemsilciGuncelle` (INOUT `p_ad` VARCHAR(50), INOUT `p_soyad` VARCHAR(50), INOUT `p_email` VARCHAR(50), INOUT `p_sifre` VARCHAR(50), INOUT `p_sehir_id` INT(11), INOUT `p_resim` VARCHAR(50), INOUT `p_id` INT(11))  NO SQL
UPDATE temsilci SET temsilci.ad=p_ad,temsilci.soyad=p_soyad,temsilci.email=p_email,temsilci.sifre=p_sifre,temsilci.sehir_id=p_sehir_id, temsilci.resim=p_resim WHERE temsilci.temsilci_id=p_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TemsilciSil` (INOUT `id` INT(11))  NO SQL
DELETE FROM temsilci WHERE temsilci.temsilci_id=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UnvanGetir` ()  NO SQL
SELECT * FROM unvanlar$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VerilenDersleriGetir` (INOUT `p_hoca_id` INT(11))  NO SQL
SELECT ders.* ,bolum.bolum_adi FROM ders,bolum,verilendersler WHERE verilendersler.onay='1' AND verilendersler.ders_id=ders.ders_id AND ders.bolum_id=bolum.bolum_id AND verilendersler.akademisyen_id=p_hoca_id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `admin`
--

INSERT INTO `admin` (`id`, `email`, `sifre`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `akademisyen`
--

CREATE TABLE `akademisyen` (
  `akademisyen_id` int(11) NOT NULL,
  `ad` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `soyad` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `bolum_id` int(11) NOT NULL,
  `unvan_id` int(11) NOT NULL,
  `resim` varchar(250) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `akademisyen`
--

INSERT INTO `akademisyen` (`akademisyen_id`, `ad`, `soyad`, `email`, `sifre`, `bolum_id`, `unvan_id`, `resim`) VALUES
(11, 'Bedirhan', 'Sağlam', 'bedirhansaglam@hotmail.com', '12345', 2, 7, 'akademisyen.png'),
(13, 'Kemal', 'Akyol', 'kakyol@kastamonu.edu.tr', '12345', 2, 3, 'akademisyen.png'),
(14, 'Abdulkadir', 'Karaci', 'akaraci123@gmail.com', '12345', 2, 3, 'akademisyen.png'),
(15, 'Yasemin', 'Gültepe', 'ygultepe123@kastamonu.edu.tr', '12345', 2, 3, 'akademisyen.png'),
(16, 'Arif', 'Uzun', 'auzun123@kastamonu.edu.tr', '12345', 4, 3, 'akademisyen.png'),
(17, 'Fuat', 'Kartal', 'fkartal123@kastamonu.edu.tr', '12345', 4, 3, 'akademisyen.png'),
(18, 'Fadime', 'Şimşek', 'fsimsek123@kastamonu.edu.tr', '12345', 4, 3, 'akademisyen.png'),
(19, 'Savaş', 'Canbulat', 'scanbulat123@kastamonu.edu.tr', '1234', 3, 1, 'akademisyen.png'),
(20, 'Hakan', 'Şevik', 'hsevik123@kastamonu.edu.tr', '12345', 3, 2, 'akademisyen.png'),
(21, 'Aydın', 'Türkyılmaz', 'aturk123@kastamonu.edu.tr', '12345', 3, 3, 'akademisyen.png');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `alinandersler`
--

CREATE TABLE `alinandersler` (
  `id` int(11) NOT NULL,
  `ogrenci_no` int(11) NOT NULL,
  `ders_no` int(11) NOT NULL,
  `hoca_id` int(11) NOT NULL,
  `onay` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `alinandersler`
--

INSERT INTO `alinandersler` (`id`, `ogrenci_no`, `ders_no`, `hoca_id`, `onay`) VALUES
(1, 3, 6, 13, b'1'),
(2, 7, 6, 13, b'1'),
(3, 9, 6, 13, b'1'),
(4, 10, 6, 13, b'1'),
(5, 11, 6, 13, b'1'),
(6, 12, 6, 13, b'1'),
(8, 14, 6, 13, b'1'),
(9, 15, 6, 13, b'1');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bolum`
--

CREATE TABLE `bolum` (
  `bolum_id` int(11) NOT NULL,
  `bolum_adi` varchar(45) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `bolum`
--

INSERT INTO `bolum` (`bolum_id`, `bolum_adi`) VALUES
(2, 'Bilgisayar Mühendisliği'),
(3, 'Çevre Mühendisliği'),
(4, 'Makine Mühendisliği');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cevap`
--

CREATE TABLE `cevap` (
  `cevap_id` int(11) NOT NULL,
  `soru_id` int(11) NOT NULL,
  `dogrumu` int(1) NOT NULL,
  `cevap` varchar(1000) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `cevap`
--

INSERT INTO `cevap` (`cevap_id`, `soru_id`, `dogrumu`, `cevap`) VALUES
(1, 4, 1, 'doğru cevap bu güncelle'),
(2, 4, 0, 'yanlış cevap bu'),
(3, 4, 0, 'yanlış cevap bu 1 güncelle'),
(4, 4, 0, 'yanlış cevap bu 2'),
(13, 7, 1, 'doğru cevap'),
(14, 7, 0, 'yanlış cevap'),
(15, 7, 0, 'yanlış cevap'),
(16, 7, 0, 'yanlış cevap'),
(17, 8, 1, 'cevap'),
(18, 8, 0, 'cevap'),
(19, 8, 0, 'cevap'),
(20, 8, 0, 'cevap'),
(21, 9, 1, 'ddcevap'),
(22, 9, 0, 'cevap'),
(23, 9, 0, 'cevap'),
(24, 9, 0, 'cevap'),
(25, 10, 1, 'dor'),
(26, 10, 0, 'yyy'),
(27, 10, 0, 'yyy'),
(28, 10, 0, 'yyy');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `danisman`
--

CREATE TABLE `danisman` (
  `id` int(11) NOT NULL,
  `ogrenci_id` int(11) NOT NULL,
  `danisman_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `danisman`
--

INSERT INTO `danisman` (`id`, `ogrenci_id`, `danisman_id`) VALUES
(2, 14, 13),
(3, 3, 13),
(4, 7, 13),
(5, 9, 13),
(6, 10, 13),
(7, 11, 13),
(8, 12, 13),
(9, 15, 13);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ders`
--

CREATE TABLE `ders` (
  `ders_id` int(11) NOT NULL,
  `ders_adi` varchar(45) COLLATE utf8_turkish_ci NOT NULL,
  `bolum_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ders`
--

INSERT INTO `ders` (`ders_id`, `ders_adi`, `bolum_id`) VALUES
(1, 'Sunucu Yazılım Teknolojileri', 2),
(2, 'Çevre ve Bölge Planlama', 3),
(5, 'Makine Öğrenmesi', 2),
(6, 'Görüntü İşleme', 2),
(7, 'Bilgisayar Mimarisi', 2),
(8, 'Veri Yapıları', 2),
(9, 'Çevre Mühendisliğinde Biyolojik Prosesler', 3),
(10, 'Kanalizasyon Sistem Tasarımı', 3),
(11, 'Kentsel Yeşil Alanlar', 3),
(12, 'Sürdürülebilir Temiz Üretim', 3),
(13, 'MAKİNE ELEMANLARI I', 4),
(14, 'MEKANİZMA TEKNİĞİ', 4),
(15, 'MEKANİK TİTREŞİMLER', 4),
(16, 'MAKİNE DİNAMİĞİ', 4),
(17, 'BİLGİSAYAR DESTEKLİ TASARIM', 4),
(18, 'test', 2);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `iller`
--

CREATE TABLE `iller` (
  `il_no` int(11) NOT NULL,
  `isim` varchar(50) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `iller`
--

INSERT INTO `iller` (`il_no`, `isim`) VALUES
(1, 'Adana'),
(2, 'Adıyaman'),
(3, 'Afyonkarahisar'),
(4, 'Ağrı'),
(5, 'Amasya'),
(6, 'Ankara'),
(7, 'Antalya'),
(8, 'Artvin'),
(9, 'Aydın'),
(10, 'Balıkesir'),
(11, 'Bilecik'),
(12, 'Bingöl'),
(13, 'Bitlis'),
(14, 'Bolu'),
(15, 'Burdur'),
(16, 'Bursa'),
(17, 'Çanakkale'),
(18, 'Çankırı'),
(19, 'Çorum'),
(20, 'Denizli'),
(21, 'Diyarbakır'),
(22, 'Edirne'),
(23, 'Elâzığ'),
(24, 'Erzincan'),
(25, 'Erzurum'),
(26, 'Eskişehir'),
(27, 'Gaziantep'),
(28, 'Giresun'),
(29, 'Gümüşhane'),
(30, 'Hakkâri'),
(31, 'Hatay'),
(32, 'Isparta'),
(33, 'Mersin'),
(34, 'İstanbul'),
(35, 'İzmir'),
(36, 'Kars'),
(37, 'Kastamonu'),
(38, 'Kayseri'),
(39, 'Kırklareli'),
(40, 'Kırşehir'),
(41, 'Kocaeli'),
(42, 'Konya'),
(43, 'Kütahya'),
(44, 'Malatya'),
(45, 'Manisa'),
(46, 'Kahramanmaraş'),
(47, 'Mardin'),
(48, 'Muğla'),
(49, 'Muş'),
(50, 'Nevşehir'),
(51, 'Niğde'),
(52, 'Ordu'),
(53, 'Rize'),
(54, 'Sakarya'),
(55, 'Samsun'),
(56, 'Siirt'),
(57, 'Sinop'),
(58, 'Sivas'),
(59, 'Tekirdağ'),
(60, 'Tokat'),
(61, 'Trabzon'),
(62, 'Tunceli'),
(63, 'Şanlıurfa'),
(64, 'Uşak'),
(65, 'Van'),
(66, 'Yozgat'),
(67, 'Zonguldak'),
(68, 'Aksaray'),
(69, 'Bayburt'),
(70, 'Karaman'),
(71, 'Kırıkkale'),
(72, 'Batman'),
(73, 'Şırnak'),
(74, 'Bartın'),
(75, 'Ardahan'),
(76, 'Iğdır'),
(77, 'Yalova'),
(78, 'Karabük'),
(79, 'Kilis'),
(80, 'Osmaniye'),
(81, 'Düzce');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitapcik`
--

CREATE TABLE `kitapcik` (
  `kitapcik_no` int(11) NOT NULL,
  `sinav_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitapcik`
--

INSERT INTO `kitapcik` (`kitapcik_no`, `sinav_id`) VALUES
(5, 5),
(6, 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kitapcik_soru`
--

CREATE TABLE `kitapcik_soru` (
  `kitapcik_id` int(11) NOT NULL,
  `soru_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kitapcik_soru`
--

INSERT INTO `kitapcik_soru` (`kitapcik_id`, `soru_id`) VALUES
(5, 9),
(5, 7),
(5, 10),
(5, 4),
(5, 7),
(6, 7),
(6, 10),
(6, 8),
(6, 9),
(6, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ogrenci`
--

CREATE TABLE `ogrenci` (
  `ogrenci_no` int(11) NOT NULL,
  `bolum_id` int(11) NOT NULL,
  `resim` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `soyad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sehir_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `ogrenci`
--

INSERT INTO `ogrenci` (`ogrenci_no`, `bolum_id`, `resim`, `ad`, `soyad`, `email`, `sifre`, `sehir_id`) VALUES
(3, 2, 'ogrenci.png', 'Bedirhan', 'Sağlam', 'bedirhansaglam@hotmail.com', '12345', 6),
(7, 2, 'ogrenci.png', 'Zübeyr', 'Eser', 'eserzubeyr@gmail.com', '123456', 6),
(9, 2, 'ogrenci.png', 'UmedZhon', 'Isbasarov', 'izbasarovumed@gmail.com', '213123123132', 6),
(10, 2, 'ogrenci.png', 'Muhammed', 'Gazali', 'mgazali@gmail.com', '543321', 6),
(11, 2, 'ogrenci.png', 'Fadik', 'Uğur', 'fugur@gmail.com', '1234124', 6),
(12, 2, 'ogrenci.png', 'Ahmet', 'Porsuk', 'porsukahmet@gmail.com', '654321', 6),
(14, 2, 'ogrenci.png', 'Emre', 'Yarar', 'yarar@gmail.com', '12345', 6),
(15, 2, 'ogrenci.png', 'Melek', 'Kocabey', 'mkocabey@gmail.com', '12345', 6);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `okul`
--

CREATE TABLE `okul` (
  `okul_no` int(11) NOT NULL,
  `sehir_id` int(11) NOT NULL,
  `okul_adi` varchar(60) COLLATE utf8_turkish_ci NOT NULL,
  `sinif_sayisi` int(11) NOT NULL,
  `sinif_kapasitesi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `okul`
--

INSERT INTO `okul` (`okul_no`, `sehir_id`, `okul_adi`, `sinif_sayisi`, `sinif_kapasitesi`) VALUES
(18, 6, 'Ankara Üniversitesi', 3, 50),
(19, 6, 'Gazi Üniversitesi', 2, 50);

--
-- Tetikleyiciler `okul`
--
DELIMITER $$
CREATE TRIGGER `SinifEkle` AFTER INSERT ON `okul` FOR EACH ROW BEGIN

  DECLARE x INT;
  SET x = 1;
  WHILE x <= NEW.sinif_sayisi DO
  	INSERT INTO siniflar(siniflar.okul_no,siniflar.sinif_adi,siniflar.kapasite) VALUES(New.okul_no,1020+New.okul_no+x,New.sinif_kapasitesi);
  	SET x = x + 1;
  END WHILE;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `SinifGuncelle` AFTER UPDATE ON `okul` FOR EACH ROW BEGIN

  DECLARE x INT;
  
  DELETE FROM siniflar WHERE siniflar.okul_no=New.okul_no;
  
  SET x = 1;
  WHILE x <= NEW.sinif_sayisi DO
  	INSERT INTO siniflar(siniflar.okul_no,siniflar.sinif_adi,siniflar.kapasite) VALUES(New.okul_no,1020+New.okul_no+x,New.sinif_kapasitesi);
  	SET x = x + 1;
  END WHILE;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sinav`
--

CREATE TABLE `sinav` (
  `sinav_id` int(11) NOT NULL,
  `sinav_adi` varchar(1000) COLLATE utf8_turkish_ci NOT NULL,
  `ders_id` int(11) NOT NULL,
  `tarih` date NOT NULL,
  `saat` time NOT NULL,
  `sinav_hoca_id` int(11) NOT NULL,
  `soru_sayisi` int(11) NOT NULL,
  `kitapcik_sayisi` int(11) NOT NULL,
  `onay` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sinav`
--

INSERT INTO `sinav` (`sinav_id`, `sinav_adi`, `ders_id`, `tarih`, `saat`, `sinav_hoca_id`, `soru_sayisi`, `kitapcik_sayisi`, `onay`) VALUES
(5, 'Vize', 6, '2018-06-22', '10:30:00', 13, 5, 2, b'1');

--
-- Tetikleyiciler `sinav`
--
DELIMITER $$
CREATE TRIGGER `KitapcikOlustur` AFTER INSERT ON `sinav` FOR EACH ROW BEGIN
  DECLARE x INT;
  SET x = 1;
  WHILE x <= NEW.kitapcik_sayisi DO
INSERT INTO kitapcik(kitapcik.sinav_id) VALUES (New.sinav_id);
  	SET x = x + 1;
  END WHILE;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sinav_aday`
--

CREATE TABLE `sinav_aday` (
  `sinif_id` int(11) NOT NULL,
  `ogrenci_id` int(11) NOT NULL,
  `sira_id` int(11) NOT NULL,
  `kitapcik_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sinav_aday`
--

INSERT INTO `sinav_aday` (`sinif_id`, `ogrenci_id`, `sira_id`, `kitapcik_id`) VALUES
(20, 3, 256, 5),
(20, 7, 257, 5),
(20, 9, 258, 5),
(20, 10, 259, 5),
(20, 11, 260, 5),
(20, 12, 261, 5),
(20, 14, 262, 5),
(20, 15, 263, 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sinav_onay`
--

CREATE TABLE `sinav_onay` (
  `sinav_onay_id` int(11) NOT NULL,
  `sinav_id` int(11) NOT NULL,
  `temsilci_id` int(11) NOT NULL,
  `okul_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sinav_onay`
--

INSERT INTO `sinav_onay` (`sinav_onay_id`, `sinav_id`, `temsilci_id`, `okul_id`) VALUES
(9, 5, 1, 19);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sinav_salonu`
--

CREATE TABLE `sinav_salonu` (
  `id` int(11) NOT NULL,
  `sinav_id` int(11) NOT NULL,
  `okul_id` int(11) NOT NULL,
  `sinif_id` int(11) NOT NULL,
  `hoca_id` int(11) NOT NULL,
  `hoca_onay` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sinav_salonu`
--

INSERT INTO `sinav_salonu` (`id`, `sinav_id`, `okul_id`, `sinif_id`, `hoca_id`, `hoca_onay`) VALUES
(2, 5, 19, 20, 19, b'0');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `siniflar`
--

CREATE TABLE `siniflar` (
  `sinif_no` int(11) NOT NULL,
  `okul_no` int(11) NOT NULL,
  `sinif_adi` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `kapasite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `siniflar`
--

INSERT INTO `siniflar` (`sinif_no`, `okul_no`, `sinif_adi`, `kapasite`) VALUES
(16, 18, '1039', 50),
(17, 18, '1040', 50),
(18, 18, '1041', 50),
(19, 19, '1040', 50),
(20, 19, '1041', 50);

--
-- Tetikleyiciler `siniflar`
--
DELIMITER $$
CREATE TRIGGER `SiraEkle` AFTER INSERT ON `siniflar` FOR EACH ROW BEGIN

  DECLARE x INT;
  SET x = 1;
  WHILE x <= NEW.kapasite DO
  	INSERT INTO siralar(siralar.sinif_id,siralar.sira_adi) VALUES(New.sinif_no,x);
  	SET x = x + 1;
  END WHILE;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `SiraGuncelle` AFTER UPDATE ON `siniflar` FOR EACH ROW BEGIN

  DECLARE x INT;
  DELETE FROM siralar WHERE siralar.sinif_id=New.sinif_no;
  SET x = 1;
  WHILE x <= NEW.kapasite DO
  	INSERT INTO siralar(siralar.sinif_id,siralar.sira_adi) VALUES(New.sinif_no,x);
  	SET x = x + 1;
  END WHILE;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `siralar`
--

CREATE TABLE `siralar` (
  `sira_id` int(11) NOT NULL,
  `sinif_id` int(11) NOT NULL,
  `sira_adi` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `durum` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `siralar`
--

INSERT INTO `siralar` (`sira_id`, `sinif_id`, `sira_adi`, `durum`) VALUES
(56, 16, '1', b'0'),
(57, 16, '2', b'0'),
(58, 16, '3', b'0'),
(59, 16, '4', b'0'),
(60, 16, '5', b'0'),
(61, 16, '6', b'0'),
(62, 16, '7', b'0'),
(63, 16, '8', b'0'),
(64, 16, '9', b'0'),
(65, 16, '10', b'0'),
(66, 16, '11', b'0'),
(67, 16, '12', b'0'),
(68, 16, '13', b'0'),
(69, 16, '14', b'0'),
(70, 16, '15', b'0'),
(71, 16, '16', b'0'),
(72, 16, '17', b'0'),
(73, 16, '18', b'0'),
(74, 16, '19', b'0'),
(75, 16, '20', b'0'),
(76, 16, '21', b'0'),
(77, 16, '22', b'0'),
(78, 16, '23', b'0'),
(79, 16, '24', b'0'),
(80, 16, '25', b'0'),
(81, 16, '26', b'0'),
(82, 16, '27', b'0'),
(83, 16, '28', b'0'),
(84, 16, '29', b'0'),
(85, 16, '30', b'0'),
(86, 16, '31', b'0'),
(87, 16, '32', b'0'),
(88, 16, '33', b'0'),
(89, 16, '34', b'0'),
(90, 16, '35', b'0'),
(91, 16, '36', b'0'),
(92, 16, '37', b'0'),
(93, 16, '38', b'0'),
(94, 16, '39', b'0'),
(95, 16, '40', b'0'),
(96, 16, '41', b'0'),
(97, 16, '42', b'0'),
(98, 16, '43', b'0'),
(99, 16, '44', b'0'),
(100, 16, '45', b'0'),
(101, 16, '46', b'0'),
(102, 16, '47', b'0'),
(103, 16, '48', b'0'),
(104, 16, '49', b'0'),
(105, 16, '50', b'0'),
(106, 17, '1', b'0'),
(107, 17, '2', b'0'),
(108, 17, '3', b'0'),
(109, 17, '4', b'0'),
(110, 17, '5', b'0'),
(111, 17, '6', b'0'),
(112, 17, '7', b'0'),
(113, 17, '8', b'0'),
(114, 17, '9', b'0'),
(115, 17, '10', b'0'),
(116, 17, '11', b'0'),
(117, 17, '12', b'0'),
(118, 17, '13', b'0'),
(119, 17, '14', b'0'),
(120, 17, '15', b'0'),
(121, 17, '16', b'0'),
(122, 17, '17', b'0'),
(123, 17, '18', b'0'),
(124, 17, '19', b'0'),
(125, 17, '20', b'0'),
(126, 17, '21', b'0'),
(127, 17, '22', b'0'),
(128, 17, '23', b'0'),
(129, 17, '24', b'0'),
(130, 17, '25', b'0'),
(131, 17, '26', b'0'),
(132, 17, '27', b'0'),
(133, 17, '28', b'0'),
(134, 17, '29', b'0'),
(135, 17, '30', b'0'),
(136, 17, '31', b'0'),
(137, 17, '32', b'0'),
(138, 17, '33', b'0'),
(139, 17, '34', b'0'),
(140, 17, '35', b'0'),
(141, 17, '36', b'0'),
(142, 17, '37', b'0'),
(143, 17, '38', b'0'),
(144, 17, '39', b'0'),
(145, 17, '40', b'0'),
(146, 17, '41', b'0'),
(147, 17, '42', b'0'),
(148, 17, '43', b'0'),
(149, 17, '44', b'0'),
(150, 17, '45', b'0'),
(151, 17, '46', b'0'),
(152, 17, '47', b'0'),
(153, 17, '48', b'0'),
(154, 17, '49', b'0'),
(155, 17, '50', b'0'),
(156, 18, '1', b'0'),
(157, 18, '2', b'0'),
(158, 18, '3', b'0'),
(159, 18, '4', b'0'),
(160, 18, '5', b'0'),
(161, 18, '6', b'0'),
(162, 18, '7', b'0'),
(163, 18, '8', b'0'),
(164, 18, '9', b'0'),
(165, 18, '10', b'0'),
(166, 18, '11', b'0'),
(167, 18, '12', b'0'),
(168, 18, '13', b'0'),
(169, 18, '14', b'0'),
(170, 18, '15', b'0'),
(171, 18, '16', b'0'),
(172, 18, '17', b'0'),
(173, 18, '18', b'0'),
(174, 18, '19', b'0'),
(175, 18, '20', b'0'),
(176, 18, '21', b'0'),
(177, 18, '22', b'0'),
(178, 18, '23', b'0'),
(179, 18, '24', b'0'),
(180, 18, '25', b'0'),
(181, 18, '26', b'0'),
(182, 18, '27', b'0'),
(183, 18, '28', b'0'),
(184, 18, '29', b'0'),
(185, 18, '30', b'0'),
(186, 18, '31', b'0'),
(187, 18, '32', b'0'),
(188, 18, '33', b'0'),
(189, 18, '34', b'0'),
(190, 18, '35', b'0'),
(191, 18, '36', b'0'),
(192, 18, '37', b'0'),
(193, 18, '38', b'0'),
(194, 18, '39', b'0'),
(195, 18, '40', b'0'),
(196, 18, '41', b'0'),
(197, 18, '42', b'0'),
(198, 18, '43', b'0'),
(199, 18, '44', b'0'),
(200, 18, '45', b'0'),
(201, 18, '46', b'0'),
(202, 18, '47', b'0'),
(203, 18, '48', b'0'),
(204, 18, '49', b'0'),
(205, 18, '50', b'0'),
(206, 19, '1', b'0'),
(207, 19, '2', b'0'),
(208, 19, '3', b'0'),
(209, 19, '4', b'0'),
(210, 19, '5', b'0'),
(211, 19, '6', b'0'),
(212, 19, '7', b'0'),
(213, 19, '8', b'0'),
(214, 19, '9', b'0'),
(215, 19, '10', b'0'),
(216, 19, '11', b'0'),
(217, 19, '12', b'0'),
(218, 19, '13', b'0'),
(219, 19, '14', b'0'),
(220, 19, '15', b'0'),
(221, 19, '16', b'0'),
(222, 19, '17', b'0'),
(223, 19, '18', b'0'),
(224, 19, '19', b'0'),
(225, 19, '20', b'0'),
(226, 19, '21', b'0'),
(227, 19, '22', b'0'),
(228, 19, '23', b'0'),
(229, 19, '24', b'0'),
(230, 19, '25', b'0'),
(231, 19, '26', b'0'),
(232, 19, '27', b'0'),
(233, 19, '28', b'0'),
(234, 19, '29', b'0'),
(235, 19, '30', b'0'),
(236, 19, '31', b'0'),
(237, 19, '32', b'0'),
(238, 19, '33', b'0'),
(239, 19, '34', b'0'),
(240, 19, '35', b'0'),
(241, 19, '36', b'0'),
(242, 19, '37', b'0'),
(243, 19, '38', b'0'),
(244, 19, '39', b'0'),
(245, 19, '40', b'0'),
(246, 19, '41', b'0'),
(247, 19, '42', b'0'),
(248, 19, '43', b'0'),
(249, 19, '44', b'0'),
(250, 19, '45', b'0'),
(251, 19, '46', b'0'),
(252, 19, '47', b'0'),
(253, 19, '48', b'0'),
(254, 19, '49', b'0'),
(255, 19, '50', b'0'),
(256, 20, '1', b'0'),
(257, 20, '2', b'0'),
(258, 20, '3', b'0'),
(259, 20, '4', b'0'),
(260, 20, '5', b'0'),
(261, 20, '6', b'0'),
(262, 20, '7', b'0'),
(263, 20, '8', b'0'),
(264, 20, '9', b'0'),
(265, 20, '10', b'0'),
(266, 20, '11', b'0'),
(267, 20, '12', b'0'),
(268, 20, '13', b'0'),
(269, 20, '14', b'0'),
(270, 20, '15', b'0'),
(271, 20, '16', b'0'),
(272, 20, '17', b'0'),
(273, 20, '18', b'0'),
(274, 20, '19', b'0'),
(275, 20, '20', b'0'),
(276, 20, '21', b'0'),
(277, 20, '22', b'0'),
(278, 20, '23', b'0'),
(279, 20, '24', b'0'),
(280, 20, '25', b'0'),
(281, 20, '26', b'0'),
(282, 20, '27', b'0'),
(283, 20, '28', b'0'),
(284, 20, '29', b'0'),
(285, 20, '30', b'0'),
(286, 20, '31', b'0'),
(287, 20, '32', b'0'),
(288, 20, '33', b'0'),
(289, 20, '34', b'0'),
(290, 20, '35', b'0'),
(291, 20, '36', b'0'),
(292, 20, '37', b'0'),
(293, 20, '38', b'0'),
(294, 20, '39', b'0'),
(295, 20, '40', b'0'),
(296, 20, '41', b'0'),
(297, 20, '42', b'0'),
(298, 20, '43', b'0'),
(299, 20, '44', b'0'),
(300, 20, '45', b'0'),
(301, 20, '46', b'0'),
(302, 20, '47', b'0'),
(303, 20, '48', b'0'),
(304, 20, '49', b'0'),
(305, 20, '50', b'0');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `soru`
--

CREATE TABLE `soru` (
  `soru_id` int(11) NOT NULL,
  `ders_id` int(11) NOT NULL,
  `hoca_id` int(11) NOT NULL,
  `soru` varchar(1000) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `soru`
--

INSERT INTO `soru` (`soru_id`, `ders_id`, `hoca_id`, `soru`) VALUES
(4, 6, 13, 'İlk soru denemesi test'),
(7, 6, 13, '2.soru'),
(8, 6, 13, '3.soru'),
(9, 6, 13, '4.soru'),
(10, 6, 13, '5.soru');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `temsilci`
--

CREATE TABLE `temsilci` (
  `temsilci_id` int(11) NOT NULL,
  `ad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `soyad` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `sehir_id` int(11) NOT NULL,
  `resim` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `temsilci`
--

INSERT INTO `temsilci` (`temsilci_id`, `ad`, `soyad`, `email`, `sifre`, `sehir_id`, `resim`) VALUES
(1, 'Durmuş', 'Bayraklı', 'dbayrakli@gmail.com', '123123', 6, 'temsilci.png'),
(2, 'Sercan', 'Topaçoğlu', 'sercantopacoeeglu@gmail.com', '322323', 6, 'temsilci.png'),
(3, 'Arda', 'Toprakçıoğlu', 'toprakciogluarda@gmail.com', '98756213', 6, 'temsilci.png');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `unvanlar`
--

CREATE TABLE `unvanlar` (
  `unvan_id` int(11) NOT NULL,
  `unvan_adi` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `unvanlar`
--

INSERT INTO `unvanlar` (`unvan_id`, `unvan_adi`) VALUES
(1, 'Prof. Dr.'),
(2, 'Doç. Dr.'),
(3, 'Dr. Öğr. Üyesi'),
(4, 'Öğr. Gör. Dr.'),
(5, 'Öğr. Gör.'),
(6, 'Arş. Gör. Dr.'),
(7, 'Arş. Gör.');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `verilendersler`
--

CREATE TABLE `verilendersler` (
  `id` int(11) NOT NULL,
  `akademisyen_id` int(11) DEFAULT NULL,
  `ders_id` int(11) DEFAULT NULL,
  `onay` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `verilendersler`
--

INSERT INTO `verilendersler` (`id`, `akademisyen_id`, `ders_id`, `onay`) VALUES
(2, 13, 6, b'1'),
(3, 11, 7, b'1');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `akademisyen`
--
ALTER TABLE `akademisyen`
  ADD PRIMARY KEY (`akademisyen_id`),
  ADD KEY `bolum_id` (`bolum_id`),
  ADD KEY `unvan_id` (`unvan_id`);

--
-- Tablo için indeksler `alinandersler`
--
ALTER TABLE `alinandersler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ogrenci_no` (`ogrenci_no`),
  ADD KEY `ders_no` (`ders_no`),
  ADD KEY `hoca_id` (`hoca_id`);

--
-- Tablo için indeksler `bolum`
--
ALTER TABLE `bolum`
  ADD PRIMARY KEY (`bolum_id`);

--
-- Tablo için indeksler `cevap`
--
ALTER TABLE `cevap`
  ADD PRIMARY KEY (`cevap_id`),
  ADD KEY `soru_id` (`soru_id`);

--
-- Tablo için indeksler `danisman`
--
ALTER TABLE `danisman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ogrenci_id` (`ogrenci_id`),
  ADD KEY `danisman_id` (`danisman_id`);

--
-- Tablo için indeksler `ders`
--
ALTER TABLE `ders`
  ADD PRIMARY KEY (`ders_id`),
  ADD KEY `test` (`bolum_id`);

--
-- Tablo için indeksler `iller`
--
ALTER TABLE `iller`
  ADD PRIMARY KEY (`il_no`);

--
-- Tablo için indeksler `kitapcik`
--
ALTER TABLE `kitapcik`
  ADD PRIMARY KEY (`kitapcik_no`),
  ADD KEY `sinav_id` (`sinav_id`);

--
-- Tablo için indeksler `kitapcik_soru`
--
ALTER TABLE `kitapcik_soru`
  ADD KEY `kitapcik_id` (`kitapcik_id`),
  ADD KEY `soru_id` (`soru_id`);

--
-- Tablo için indeksler `ogrenci`
--
ALTER TABLE `ogrenci`
  ADD PRIMARY KEY (`ogrenci_no`),
  ADD KEY `bolum_id` (`bolum_id`),
  ADD KEY `sehir_id` (`sehir_id`);

--
-- Tablo için indeksler `okul`
--
ALTER TABLE `okul`
  ADD PRIMARY KEY (`okul_no`),
  ADD KEY `sehir_id` (`sehir_id`);

--
-- Tablo için indeksler `sinav`
--
ALTER TABLE `sinav`
  ADD PRIMARY KEY (`sinav_id`),
  ADD KEY `sinav_hoca_id` (`sinav_hoca_id`),
  ADD KEY `ders_id` (`ders_id`);

--
-- Tablo için indeksler `sinav_aday`
--
ALTER TABLE `sinav_aday`
  ADD KEY `sinif_id` (`sinif_id`,`ogrenci_id`,`sira_id`,`kitapcik_id`),
  ADD KEY `kitapcik_id` (`kitapcik_id`),
  ADD KEY `ogrenci_id` (`ogrenci_id`);

--
-- Tablo için indeksler `sinav_onay`
--
ALTER TABLE `sinav_onay`
  ADD PRIMARY KEY (`sinav_onay_id`),
  ADD KEY `sinav_id` (`sinav_id`),
  ADD KEY `temsilci_id` (`temsilci_id`),
  ADD KEY `okul_id` (`okul_id`);

--
-- Tablo için indeksler `sinav_salonu`
--
ALTER TABLE `sinav_salonu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sinav_id` (`sinav_id`),
  ADD KEY `okul_id` (`okul_id`),
  ADD KEY `sinif_id` (`sinif_id`),
  ADD KEY `hoca_id` (`hoca_id`),
  ADD KEY `sinav_id_2` (`sinav_id`);

--
-- Tablo için indeksler `siniflar`
--
ALTER TABLE `siniflar`
  ADD PRIMARY KEY (`sinif_no`),
  ADD KEY `okul_no` (`okul_no`);

--
-- Tablo için indeksler `siralar`
--
ALTER TABLE `siralar`
  ADD PRIMARY KEY (`sira_id`),
  ADD KEY `sinif_id` (`sinif_id`);

--
-- Tablo için indeksler `soru`
--
ALTER TABLE `soru`
  ADD PRIMARY KEY (`soru_id`),
  ADD KEY `ders_id` (`ders_id`),
  ADD KEY `hoca_id` (`hoca_id`);

--
-- Tablo için indeksler `temsilci`
--
ALTER TABLE `temsilci`
  ADD PRIMARY KEY (`temsilci_id`),
  ADD KEY `sehir_id` (`sehir_id`);

--
-- Tablo için indeksler `unvanlar`
--
ALTER TABLE `unvanlar`
  ADD PRIMARY KEY (`unvan_id`);

--
-- Tablo için indeksler `verilendersler`
--
ALTER TABLE `verilendersler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `akademisyen_id` (`akademisyen_id`),
  ADD KEY `ders_id` (`ders_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Tablo için AUTO_INCREMENT değeri `akademisyen`
--
ALTER TABLE `akademisyen`
  MODIFY `akademisyen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- Tablo için AUTO_INCREMENT değeri `alinandersler`
--
ALTER TABLE `alinandersler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Tablo için AUTO_INCREMENT değeri `bolum`
--
ALTER TABLE `bolum`
  MODIFY `bolum_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Tablo için AUTO_INCREMENT değeri `cevap`
--
ALTER TABLE `cevap`
  MODIFY `cevap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- Tablo için AUTO_INCREMENT değeri `danisman`
--
ALTER TABLE `danisman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Tablo için AUTO_INCREMENT değeri `ders`
--
ALTER TABLE `ders`
  MODIFY `ders_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- Tablo için AUTO_INCREMENT değeri `kitapcik`
--
ALTER TABLE `kitapcik`
  MODIFY `kitapcik_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Tablo için AUTO_INCREMENT değeri `ogrenci`
--
ALTER TABLE `ogrenci`
  MODIFY `ogrenci_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Tablo için AUTO_INCREMENT değeri `okul`
--
ALTER TABLE `okul`
  MODIFY `okul_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- Tablo için AUTO_INCREMENT değeri `sinav`
--
ALTER TABLE `sinav`
  MODIFY `sinav_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Tablo için AUTO_INCREMENT değeri `sinav_onay`
--
ALTER TABLE `sinav_onay`
  MODIFY `sinav_onay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Tablo için AUTO_INCREMENT değeri `sinav_salonu`
--
ALTER TABLE `sinav_salonu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Tablo için AUTO_INCREMENT değeri `siniflar`
--
ALTER TABLE `siniflar`
  MODIFY `sinif_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- Tablo için AUTO_INCREMENT değeri `siralar`
--
ALTER TABLE `siralar`
  MODIFY `sira_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306;
--
-- Tablo için AUTO_INCREMENT değeri `soru`
--
ALTER TABLE `soru`
  MODIFY `soru_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Tablo için AUTO_INCREMENT değeri `temsilci`
--
ALTER TABLE `temsilci`
  MODIFY `temsilci_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Tablo için AUTO_INCREMENT değeri `verilendersler`
--
ALTER TABLE `verilendersler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `akademisyen`
--
ALTER TABLE `akademisyen`
  ADD CONSTRAINT `akademisyen_ibfk_1` FOREIGN KEY (`bolum_id`) REFERENCES `bolum` (`bolum_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `akademisyen_ibfk_2` FOREIGN KEY (`unvan_id`) REFERENCES `unvanlar` (`unvan_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `alinandersler`
--
ALTER TABLE `alinandersler`
  ADD CONSTRAINT `alinandersler_ibfk_1` FOREIGN KEY (`ogrenci_no`) REFERENCES `ogrenci` (`ogrenci_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alinandersler_ibfk_2` FOREIGN KEY (`ders_no`) REFERENCES `ders` (`ders_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `alinandersler_ibfk_3` FOREIGN KEY (`hoca_id`) REFERENCES `akademisyen` (`akademisyen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `cevap`
--
ALTER TABLE `cevap`
  ADD CONSTRAINT `cevap_ibfk_1` FOREIGN KEY (`soru_id`) REFERENCES `soru` (`soru_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `danisman`
--
ALTER TABLE `danisman`
  ADD CONSTRAINT `akademisyen` FOREIGN KEY (`danisman_id`) REFERENCES `akademisyen` (`akademisyen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ogrenci` FOREIGN KEY (`ogrenci_id`) REFERENCES `ogrenci` (`ogrenci_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ders`
--
ALTER TABLE `ders`
  ADD CONSTRAINT `test` FOREIGN KEY (`bolum_id`) REFERENCES `bolum` (`bolum_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitapcik`
--
ALTER TABLE `kitapcik`
  ADD CONSTRAINT `kitapcik_ibfk_1` FOREIGN KEY (`sinav_id`) REFERENCES `sinav` (`sinav_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kitapcik_soru`
--
ALTER TABLE `kitapcik_soru`
  ADD CONSTRAINT `kitapcik_soru_ibfk_1` FOREIGN KEY (`kitapcik_id`) REFERENCES `kitapcik` (`kitapcik_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `ogrenci`
--
ALTER TABLE `ogrenci`
  ADD CONSTRAINT `ogrenci_ibfk_1` FOREIGN KEY (`bolum_id`) REFERENCES `bolum` (`bolum_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ogrenci_ibfk_2` FOREIGN KEY (`sehir_id`) REFERENCES `iller` (`il_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `okul`
--
ALTER TABLE `okul`
  ADD CONSTRAINT `okul_ibfk_1` FOREIGN KEY (`sehir_id`) REFERENCES `iller` (`il_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `sinav`
--
ALTER TABLE `sinav`
  ADD CONSTRAINT `sinav_ibfk_1` FOREIGN KEY (`sinav_hoca_id`) REFERENCES `akademisyen` (`akademisyen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sinav_ibfk_2` FOREIGN KEY (`ders_id`) REFERENCES `ders` (`ders_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `sinav_aday`
--
ALTER TABLE `sinav_aday`
  ADD CONSTRAINT `sinav_aday_ibfk_1` FOREIGN KEY (`sinif_id`) REFERENCES `sinav_salonu` (`sinif_id`),
  ADD CONSTRAINT `sinav_aday_ibfk_2` FOREIGN KEY (`kitapcik_id`) REFERENCES `kitapcik` (`kitapcik_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sinav_aday_ibfk_3` FOREIGN KEY (`ogrenci_id`) REFERENCES `ogrenci` (`ogrenci_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `sinav_onay`
--
ALTER TABLE `sinav_onay`
  ADD CONSTRAINT `sinav_onay_ibfk_1` FOREIGN KEY (`sinav_id`) REFERENCES `sinav` (`sinav_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sinav_onay_ibfk_2` FOREIGN KEY (`temsilci_id`) REFERENCES `temsilci` (`temsilci_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `sinav_salonu`
--
ALTER TABLE `sinav_salonu`
  ADD CONSTRAINT `sinav_salonu_ibfk_1` FOREIGN KEY (`okul_id`) REFERENCES `okul` (`okul_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sinav_salonu_ibfk_2` FOREIGN KEY (`sinav_id`) REFERENCES `sinav` (`sinav_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sinav_salonu_ibfk_3` FOREIGN KEY (`hoca_id`) REFERENCES `akademisyen` (`akademisyen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `siniflar`
--
ALTER TABLE `siniflar`
  ADD CONSTRAINT `siniflar_ibfk_1` FOREIGN KEY (`okul_no`) REFERENCES `okul` (`okul_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `siralar`
--
ALTER TABLE `siralar`
  ADD CONSTRAINT `siralar_ibfk_1` FOREIGN KEY (`sinif_id`) REFERENCES `siniflar` (`sinif_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `soru`
--
ALTER TABLE `soru`
  ADD CONSTRAINT `soru_ibfk_1` FOREIGN KEY (`ders_id`) REFERENCES `ders` (`ders_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `soru_ibfk_2` FOREIGN KEY (`hoca_id`) REFERENCES `akademisyen` (`akademisyen_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `temsilci`
--
ALTER TABLE `temsilci`
  ADD CONSTRAINT `temsilci_ibfk_1` FOREIGN KEY (`sehir_id`) REFERENCES `iller` (`il_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `verilendersler`
--
ALTER TABLE `verilendersler`
  ADD CONSTRAINT `verilendersler_ibfk_1` FOREIGN KEY (`akademisyen_id`) REFERENCES `akademisyen` (`akademisyen_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `verilendersler_ibfk_2` FOREIGN KEY (`ders_id`) REFERENCES `ders` (`ders_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
