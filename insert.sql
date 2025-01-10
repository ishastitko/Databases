-- Clear existing data while maintaining referential integrity
TRUNCATE TABLE hodnoceni, platba, rezervace, osobni_trenink, vybaveni, prostor, 
         skupinova_lekce, clen, trener, zamestnanec, osoba CASCADE;

-- Reset sequences
ALTER SEQUENCE osoba_osobni_cislo_seq RESTART WITH 1;
ALTER SEQUENCE clen_clen_id_seq RESTART WITH 1;
ALTER SEQUENCE trener_trener_id_seq RESTART WITH 1;
ALTER SEQUENCE zamestnanec_zam_id_seq RESTART WITH 1;
ALTER SEQUENCE skupinova_lekce_lekce_id_seq RESTART WITH 1;
ALTER SEQUENCE prostor_prostor_id_seq RESTART WITH 1;
ALTER SEQUENCE osobni_trenink_trenink_id_seq RESTART WITH 1;
ALTER SEQUENCE rezervace_rezervace_id_seq RESTART WITH 1;
ALTER SEQUENCE platba_platba_id_seq RESTART WITH 1;
ALTER SEQUENCE hodnoceni_hodnoceni_id_seq RESTART WITH 1;

-- Insert base personal data
INSERT INTO osoba (osobni_cislo, jmeno, prijmeni, datum_narozeni, bankovni_ucet) VALUES
-- Trenéři (1-5)
(1, 'Jan', 'Novák', '1990-05-15', 'CZ6550123456789012345678'),
(2, 'Marie', 'Svobodová', '1988-08-22', 'CZ6550234567890123456789'),
(3, 'Petr', 'Dvořák', '1985-03-10', 'CZ6550345678901234567890'),
(4, 'Eva', 'Černá', '1992-11-28', 'CZ6550456789012345678901'),
(5, 'Tomáš', 'Procházka', '1987-07-14', 'CZ6550567890123456789012'),
-- Zaměstnanci (6-10)
(6, 'Lucie', 'Kučerová', '1995-01-30', 'CZ6550678901234567890123'),
(7, 'Pavel', 'Veselý', '1993-09-17', 'CZ6550789012345678901234'),
(8, 'Jana', 'Horáková', '1991-04-25', 'CZ6550890123456789012345'),
(9, 'Martin', 'Král', '1989-12-03', 'CZ6550901234567890123456'),
(10, 'Tereza', 'Němcová', '1994-06-20', 'CZ6550012345678901234567'),
-- Členové (11-20)
(11, 'Michal', 'Pospíšil', '1986-02-14', 'CZ6550123456789012345689'),
(12, 'Veronika', 'Marková', '1993-07-08', 'CZ6550234567890123456790'),
(13, 'David', 'Urban', '1990-11-30', 'CZ6550345678901234567891'),
(14, 'Kristýna', 'Kovářová', '1988-04-17', 'CZ6550456789012345678902'),
(15, 'Filip', 'Krejčí', '1995-09-22', 'CZ6550567890123456789013');

-- Insert trainers
INSERT INTO trener (trener_id, osobni_cislo, specializace, rozvrh) VALUES
(1, 1, 'Silový trénink', ARRAY['2025-01-06', '2025-01-07', '2025-01-08', '2025-01-09', '2025-01-10']::DATE[]),
(2, 2, 'Jóga a pilates', ARRAY['2025-01-06', '2025-01-07', '2025-01-08', '2025-01-09', '2025-01-10']::DATE[]),
(3, 3, 'CrossFit', ARRAY['2025-01-06', '2025-01-07', '2025-01-08', '2025-01-09', '2025-01-10']::DATE[]),
(4, 4, 'Kardio trénink', ARRAY['2025-01-06', '2025-01-07', '2025-01-08', '2025-01-09', '2025-01-10']::DATE[]),
(5, 5, 'Funkční trénink', ARRAY['2025-01-06', '2025-01-07', '2025-01-08', '2025-01-09', '2025-01-10']::DATE[]);

-- Insert employees
INSERT INTO zamestnanec (zam_id, osobni_cislo, rozvrh) VALUES
(1, 6, ARRAY['2025-01-06', '2025-01-07', '2025-01-08']::DATE[]),
(2, 7, ARRAY['2025-01-07', '2025-01-08', '2025-01-09']::DATE[]),
(3, 8, ARRAY['2025-01-08', '2025-01-09', '2025-01-10']::DATE[]),
(4, 9, ARRAY['2025-01-09', '2025-01-10', '2025-01-11']::DATE[]),
(5, 10, ARRAY['2025-01-10', '2025-01-11', '2025-01-12']::DATE[]);

-- Insert members
INSERT INTO clen (clen_id, osobni_cislo, typ_clenstvi, preference) VALUES
(1, 11, 'Týdenní', 'Silový trénink'),
(2, 12, 'Měsiční', 'Jóga'),
(3, 13, 'Roční', 'CrossFit'),
(4, 14, 'Měsiční', 'Kardio'),
(5, 15, 'Týdenní', 'Funkční trénink');

-- Insert group classes
INSERT INTO skupinova_lekce (lekce_id, trener_id, osobni_cislo, nazev, datum, kapacita) VALUES
(1, 1, 1, 'Silový trénink pro začátečníky', '2025-01-06 10:00:00', 12),
(2, 2, 2, 'Ranní jóga', '2025-01-06 08:00:00', 15),
(3, 3, 3, 'CrossFit WOD', '2025-01-06 17:00:00', 10),
(4, 4, 4, 'Kardio HIIT', '2025-01-06 18:30:00', 20),
(5, 5, 5, 'Funkční trénink', '2025-01-06 16:00:00', 15);

-- Insert spaces for classes
INSERT INTO prostor (prostor_id, lekce_id, nazev, kapacita) VALUES
(1, 1, 'Posilovna - Zóna 1', 15),
(2, 2, 'Jógový sál', 20),
(3, 3, 'CrossFit box', 12),
(4, 4, 'Kardio zóna', 25),
(5, 5, 'Funkční zóna', 18);

-- Insert equipment for classes
INSERT INTO vybaveni (lekce_id, nazev) VALUES
(1, 'Činky'),
(2, 'Jógamatky'),
(3, 'Švihadla'),
(4, 'Činky');

-- Insert personal training sessions
INSERT INTO osobni_trenink (trenink_id, clen_id, osobni_cislo, trener_id, trener_osobni_cislo, datum) VALUES
(1, 1, 11, 1, 1, '2025-01-06 09:00:00'),
(2, 2, 12, 2, 2, '2025-01-06 11:00:00'),
(3, 3, 13, 3, 3, '2025-01-06 14:00:00'),
(4, 4, 14, 4, 4, '2025-01-06 14:00:00'),
(5, 5, 15, 5, 5, '2025-01-06 17:00:00');

-- Insert reservations
INSERT INTO rezervace (rezervace_id, clen_id, osobni_cislo, lekce_id, datum, stav) VALUES
(1, 1, 11, 1, '2025-01-06 10:00:00', 'Potvrzeno'),
(6, 1, 11, 2, '2025-01-06 08:00:00', 'Potvrzeno'),
(7, 1, 11, 3, '2025-01-06 17:00:00', 'Potvrzeno'),
(8, 1, 11, 4, '2025-01-06 18:30:00', 'Potvrzeno'),
(9, 1, 11, 5, '2025-01-06 16:00:00', 'Potvrzeno'),
(5, 1, 11, 2, '2025-01-06 08:00:00', 'Potvrzeno'),
(2, 2, 12, 2, '2025-01-06 08:00:00', 'Potvrzeno'),
(3, 3, 13, 3, '2025-01-06 17:00:00', 'Čeká na potvrzení'),
(4, 4, 14, 4, '2025-01-06 18:30:00', 'Potvrzeno');

-- Insert payments
INSERT INTO platba (platba_id, clen_id, osobni_cislo, datum, castka) VALUES
(1, 1, 11, '2025-01-01', 800),
(2, 2, 12, '2025-01-01', 1500),
(3, 3, 13, '2025-01-01', 2500),
(4, 4, 14, '2024-12-01', 800),
(5, 5, 15, '2024-12-01', 1500);

-- Insert ratings
INSERT INTO hodnoceni (hodnoceni_id, trenink_id, clen_id, osobni_cislo, trener_id, trener_osobni_cislo, lekce_id, datum, komentar, hodnoceni) VALUES
(1, 1, 1, 11, 1, 1, 1, '2025-01-06', 'Skvělý trénink, perfektní přístup trenéra', 5),
(2, 2, 2, 12, 2, 2, 2, '2025-01-06', 'Příjemná atmosféra a profesionální vedení', 5),
(3, 3, 3, 13, 3, 3, 3, '2025-01-06', 'Náročné, ale efektivní', 4),
(5, 5, 5, 15, 5, 5, 5, '2025-01-06', 'Komplexní trénink, skvělé cviky', 4);