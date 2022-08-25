/*
DDL DATA DEFINITION LANG.
CREATE- ALTER DROP
*/
--CREATE TABLO OLUSTURMA
create table ogrenci(
ogr_no int,
ogr_adsoyad varchar(30),
notlar real,
yas int,
adres varchar(50),
kayit_tarih date
);
-- VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA--
create table ogr_notlari
as select ogr_no, notlar from ogrenci;

select * from ogrenci;
select * from ogr_notlari;










