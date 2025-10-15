-- Criação do banco e tabelas
CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100) UNIQUE NOT NULL,
  senha_hash TEXT NOT NULL,
  role VARCHAR(20) DEFAULT 'fiscal'
);

CREATE TABLE sectors (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  geom geometry(POLYGON, 4326)
);

CREATE TABLE shifts (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  start_ts TIMESTAMP DEFAULT NOW(),
  end_ts TIMESTAMP,
  geom_inicio geometry(Point, 4326),
  geom_fim geometry(Point, 4326)
);

CREATE TABLE checkins (
  id SERIAL PRIMARY KEY,
  shift_id INT REFERENCES shifts(id),
  sector_id INT REFERENCES sectors(id),
  ts TIMESTAMP DEFAULT NOW(),
  geom geometry(Point, 4326),
  method VARCHAR(20),
  note TEXT,
  valid_flag BOOLEAN DEFAULT TRUE
);

CREATE TABLE reports (
  id SERIAL PRIMARY KEY,
  date DATE DEFAULT CURRENT_DATE,
  user_id INT REFERENCES users(id),
  km NUMERIC,
  setores_visitados INT
);
