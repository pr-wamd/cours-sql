#!/bin/bash
set -e

# 1
echo "🌍 Téléchargement des données réelles..."
wget -O /tmp/eco2mix.csv.gz "https://github.com/pr-wamd/cours-sql/releases/download/v1.0/eco2mix-regional-cons-def.csv.zip.gz"

# 2
echo "🏗️ Création de la table et injection..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
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

    COPY Eco2mix_Regional FROM PROGRAM 'zcat /tmp/eco2mix.csv.gz' DELIMITER ';' CSV HEADER;
EOSQL

echo "✅ Base de données prête !"
