-- Création de la structure de la table
CREATE TABLE Eco2mix_Regional (
    code_insee_region VARCHAR,
    region VARCHAR,
    nature VARCHAR,
    date_releve DATE,
    heure TIME,
    date_heure TIMESTAMP WITH TIME ZONE,
    consommation NUMERIC,
    thermique NUMERIC,
    nucleaire NUMERIC,
    eolien NUMERIC,
    solaire NUMERIC,
    hydraulique NUMERIC,
    pompage NUMERIC,
    bioenergies NUMERIC
);

-- Décompression et Ingestion massive à la volée !
COPY Eco2mix_Regional FROM PROGRAM 'zcat /workspace/eco2mix.csv.gz' DELIMITER ';' CSV HEADER;
