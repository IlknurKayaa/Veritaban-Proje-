--
-- PostgreSQL database dump
--

-- Dumped from database version 12.8
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: kayitEkle1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."kayitEkle1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."kod" = UPPER(NEW."kod"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."uadi" = UPPER(NEW."uadi"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."renk" = UPPER(NEW."renk"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."uadi" = LTRIM(NEW."uadi"); -- Önceki ve sonraki boşlukları temizle
    IF NEW."kod" IS NULL THEN
            RAISE EXCEPTION 'Sehir alanı boş olamaz';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."kayitEkle1"() OWNER TO postgres;

--
-- Name: toplamkazanc(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamkazanc() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    update toplamlar set ortalamakazanc=ortalamakazanc+NEW."tutar";
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.toplamkazanc() OWNER TO postgres;

--
-- Name: toplamstok(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamstok() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."kod" = UPPER(NEW."kod"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."uadi" = UPPER(NEW."uadi"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."renk" = UPPER(NEW."renk"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."uadi" = LTRIM(NEW."uadi"); -- Önceki ve sonraki boşlukları temizle
    update toplamlar set toplamstok=toplamstok+ New."stok";
    IF NEW."kod" IS NULL THEN
            RAISE EXCEPTION 'Sehir alanı boş olamaz';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.toplamstok() OWNER TO postgres;

--
-- Name: toplamurun(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamurun() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."kod" = UPPER(NEW."kod"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."uadi" = UPPER(NEW."uadi"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."renk" = UPPER(NEW."renk"); -- büyük harfe dönüştürdükten sonra ekle
    NEW."uadi" = LTRIM(NEW."uadi"); -- Önceki ve sonraki boşlukları temizle
    update toplamlar set toplamurun=toplamurun+1;
    IF NEW."kod" IS NULL THEN
            RAISE EXCEPTION 'Sehir alanı boş olamaz';  
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.toplamurun() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bolge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bolge (
    "BolgeNo" integer NOT NULL,
    "BolgeAdi" character(25) NOT NULL
);


ALTER TABLE public.bolge OWNER TO postgres;

--
-- Name: fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fatura (
    fatkod character varying(3) NOT NULL,
    fattarih date DEFAULT '2021-12-16'::date
);


ALTER TABLE public.fatura OWNER TO postgres;

--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    "Ilcekodu" integer NOT NULL,
    "IlceAdi" character(25) NOT NULL,
    "IlKodu" integer NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: iletisim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iletisim (
    "No" integer NOT NULL,
    "Adres" character varying(100) NOT NULL,
    "Mail" character(75) NOT NULL,
    "Telefon" character(15) NOT NULL,
    "ilceKodu" integer NOT NULL,
    "kisiNo" integer NOT NULL
);


ALTER TABLE public.iletisim OWNER TO postgres;

--
-- Name: iletisim_No_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."iletisim_No_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."iletisim_No_seq" OWNER TO postgres;

--
-- Name: iletisim_No_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."iletisim_No_seq" OWNED BY public.iletisim."No";


--
-- Name: iller; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iller (
    ilkodu integer NOT NULL,
    "Adi" character(15) NOT NULL,
    bolgeno integer NOT NULL
);


ALTER TABLE public.iller OWNER TO postgres;

--
-- Name: kargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kargo (
    "KargoKodu" integer NOT NULL,
    "KAdi" character(30) NOT NULL,
    "Adres" character(70) NOT NULL
);


ALTER TABLE public.kargo OWNER TO postgres;

--
-- Name: kategori1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori1 (
    tip1 character(1) NOT NULL
);


ALTER TABLE public.kategori1 OWNER TO postgres;

--
-- Name: kategori2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori2 (
    tip2 character(10) NOT NULL
);


ALTER TABLE public.kategori2 OWNER TO postgres;

--
-- Name: kısı; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."kısı" (
    "kısıkodu" integer NOT NULL,
    ad character varying(30) NOT NULL,
    soyad character varying(30) NOT NULL,
    "kısıtipi" character(1) NOT NULL
);


ALTER TABLE public."kısı" OWNER TO postgres;

--
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    "kısıkodu" integer NOT NULL,
    kimlikno character(11) NOT NULL,
    il integer NOT NULL
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    "kısıkodu" integer NOT NULL,
    kimlikno character(11) NOT NULL,
    bolge integer NOT NULL
);


ALTER TABLE public.personel OWNER TO postgres;

--
-- Name: siparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siparis (
    "siparisNo" character varying(5) NOT NULL,
    tarih date DEFAULT '2021-12-16'::date,
    tutar double precision NOT NULL,
    karkod integer NOT NULL,
    muskod integer NOT NULL,
    perkod integer NOT NULL,
    fkod character varying(3) NOT NULL
);


ALTER TABLE public.siparis OWNER TO postgres;

--
-- Name: siparisUrun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."siparisUrun" (
    "SUno" integer NOT NULL,
    birimfiyat double precision NOT NULL,
    miktar integer NOT NULL,
    sipno character varying(5) NOT NULL,
    urunkod character varying(4) NOT NULL
);


ALTER TABLE public."siparisUrun" OWNER TO postgres;

--
-- Name: tedarikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tedarikci (
    "kısıkodu" integer NOT NULL,
    sirket character(50) NOT NULL,
    alimtarih date DEFAULT '2021-12-16'::date
);


ALTER TABLE public.tedarikci OWNER TO postgres;

--
-- Name: toplamlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplamlar (
    toplamstok integer NOT NULL,
    toplamurun integer NOT NULL,
    toplamkazanc double precision
);


ALTER TABLE public.toplamlar OWNER TO postgres;

--
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    kod character varying(4) NOT NULL,
    uadi character(10) NOT NULL,
    renk character(10) NOT NULL,
    beden character(1) NOT NULL,
    "kumaş" character(10),
    stok integer NOT NULL,
    birim double precision NOT NULL,
    kat1 character(1) NOT NULL,
    kat2 character(10) NOT NULL
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- Name: iletisim No; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim ALTER COLUMN "No" SET DEFAULT nextval('public."iletisim_No_seq"'::regclass);


--
-- Data for Name: bolge; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bolge VALUES
	(1, 'MARMARA                  '),
	(2, 'EGE                      '),
	(3, 'İÇ ANADOLU               '),
	(4, 'KARADENİZ                '),
	(5, 'DOĞU ANADOLU             '),
	(6, 'AKDENİZ                  '),
	(7, 'GÜNEY DOĞU ANADOLU       ');


--
-- Data for Name: fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fatura VALUES
	('1', '2021-12-14');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce VALUES
	(1, 'SEYHAN                   ', 1),
	(2, 'ADIYAMAN MERKEZ          ', 2),
	(3, 'AFYON MERKEZ             ', 3),
	(4, 'AKSARAY MERKEZ           ', 68),
	(5, 'AMASYA MERKEZ            ', 5),
	(6, 'ALTINDAĞ                 ', 6),
	(7, 'ALANYA                   ', 7),
	(8, 'ARDAHAN MERKEZ           ', 75),
	(9, 'HOPA                     ', 8),
	(10, 'AYDIN MERKEZ             ', 9),
	(11, 'DOĞUBEYAZIT              ', 4),
	(12, 'AYVALIK                  ', 10),
	(13, 'BARTIN MERKEZ            ', 74),
	(14, 'BATMAN MERKEZ            ', 72),
	(15, 'BAYBURT MERKEZ           ', 69),
	(16, 'GEREDE                   ', 14),
	(17, 'BUCAK                    ', 15),
	(18, 'GEMLİK                   ', 16),
	(19, 'BÖZÜYÜK                  ', 11),
	(20, 'KARLIOVA                 ', 12),
	(21, 'AHLAT                    ', 13),
	(22, 'ACIPAYAM                 ', 20),
	(23, 'DÜZCE MERKEZ             ', 81),
	(24, 'HAZRO                    ', 21),
	(25, 'HAVSA                    ', 22),
	(26, 'KEBAN                    ', 23),
	(27, 'PALANDÖKEN               ', 25),
	(28, 'TERCAN                   ', 24),
	(29, 'SARICAKAYA               ', 26),
	(30, 'YAVUZELİ                 ', 27),
	(31, 'TORUL                    ', 29),
	(32, 'BULANCAK                 ', 28),
	(33, 'YÜKSEKOVA                ', 30),
	(34, 'HASSA                    ', 31),
	(35, 'ATABEY                   ', 32),
	(36, 'ARALIK                   ', 76),
	(37, 'KARAKOYUNLU              ', 46),
	(38, 'OVACIK                   ', 78),
	(39, 'AYRANCI                  ', 70),
	(40, 'SUSUZ                    ', 36),
	(41, 'ABANA                    ', 37),
	(42, 'PINARBAŞI                ', 38),
	(43, 'KRIKKALE MERKEZ          ', 71),
	(44, 'BABAESKİ                 ', 39),
	(45, 'KAMAN                    ', 40),
	(46, 'KANDIRA                  ', 41),
	(47, 'BOZKIR                   ', 42),
	(48, 'EMET                     ', 43),
	(49, 'POLATELİ                 ', 79),
	(50, 'ARGUVAN                  ', 44),
	(51, 'AKSİHAR                  ', 45),
	(52, 'MARDİN MERKEZ            ', 47),
	(53, 'ANAMUR                   ', 33),
	(54, 'BODRUM                   ', 48),
	(55, 'MALAZGİRT                ', 49),
	(56, 'AVANOS                   ', 50),
	(57, 'BOR                      ', 51),
	(58, 'KUMRU                    ', 52),
	(59, 'OSMANİYE MERKEZ          ', 80),
	(60, 'FINDIKLI                 ', 53),
	(61, 'GEYVE                    ', 54),
	(62, 'HAVZA                    ', 55),
	(63, 'BOYABAT                  ', 57),
	(64, 'KANGAL                   ', 58),
	(65, 'KURTALAN                 ', 56),
	(66, 'SARAY                    ', 59),
	(67, 'TURHAL                   ', 60),
	(68, 'TRABZON MERKEZ           ', 61),
	(69, 'HOZAT                    ', 62),
	(70, 'KARAHALLI                ', 64),
	(71, 'VAN MERKEZ               ', 65),
	(72, 'ALTINOVA                 ', 77),
	(73, 'SARIKAYA                 ', 66),
	(74, 'ALAPLI                   ', 67),
	(75, 'BOZCAADA                 ', 17),
	(76, 'ILGAZ                    ', 18),
	(77, 'OSMANCIK                 ', 19),
	(78, 'ADALAR                   ', 34),
	(79, 'BERGAMA                  ', 35),
	(80, 'BOZOVA                   ', 63),
	(81, 'ULUDERE                  ', 73);


--
-- Data for Name: iletisim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iletisim VALUES
	(1, 'ADANA', 'fsjklne@gmail.com                                                          ', '0556 789 89 89 ', 1, 1);


--
-- Data for Name: iller; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iller VALUES
	(1, 'ADANA          ', 6),
	(2, 'ADIYAMAN       ', 7),
	(3, 'AFYON          ', 2),
	(4, 'AĞRI           ', 5),
	(5, 'AMASYA         ', 4),
	(6, 'ANKARA         ', 3),
	(7, 'ANTALYA        ', 6),
	(8, 'ARTVİN         ', 4),
	(9, 'AYDIN          ', 2),
	(10, 'BALIKESİR      ', 1),
	(11, 'BİLECİK        ', 1),
	(12, 'BİNGÖL         ', 5),
	(13, 'BİTLİS         ', 5),
	(14, 'BOLU           ', 4),
	(15, 'BURDUR         ', 6),
	(16, 'BURSA          ', 1),
	(17, 'ÇANAKKALE      ', 1),
	(18, 'ÇANKIRI        ', 3),
	(19, 'ÇORUM          ', 4),
	(20, 'DENİZLİ        ', 2),
	(21, 'DİYARBAKIR     ', 7),
	(22, 'EDİRNE         ', 1),
	(23, 'ELAZIĞ         ', 5),
	(24, 'ERZİNCAN       ', 5),
	(25, 'ERZURUM        ', 5),
	(26, 'ESKİŞEHİR      ', 3),
	(27, 'GAZİANTEP      ', 7),
	(28, 'GİRESUN        ', 4),
	(29, 'GÜMÜŞHANE      ', 4),
	(30, 'HAKKARİ        ', 7),
	(31, 'HATAY          ', 6),
	(32, 'ISPARTA        ', 6),
	(33, 'MERSİN         ', 6),
	(34, 'İSTANBUL       ', 1),
	(35, 'İZMİR          ', 2),
	(36, 'KARS           ', 5),
	(37, 'KASTAMONU      ', 4),
	(38, 'KAYSERİ        ', 3),
	(39, 'KIRKLARELİ     ', 1),
	(40, 'KIRŞEHİR       ', 3),
	(41, 'KOCAELİ        ', 1),
	(42, 'KONYA          ', 3),
	(43, 'KÜTAHYA        ', 2),
	(44, 'MALATYA        ', 5),
	(45, 'MANİSA         ', 2),
	(46, 'KAHRAMANMARAŞ  ', 6),
	(47, 'MARDİN         ', 7),
	(48, 'MUĞLA          ', 2),
	(49, 'MUŞ            ', 5),
	(50, 'NEVŞEHİR       ', 3),
	(51, 'NİĞDE          ', 3),
	(52, 'ORDU           ', 4),
	(53, 'RİZE           ', 4),
	(54, 'SAKARYA        ', 1),
	(55, 'SAMSUN         ', 4),
	(56, 'SİİRT          ', 7),
	(57, 'SİNOP          ', 4),
	(58, 'SİVAS          ', 3),
	(59, 'TEKİRDAĞ       ', 1),
	(60, 'TOKAT          ', 4),
	(61, 'TRABZON        ', 4),
	(62, 'TUNCELİ        ', 5),
	(63, 'ŞANLIURFA      ', 7),
	(64, 'UŞAK           ', 2),
	(65, 'VAN            ', 5),
	(66, 'YOZGAT         ', 3),
	(67, 'ZONGULDAK      ', 4),
	(68, 'AKSARAY        ', 3),
	(69, 'BAYBURT        ', 4),
	(70, 'KARAMAN        ', 3),
	(71, 'KIRIKKALE      ', 3),
	(72, 'BATMAN         ', 7),
	(73, 'ŞIRNAK         ', 7),
	(74, 'BARTIN         ', 4),
	(75, 'ARDAHAN        ', 5),
	(76, 'IĞDIR          ', 5),
	(77, 'YALOVA         ', 1),
	(78, 'KARABÜK        ', 4),
	(79, 'KİLİS          ', 7),
	(80, 'OSMANİYE       ', 6),
	(81, 'DÜZCE          ', 4);


--
-- Data for Name: kargo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kargo VALUES
	(5, 'Kargo1                        ', 'İSTANBUL                                                              ');


--
-- Data for Name: kategori1; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategori1 VALUES
	('E'),
	('K'),
	('U');


--
-- Data for Name: kategori2; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategori2 VALUES
	('Dış Giyim '),
	('Takı      '),
	('Çanta     '),
	('Aksesuar  ');


--
-- Data for Name: kısı; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."kısı" VALUES
	(2, 'Emir', 'Dağ', 'P'),
	(1, 'Ayşe', 'Dur', 'M'),
	(3, 'Ali', 'AAA', 'T');


--
-- Data for Name: musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.musteri VALUES
	(1, '12345678901', 34);


--
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.personel VALUES
	(2, '23456789011', 1);


--
-- Data for Name: siparis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.siparis VALUES
	('1', '2021-12-12', 99.9, 5, 1, 2, '1');


--
-- Data for Name: siparisUrun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."siparisUrun" VALUES
	(1, 99.9, 1, '1', 'HGFT');


--
-- Data for Name: tedarikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tedarikci VALUES
	(3, 'ABC                                               ', '2021-12-12');


--
-- Data for Name: toplamlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.toplamlar VALUES
	(58, 8, 189.8);


--
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.urun VALUES
	('ENHJ', 'SWEAT     ', 'KIRMIZI   ', 'S', 'Pamuk     ', 5, 89.9, 'U', 'Dış Giyim '),
	('ENHT', 'HIRKA     ', 'KIRMIZI   ', 'S', 'Pamuk     ', 5, 99.9, 'U', 'Dış Giyim '),
	('ENUT', 'CEKET     ', 'KIRMIZI   ', 'S', 'Pamuk     ', 5, 79.9, 'U', 'Dış Giyim '),
	('ELŞT', 'ÇANTA     ', 'SİYAH     ', ' ', 'Deri      ', 10, 99.9, 'K', 'Çanta     '),
	('HGFT', 'ÇANTA     ', 'SİYAH     ', ' ', 'Deri      ', 5, 99.9, 'E', 'Çanta     '),
	('SDLM', 'TİŞÖRT    ', 'MAVI      ', 'M', 'İpek      ', 8, 60, 'E', 'Dış Giyim ');


--
-- Name: iletisim_No_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."iletisim_No_seq"', 1, true);


--
-- Name: bolge BolgePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bolge
    ADD CONSTRAINT "BolgePK" PRIMARY KEY ("BolgeNo");


--
-- Name: fatura FaturaPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fatura
    ADD CONSTRAINT "FaturaPK" PRIMARY KEY (fatkod);


--
-- Name: iller IlPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iller
    ADD CONSTRAINT "IlPK" PRIMARY KEY (ilkodu);


--
-- Name: iller IlUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iller
    ADD CONSTRAINT "IlUnique" UNIQUE ("Adi");


--
-- Name: ilce IlcePK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT "IlcePK" PRIMARY KEY ("Ilcekodu");


--
-- Name: iletisim IletisimPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT "IletisimPK" PRIMARY KEY ("No");


--
-- Name: kargo KargoPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kargo
    ADD CONSTRAINT "KargoPK" PRIMARY KEY ("KargoKodu");


--
-- Name: kategori1 Kategori1PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori1
    ADD CONSTRAINT "Kategori1PK" PRIMARY KEY (tip1);


--
-- Name: kategori2 Kategori2PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori2
    ADD CONSTRAINT "Kategori2PK" PRIMARY KEY (tip2);


--
-- Name: kısı KısıPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."kısı"
    ADD CONSTRAINT "KısıPK" PRIMARY KEY ("kısıkodu");


--
-- Name: musteri MusteriPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT "MusteriPK" PRIMARY KEY ("kısıkodu");


--
-- Name: musteri MusteriUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT "MusteriUnique" UNIQUE (kimlikno);


--
-- Name: personel PersonelPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT "PersonelPK" PRIMARY KEY ("kısıkodu");


--
-- Name: personel PersonelUnique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT "PersonelUnique" UNIQUE (kimlikno);


--
-- Name: siparis SiparisPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT "SiparisPK" PRIMARY KEY ("siparisNo");


--
-- Name: tedarikci TedarikciPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT "TedarikciPK" PRIMARY KEY ("kısıkodu");


--
-- Name: urun UrunPK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "UrunPK" PRIMARY KEY (kod);


--
-- Name: urun kayitKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "kayitKontrol" BEFORE INSERT OR UPDATE ON public.urun FOR EACH ROW EXECUTE FUNCTION public."kayitEkle1"();


--
-- Name: siparis kazancKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "kazancKontrol" AFTER INSERT ON public.siparis FOR EACH ROW EXECUTE FUNCTION public.toplamkazanc();


--
-- Name: urun stokKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "stokKontrol" BEFORE INSERT OR UPDATE ON public.urun FOR EACH ROW EXECUTE FUNCTION public.toplamstok();


--
-- Name: urun urunKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunKontrol" BEFORE INSERT OR UPDATE ON public.urun FOR EACH ROW EXECUTE FUNCTION public.toplamurun();


--
-- Name: iller IlFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iller
    ADD CONSTRAINT "IlFK1" FOREIGN KEY (bolgeno) REFERENCES public.bolge("BolgeNo");


--
-- Name: ilce IlceFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT "IlceFK1" FOREIGN KEY ("IlKodu") REFERENCES public.iller(ilkodu);


--
-- Name: iletisim IletisimFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT "IletisimFK1" FOREIGN KEY ("ilceKodu") REFERENCES public.ilce("Ilcekodu");


--
-- Name: iletisim IletisimFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT "IletisimFK2" FOREIGN KEY ("kisiNo") REFERENCES public."kısı"("kısıkodu");


--
-- Name: musteri MusteriFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT "MusteriFK1" FOREIGN KEY (il) REFERENCES public.iller(ilkodu);


--
-- Name: musteri MusteriKisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT "MusteriKisi" FOREIGN KEY ("kısıkodu") REFERENCES public."kısı"("kısıkodu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel PersonelKisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT "PersonelKisi" FOREIGN KEY ("kısıkodu") REFERENCES public."kısı"("kısıkodu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personel PesonelFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personel
    ADD CONSTRAINT "PesonelFK1" FOREIGN KEY (bolge) REFERENCES public.bolge("BolgeNo");


--
-- Name: siparis SiparisFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT "SiparisFK1" FOREIGN KEY (karkod) REFERENCES public.kargo("KargoKodu");


--
-- Name: siparis SiparisFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT "SiparisFK2" FOREIGN KEY (muskod) REFERENCES public.musteri("kısıkodu");


--
-- Name: siparis SiparisFK3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT "SiparisFK3" FOREIGN KEY (perkod) REFERENCES public.personel("kısıkodu");


--
-- Name: siparis SiparisFK4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparis
    ADD CONSTRAINT "SiparisFK4" FOREIGN KEY (fkod) REFERENCES public.fatura(fatkod);


--
-- Name: siparisUrun SiparisUrunFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."siparisUrun"
    ADD CONSTRAINT "SiparisUrunFK1" FOREIGN KEY (sipno) REFERENCES public.siparis("siparisNo");


--
-- Name: siparisUrun SiparisUrunFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."siparisUrun"
    ADD CONSTRAINT "SiparisUrunFK2" FOREIGN KEY (urunkod) REFERENCES public.urun(kod);


--
-- Name: tedarikci TedarikciKisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tedarikci
    ADD CONSTRAINT "TedarikciKisi" FOREIGN KEY ("kısıkodu") REFERENCES public."kısı"("kısıkodu") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: urun UrunFK1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "UrunFK1" FOREIGN KEY (kat2) REFERENCES public.kategori2(tip2);


--
-- Name: urun UrunFK2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT "UrunFK2" FOREIGN KEY (kat1) REFERENCES public.kategori1(tip1);


--
-- PostgreSQL database dump complete
--

