-- PERSONEL ISMINDE BIR TABLO OLUSTURALIM
create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)
);
-- VAROLAN PERSONEL TABLOSUNDAN pers_id, sehir, adres, field'larina sahip personel_adres adinda yeni bir tablo olustur
create table personel_adres
as select pers_id,sehir,adres from personel;
select*from personel;
select*from personel_adres;

-- DML DATA MANIPULATION LANG.
-- INSERT -- TABLOYA VERI EKLEME 
--UPDATE -- TABLODA VERI GUNCELLEME
--DELETE -- TABLODA VERI SILME 

--INSERT
create table student(
id varchar(4),
st_name varchar(30),
age int
);

insert into student values ('1001','Ali Can',25);
insert into student values ('1002','Veli Kan',35);
insert into student values ('1003','Ayse Van',45);
insert into student values ('1004','Derya Tan',55);

-- TABLOYA PARCALI VERI EKLEME

insert into student(st_name,age) values ('Murat San',65);

--DQL --DATA QUERY LANG.
--SELECT
SELECT * FROM STUDENT;
select st_name from student;
--select komutu where kosulu
select * from student where age>35;

--TCL -- TRANSACTION CONTROL LANG.
--BEGIN - SAVEPOINT - ROLLBACK - COMMIT
--transaction veri tabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer.
-- bu islemler ver tabani olusturma, veri silme, veri guncelleme veriyi geri getirme gibi islemler olabilir.

create table ogrenciler2(
id serial,
isim varchar(50),
veli_isim varchar(50),
yazili_notu real);
begin;
insert into ogrenciler2 values(default, 'Ali Can', 'Hasan can',75.5);
insert into ogrenciler2 values(default, 'Canan Gul', 'Ayse Gul',90.5);
savepoint x;
insert into ogrenciler2 values(default, 'Kemal Yaman', 'Ahmet Yaman',85.5);
insert into ogrenciler2 values(default, 'Pinar Deniz', 'Huseyin Deniz',65.5);

rollback to x;

select*from ogrenciler2; 

commit;
--transaction kullaniminda SERIAL data turu kullanailmasi pek tavsiye edilemez
--savepointten sonra ekledigimiz veride sayac mantigi ile calistigi icin 
--sayac en son hangi sayida kaldiysa ordan devam eder.
-- not postgreSQL de tansaction kullanimi icin 'begin' komutuyla baslariz. sonrasinda tekrar yanlis bir veriyi 
--duzeltmek veya bizim icin onemli olan verilerden sonra ekleme yapabilmek icin 'savepoint isim' kullaniriz
--bu savepoint'e donmek icin 'rollback to isim' komutu kullaniriz. rollback calistirildiginda savepoint 
--yazdigimiz satirin ustundeki verileri tabloda bize verir.son olarak transactionu sonlandirmak icin
--'commit' komutu kullanilir. MySQL'de transaction omadanda kullanilir.

--DML-DELETE
--DELETE FROM TABLO_ADI--> TABLONUN TUM ICERIGINI SILER
-- veriyi secerek silmek icin where kosulu kullanilir.
--delete from tablo_adi where sutun_adi=ver--> tablodaki istedigimiz veriyi siler.

create table ogrenciler
(id int,
isim varchar(50),
veli_isim varchar(50),
yazili_notu int);
insert into ogrenciler values (123, 'Ali Can','Hasan',75);
insert into ogrenciler values (124, 'Merve Gul','Ayse',85);
insert into ogrenciler values (125, 'Kemal Yasa','Huseyin',85);
insert into ogrenciler values (126, 'Nesibe Yilmaz','Fatma',95);
insert into ogrenciler values (127, 'Mustafa Bak','Can',99);
insert into ogrenciler values (127, 'Mustafa Bak','Ali',99);

select*from ogrenciler;

--ID SI M124 OLAN OGRENCIYI SILIN
DELETE from ogrenciler where id=124;

--SORU ISIMI KEMAL YASA OLAN SATIRI SILINIZ
delete from ogrenciler where isim='Kemal Yasa';

--soru ismi nesibe yilmaz veya mustafa bak lan kayitlari silelim
delete from ogrenciler where isim='Nesibe Yilmaz' or isim='Mustafa Bak';

select*from ogrenciler;

-- soru ismi alican ve id'si 123 olan kaydi silin.
delete from ogrenciler where isim='Ali Can' or id=124;
delete from ogrenciler;

--DELETE -TRUNCATE--
--TRUNCATE KOMUTU DELETE KOMUTU GIBI TABLODAKI TUMVERILERI SILER
--ANCAK SECMELI SILME YAPMAZ

truncate table ogrenciler;

--DDL - DATA DEFIBITION LANG.
--CREATE -- ALTER -- DROP
--ALTER TABLE tabloda add, type, set, rename ve drop columns islemleri icin kullanilir.
--personel cinsiyet varchar(20) ve yas int seklinde yeni sutunlar ekeleyelim

select*from personel;

alter table personel add cinsiyet varchar(20), add yas int;

--personel tablosundan sirket field'ini silin
alter table personel drop column sirket;

--personel tablosundaki sehir adini ulke oalrak degistirin
alter table personel rename column sehir to ulke;

--personel tablosunun adini isciler olarak degistirin
alter table personel rename to isciler;
select*from isciler;

--DDL - DROP-
DROP table isciler;

--CONSTRANINT-- KISITLAMALAR 
--PRIMARY KEY-- BIR SUTUNUN NULL ICERMEMESINI VE SUTUNDAKI VERILERI BENZERSIZ OLAMSINI SAGLAR (NOT NULL, UNIQUE)
--FOREIGN KEY -- BASKA BIR TABLODAKI PRIMARY KEY'I REFERANS GOSTERMEK ICIN KULLANILIR
-- BOYLELIKLE TABLOLAR ARASINDA ILISKIKURULMUS OLUR
--UNIQUE --> BIR SUTUNDAKI TUM DEGERLERIN BENZERSIZ YANI TEK OLMASINI SAGLAR
--NOT NULL BIR SUTUNUN NULL ICERMEMESINI YANI BOS OLMAMASINI SAGLAR
--NOT NULL KISITLAMASI ICIN CONSTRAINT ISMI TANIMLANMAZ. BU KISITLAMA VERI TURUNDN HEMEN SONRA YERELESTIRILIR.
--CHECK--> BIR SUTUNA YERLESTIRILEBILECEK DEGER ARALIGINI SINIRLAMAK ICIN KULLANILIR.

CREATE TABLE calisanlar(
id char(5) primary key,--not null + unique
isim varchar(50) unique,
maas int not null,
ise_baslama date);

/*CREATE TABLE calisanlar2(
id char(5),
isim varchar(50),
maas int not null,
ise_baslama date,
constraint pk_id primary key(id),
constraint isim_unq unique (isim));
*/

select*from calisanlar;
delete from calisanlar;

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yilmaz',12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yilmaz', 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY

select*from calisanlar;

--FOREIGN KEY--

create table adresler(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30), 
sehir varchar(20),
constraint id_fk foreign key (adres_id) references calisanlar(id) 
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;



