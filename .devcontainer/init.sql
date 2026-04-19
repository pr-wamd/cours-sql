#!/bin/bash
set -e

echo "🌍 Téléchargement des données ..."
wget -O /tmp/eco2mix.csv.gz "https://github.com/pr-wamd/cours-sql/releases/download/v1.0/eco2mix-regional-cons-def.csv.zip.gz"

echo "🏗️ Injection dans PostgreSQL..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

    CREATE TABLE Eco2mix_Regional ( ... );
    
    COPY Eco2mix_Regional FROM PROGRAM 'zcat /tmp/eco2mix.csv.gz' DELIMITER ';' CSV HEADER;

EOSQL
