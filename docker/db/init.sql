-- Script de inicialização do banco de dados PostgreSQL
-- Mapas Culturais Base Project

-- Configura encoding e locale
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

-- Cria extensões necessárias
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Configura timezone
SET timezone = 'America/Sao_Paulo';

-- Configura parâmetros de performance
ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';
ALTER SYSTEM SET log_statement = 'all';
ALTER SYSTEM SET log_min_duration_statement = 1000;

-- Cria índices para melhor performance
-- Estes serão criados pelo Mapas Culturais na primeira execução

-- Configura permissões
GRANT ALL PRIVILEGES ON DATABASE mapas TO mapas;
GRANT ALL PRIVILEGES ON SCHEMA public TO mapas;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO mapas;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO mapas;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO mapas;

-- Mensagem de conclusão
\echo 'Database initialization completed for Mapas Culturais';