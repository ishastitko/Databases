-- Remove conflicting tables
DROP TABLE IF EXISTS clen CASCADE;
DROP TABLE IF EXISTS hodnoceni CASCADE;
DROP TABLE IF EXISTS osoba CASCADE;
DROP TABLE IF EXISTS osobni_trenink CASCADE;
DROP TABLE IF EXISTS platba CASCADE;
DROP TABLE IF EXISTS prostor CASCADE;
DROP TABLE IF EXISTS rezervace CASCADE;
DROP TABLE IF EXISTS skupinova_lekce CASCADE;
DROP TABLE IF EXISTS trener CASCADE;
DROP TABLE IF EXISTS vybaveni CASCADE;
DROP TABLE IF EXISTS zamestnanec CASCADE;
-- End of removing

CREATE TABLE clen (
    clen_id SERIAL NOT NULL,
    osobni_cislo SERIAL NOT NULL,
    typ_clenstvi VARCHAR(256) NOT NULL,
    preference VARCHAR(256)
);
ALTER TABLE clen ADD CONSTRAINT pk_clen PRIMARY KEY (clen_id, osobni_cislo);
ALTER TABLE clen ADD CONSTRAINT u_fk_clen_osoba UNIQUE (osobni_cislo);

CREATE TABLE hodnoceni (
    hodnoceni_id SERIAL NOT NULL,
    trenink_id INTEGER NOT NULL,
    clen_id INTEGER NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    trener_id INTEGER NOT NULL,
    trener_osobni_cislo INTEGER NOT NULL,
    lekce_id INTEGER NOT NULL,
    datum DATE NOT NULL,
    komentar VARCHAR(256),
    hodnoceni INTEGER NOT NULL
);
ALTER TABLE hodnoceni ADD CONSTRAINT pk_hodnoceni PRIMARY KEY (hodnoceni_id);

CREATE TABLE osoba (
    osobni_cislo SERIAL NOT NULL,
    jmeno VARCHAR(256) NOT NULL,
    prijmeni VARCHAR(256) NOT NULL,
    datum_narozeni DATE NOT NULL,
    bankovni_ucet VARCHAR(256) NOT NULL
);
ALTER TABLE osoba ADD CONSTRAINT pk_osoba PRIMARY KEY (osobni_cislo);

CREATE TABLE osobni_trenink (
    trenink_id SERIAL NOT NULL,
    clen_id INTEGER NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    trener_id INTEGER NOT NULL,
    trener_osobni_cislo INTEGER NOT NULL,
    datum TIMESTAMP NOT NULL
);
ALTER TABLE osobni_trenink ADD CONSTRAINT pk_osobni_trenink PRIMARY KEY (trenink_id, clen_id, osobni_cislo, trener_id, trener_osobni_cislo);

CREATE TABLE platba (
    platba_id SERIAL NOT NULL,
    clen_id INTEGER NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    datum DATE NOT NULL,
    castka DECIMAL(10, 0) NOT NULL
);
ALTER TABLE platba ADD CONSTRAINT pk_platba PRIMARY KEY (platba_id);

CREATE TABLE prostor (
    prostor_id SERIAL NOT NULL,
    lekce_id INTEGER NOT NULL,
    nazev VARCHAR(256) NOT NULL,
    kapacita INTEGER NOT NULL
);
ALTER TABLE prostor ADD CONSTRAINT pk_prostor PRIMARY KEY (prostor_id);

CREATE TABLE rezervace (
    rezervace_id SERIAL NOT NULL,
    clen_id INTEGER NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    lekce_id INTEGER NOT NULL,
    datum TIMESTAMP NOT NULL,
    stav VARCHAR(256) NOT NULL
);
ALTER TABLE rezervace ADD CONSTRAINT pk_rezervace PRIMARY KEY (rezervace_id, clen_id, osobni_cislo, lekce_id);

CREATE TABLE skupinova_lekce (
    lekce_id SERIAL NOT NULL,
    trener_id INTEGER NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    nazev VARCHAR(256) NOT NULL,
    datum TIMESTAMP NOT NULL,
    kapacita INTEGER NOT NULL
);
ALTER TABLE skupinova_lekce ADD CONSTRAINT pk_skupinova_lekce PRIMARY KEY (lekce_id);

CREATE TABLE trener (
    trener_id SERIAL NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    specializace VARCHAR(256),
    rozvrh DATE[] NOT NULL
);
ALTER TABLE trener ADD CONSTRAINT pk_trener PRIMARY KEY (trener_id, osobni_cislo);
ALTER TABLE trener ADD CONSTRAINT u_fk_trener_osoba UNIQUE (osobni_cislo);

CREATE TABLE vybaveni (
    lekce_id INTEGER NOT NULL,
    nazev VARCHAR(256) NOT NULL
);
ALTER TABLE vybaveni ADD CONSTRAINT pk_vybaveni PRIMARY KEY (lekce_id);

CREATE TABLE zamestnanec (
    zam_id SERIAL NOT NULL,
    osobni_cislo INTEGER NOT NULL,
    rozvrh DATE[] NOT NULL
);
ALTER TABLE zamestnanec ADD CONSTRAINT pk_zamestnanec PRIMARY KEY (zam_id, osobni_cislo);
ALTER TABLE zamestnanec ADD CONSTRAINT u_fk_zamestnanec_osoba UNIQUE (osobni_cislo);

ALTER TABLE clen ADD CONSTRAINT fk_clen_osoba FOREIGN KEY (osobni_cislo) REFERENCES osoba (osobni_cislo) ON DELETE CASCADE;

ALTER TABLE hodnoceni ADD CONSTRAINT fk_hodnoceni_osobni_trenink FOREIGN KEY (trenink_id, clen_id, osobni_cislo, trener_id, trener_osobni_cislo) REFERENCES osobni_trenink (trenink_id, clen_id, osobni_cislo, trener_id, trener_osobni_cislo) ON DELETE CASCADE;
ALTER TABLE hodnoceni ADD CONSTRAINT fk_hodnoceni_skupinova_lekce FOREIGN KEY (lekce_id) REFERENCES skupinova_lekce (lekce_id) ON DELETE CASCADE;

ALTER TABLE osobni_trenink ADD CONSTRAINT fk_osobni_trenink_clen FOREIGN KEY (clen_id, osobni_cislo) REFERENCES clen (clen_id, osobni_cislo) ON DELETE CASCADE;
ALTER TABLE osobni_trenink ADD CONSTRAINT fk_osobni_trenink_trener FOREIGN KEY (trener_id, trener_osobni_cislo) REFERENCES trener (trener_id, osobni_cislo) ON DELETE CASCADE;

ALTER TABLE platba ADD CONSTRAINT fk_platba_clen FOREIGN KEY (clen_id, osobni_cislo) REFERENCES clen (clen_id, osobni_cislo) ON DELETE CASCADE;

ALTER TABLE prostor ADD CONSTRAINT fk_prostor_skupinova_lekce FOREIGN KEY (lekce_id) REFERENCES skupinova_lekce (lekce_id) ON DELETE CASCADE;

ALTER TABLE rezervace ADD CONSTRAINT fk_rezervace_clen FOREIGN KEY (clen_id, osobni_cislo) REFERENCES clen (clen_id, osobni_cislo) ON DELETE CASCADE;
ALTER TABLE rezervace ADD CONSTRAINT fk_rezervace_skupinova_lekce FOREIGN KEY (lekce_id) REFERENCES skupinova_lekce (lekce_id) ON DELETE CASCADE;

ALTER TABLE skupinova_lekce ADD CONSTRAINT fk_skupinova_lekce_trener FOREIGN KEY (trener_id, osobni_cislo) REFERENCES trener (trener_id, osobni_cislo) ON DELETE CASCADE;

ALTER TABLE trener ADD CONSTRAINT fk_trener_osoba FOREIGN KEY (osobni_cislo) REFERENCES osoba (osobni_cislo) ON DELETE CASCADE;

ALTER TABLE vybaveni ADD CONSTRAINT fk_vybaveni_skupinova_lekce FOREIGN KEY (lekce_id) REFERENCES skupinova_lekce (lekce_id) ON DELETE CASCADE;

ALTER TABLE zamestnanec ADD CONSTRAINT fk_zamestnanec_osoba FOREIGN KEY (osobni_cislo) REFERENCES osoba (osobni_cislo) ON DELETE CASCADE;

