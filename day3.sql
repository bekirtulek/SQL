CREATE TABLE calisanlar(
id char(5) primary key,--not null + unique
isim varchar(50) unique,
maas int not null,
ise_baslama date
);

--2.yol
/*
CREATE TABLE calisanlar2(
id char(5),
isim varchar(50),
maas int not null,
ise_baslama date,
constraint pk_id primary key(id),
constraint isim_unq unique (isim));
*/
select*from calisanlar;

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yilmaz',12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yilmaz', 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY

select*from calisanlar;

--FOREIGN KEY--

create table adresler(
adres_id char(5) ,-- foreign key data turunden sonra yazilmaz
sokak varchar(20),
cadde varchar(30), 
sehir varchar(20),
constraint id_fk foreign key (adres_id) references calisanlar(id) 
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- parent tabloda olmayan id ile child tabloya ekleme yapamayiz

INSERT INTO adresler VALUES(null,'Ağa Sok', '30.Cad.','Antep');

select*from calisanlar, adresler where calisanlar.id=adresler.adres_id;
--eslesenleri parent table'dan child table'a eslesenleri getirir

drop table calisanlar;
--primary key olan parent tabloyu direkt olarak silemeyiz
--once child table'yu silmemiz gerekir.

delete from calisanlar where id='10002'; --parent'da oldugu icin direkt silinmez once child'dan silmeliyiz

delete from adresler where adres_id ='10002'; --child oldugu icin silindi

-- ON DELETE CASCADE--
/*
her defeasinda once child tablodaki verileri silmek yerine 
ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz.
bunun icin  FK olan satirin en sonunda ON DELETE CASCADE eklememiz yeterli*/

CREATE TABLE talebeler(
id CHAR(3) primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar( 
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90); 

select * from talebeler
select * from notlar

delete from notlar where talebe_id='123';

delete from talebeler where id='126';
--on delete cascade kullandigimiz icin parent table'dan direkt silebildik
--parent table'dan sildigimiz icin child table'dan da silinmis olur.0
delete from talebeler;-- parent tabloyu sildigimizde child tabloyuda silmis oluruz

drop table talebeler cascade; --parenttabloyu kaldrimak istersek cascade eklememiz gerekir
-- parent tablo kaldirilir fakat child tabloyu kaldrimaz

alter table talebeler
alter column isim type varchar(30),
alter column isim set not null;

select * from talebeler
select * from notlar

--talebeler tablosundaki yazili notunu sutununa 60 'dan buyuk rakam gitrilebilsin

alter table talebeler
add constraint sinir check (yazili_notu>60);
-- chechk kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz
--yukarida 60'i sinir olarak belirledigimiz icin bunu eklemedi
INSERT INTO talebeler VALUES(128, 'Mustafa Can', 'Hasan', 49);

create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);
Create table ogr_adres
AS
SELECT id, adres from ogrenciler;

select*from ogrenciler;
select *from ogr_adres;

--tablodaki bir sutunu primary key ekleme
alter table ogrenciler 
add primary key (id);

--primary key olusturmada 2. yol
alter table ogrenciler 
add constraint pk_id primary key(id);

--foreign key atamasi 

alter table ogr_adres
add foreign key (id) references ogrenciler;
--child tabloyu parent tablodan olusturdugumjuz icin sutun adi vermedik.

--FK'yi constraint'i silme 
alter table ogr_adres drop constraint ogr_adres_id_fkey;

--FK'yi constraint'i silme 
alter table ogrenciler drop constraint pk_id;

--yazili notu  85 den buyuk olan talebe bilgilerini getirin

select*from talebeler where yazili_notu>85;

--ismi mustafa bak olan talebenin tum bilgilerini getirin
select * from talebeler where isim='Mustafa Bak';

--SELECT KOMUTUNDA BETWEEN KOSULU
--between belirttiginiz 2 veri arasindaki bilgiler listeler
--between de belirttigimiz degerlerde listelemeye dahildir.
create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);
/*
	AND (VE)= belirtilen sartlarin her ikiside gerceklesiyorsa o kayit listelenir
bir tanesi  gerceklesmezse listelenmez

	select*from matematik sinavi > 50 AND sinav2 >50
	hem sinav hemde sinav2 alani 50'den buyu olan kayitlari listeler
	
	OR (VEYA)=belirtilen sartlardan biri gerceklesirse kayit listelenir
		select*from matematik sinavi > 50 OR sinav2 >50
		sinav1 veya sinav2'den bir alan 50'den buyukse kayit listelenir 
*/

select*from personel;

--id'si 1003 ile 1005 arasinda olan personel bilgilerini listeleyiniz
select*from personel where id BETWEEN '1003' and '1005';
--2. yol
select*from personel where id>='1003' and id<='1005'

--derya soylu ile yavuz bal arasindaki personel bilgilerini lsteleyiniz
select *from personel where isim between 'Derya Soylu' And 'Yavuz Bal';
-- alfabetik olarak siralandigi icin derya D harfi ile Yavuz Y harfi arasindakileri listeler

--maasi 70000 veya ismi sena olan personeli listele
select *from personel where maas=70000 or isim='Sena Beyaz';

--IN : ayni sutundabirden fazla mantiksal ifade ile tanimlayabilcegimiz durumlari 
--		tek komutta yazabilme imkani verir
	-- farkli sutunlar icin kullanilamaz
	
	--id'si 1001, 1002 e 1004 ola personelin bilgisini listele
	
select *from personel where id ='1001' or id='1002' or id='1004';
--2.yol in ile
select *from personel where id in ('1001','1002','1004');

--maasi sadece 70000, 100000 olan personeli listele
select *from personel where maas in (70000,100000);
/*
SELECT-LIKE KOSULU
LIKE: sorgulama yaparken belirli kalip ifadeleri kullanabilmemizi saglar
ILIKE: sorgulama yaparken buyuk/kucuk harfe duyarsiz olarak eslestirir
LIKE; ~~
ILIKE: ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/
--ismi A harfi ile baslaayan personeli listele
select * from personel where isim like 'A%';

--ismi T harfi ile biten personeli listele
select * from personel where isim like '%t';

--isminin 2. harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';


