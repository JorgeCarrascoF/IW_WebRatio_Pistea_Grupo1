-- =========================================================
-- PISTEA - SCRIPT UNIFICADO DE BASE DE DATOS
-- =========================================================
-- Motor: PostgreSQL
-- Base de datos: Pistea
-- Usuario: admin
-- Contrasena: admin
-- Host: localhost
-- Puerto: 5432
--
-- Ejecucion sugerida:
-- psql -U admin -d Pistea -f DBScripts/PisteaDB_Actualizado.sql
--
-- Este script recrea el esquema completo y carga datos de prueba.
-- =========================================================

BEGIN;

DROP TABLE IF EXISTS "user_group" CASCADE;
DROP TABLE IF EXISTS "group_module" CASCADE;
DROP TABLE IF EXISTS "participa" CASCADE;
DROP TABLE IF EXISTS "guarda_como_fav" CASCADE;
DROP TABLE IF EXISTS "valoracion" CASCADE;
DROP TABLE IF EXISTS "reserva" CASCADE;
DROP TABLE IF EXISTS "incidencia" CASCADE;
DROP TABLE IF EXISTS "torneo" CASCADE;
DROP TABLE IF EXISTS "pista" CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS "group" CASCADE;
DROP TABLE IF EXISTS "module" CASCADE;

CREATE TABLE "module" (
  "oid" int4 NOT NULL,
  "moduleid" varchar(255),
  "modulename" varchar(255),
  PRIMARY KEY ("oid")
);

CREATE TABLE "group" (
  "oid" int4 NOT NULL,
  "groupname" varchar(255),
  "module_oid" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_group_module FOREIGN KEY ("module_oid") REFERENCES "module" ("oid") ON DELETE SET NULL
);

CREATE TABLE "user" (
  "oid" int4 NOT NULL,
  "username" varchar(255),
  "password" varchar(255),
  "email" varchar(255),
  "descripcion_usuario" varchar(255),
  "edad" int4,
  "es_hombre" bool,
  "fecha_alta" timestamp,
  "foto_perfil" varchar(255),
  "telefono" varchar(255),
  "es_activo" bool,
  "group_oid" int4,
  "user_oid" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_user_group FOREIGN KEY ("group_oid") REFERENCES "group" ("oid") ON DELETE SET NULL,
  CONSTRAINT fk_user_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE SET NULL
);

CREATE TABLE "pista" (
  "oid" int4 NOT NULL,
  "nombre_pista" varchar(255),
  "deporte_asociado" varchar(255),
  "hora_apertura" timestamp,
  "hora_cierre" timestamp,
  "capacidad" int4,
  "es_disponible" bool,
  "ubicacion" varchar(255),
  "foto_pista" varchar(255),
  "user_oid" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_pista_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE SET NULL
);

CREATE TABLE "torneo" (
  "oid" int4 NOT NULL,
  "numero_plazas" int4,
  "fecha_inicio" timestamp,
  "nombre_torneo" varchar(255),
  "descripcion_torneo" varchar(255),
  "fecha_fin" timestamp,
  "premio" float8,
  "precio_inscripcion" float8,
  "pista_oid" int4,
  "user_oid" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_torneo_pista FOREIGN KEY ("pista_oid") REFERENCES "pista" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_torneo_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE SET NULL
);

CREATE TABLE "incidencia" (
  "oid" int4 NOT NULL,
  "descripcion" varchar(255),
  "titulo" varchar(255),
  "nivel_gravedad" int4,
  "estado_incidencia" int4,
  "user_oid_2" int4,
  "user_oid" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_incidencia_user FOREIGN KEY ("user_oid_2") REFERENCES "user" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_incidencia_user_2 FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE SET NULL
);

CREATE TABLE "reserva" (
  "oid" int4 NOT NULL,
  "hora_inicio" timestamp,
  "estado_reserva" int4,
  "precio" float8,
  "pista_oid" int4,
  "user_oid" int4,
  "incidencia_oid" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_reserva_pista FOREIGN KEY ("pista_oid") REFERENCES "pista" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_reserva_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_reserva_incidencia FOREIGN KEY ("incidencia_oid") REFERENCES "incidencia" ("oid") ON DELETE SET NULL
);

CREATE TABLE "valoracion" (
  "oid" int4 NOT NULL,
  "descripcion_valoracion" varchar(255),
  "puntuacion" int4,
  "fecha_valoracion" timestamp,
  "pista_oid" int4,
  "user_oid_2" int4,
  PRIMARY KEY ("oid"),
  CONSTRAINT fk_valoracion_pista FOREIGN KEY ("pista_oid") REFERENCES "pista" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_valoracion_user FOREIGN KEY ("user_oid_2") REFERENCES "user" ("oid") ON DELETE CASCADE
);

CREATE TABLE "group_module" (
  "group_oid" int4 NOT NULL,
  "module_oid" int4 NOT NULL,
  PRIMARY KEY ("group_oid", "module_oid"),
  CONSTRAINT fk_group_module_group FOREIGN KEY ("group_oid") REFERENCES "group" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_group_module_module FOREIGN KEY ("module_oid") REFERENCES "module" ("oid") ON DELETE CASCADE
);

CREATE TABLE "user_group" (
  "user_oid" int4 NOT NULL,
  "group_oid" int4 NOT NULL,
  PRIMARY KEY ("user_oid", "group_oid"),
  CONSTRAINT fk_user_group_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_user_group_group FOREIGN KEY ("group_oid") REFERENCES "group" ("oid") ON DELETE CASCADE
);

CREATE TABLE "participa" (
  "user_oid" int4 NOT NULL,
  "torneo_oid" int4 NOT NULL,
  PRIMARY KEY ("user_oid", "torneo_oid"),
  CONSTRAINT fk_participa_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_participa_torneo FOREIGN KEY ("torneo_oid") REFERENCES "torneo" ("oid") ON DELETE CASCADE
);

CREATE TABLE "guarda_como_fav" (
  "pista_oid" int4 NOT NULL,
  "user_oid" int4 NOT NULL,
  PRIMARY KEY ("pista_oid", "user_oid"),
  CONSTRAINT fk_fav_pista FOREIGN KEY ("pista_oid") REFERENCES "pista" ("oid") ON DELETE CASCADE,
  CONSTRAINT fk_fav_user FOREIGN KEY ("user_oid") REFERENCES "user" ("oid") ON DELETE CASCADE
);

INSERT INTO "module" ("oid", "moduleid", "modulename") VALUES
  (1, 'sv4', 'ZonaAdmin'),
  (2, 'sv3', 'ZonaGerente'),
  (3, 'sv2', 'ZonaCliente');

INSERT INTO "group" ("oid", "groupname", "module_oid") VALUES
  (1, 'admin', 1),
  (2, 'gerente', 2),
  (3, 'cliente', 3);

INSERT INTO "group_module" ("group_oid", "module_oid") VALUES
  (1, 1),
  (2, 2),
  (3, 3);

INSERT INTO "user" (
  "oid", "username", "password", "email", "descripcion_usuario", "edad",
  "es_hombre", "fecha_alta", "foto_perfil", "telefono", "es_activo", "group_oid"
) VALUES
  (1, 'admin', 'admin', 'admin@pistea.com', 'Administrador del sistema', 35, true,  '2025-01-01 00:00:00', 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&q=80', '600000000', true,  1),
  (2, 'gerente1', 'gerente1', 'gerente1@pistea.com', 'Gerente principal', 40, true,  '2025-01-15 00:00:00', 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=400&q=80', '600000001', true,  2),
  (3, 'gerente2', 'gerente2', 'gerente2@pistea.com', 'Gerente secundario', 38, false, '2025-01-20 00:00:00', 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&q=80', '600000002', true,  2),
  (4, 'carlos_tenis', 'carlos', 'carlos@pistea.com', 'Apasionado del tenis, nivel intermedio', 28, true,  '2025-02-01 00:00:00', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80', '600333444', true,  3),
  (5, 'laura99', 'laura', 'laura@pistea.com', 'Jugadora amateur de padel, busco pareja para torneos', 25, false, '2025-02-10 00:00:00', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&q=80', '600111222', true,  3),
  (6, 'pedro_futbol', 'pedro', 'pedro@pistea.com', 'Futbolero de toda la vida', 32, true,  '2025-02-15 00:00:00', 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&q=80', '600777888', true,  3),
  (7, 'ana_sport', 'ana', 'ana@pistea.com', 'Me gustan todos los deportes', 22, false, '2025-03-01 00:00:00', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400&q=80', '600999000', true,  3),
  (8, 'maria_padel', 'maria', 'maria@pistea.com', 'Jugadora de padel nivel avanzado', 29, false, '2025-03-05 00:00:00', 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400&q=80', '600555666', true,  3),
  (9, 'juan_inactivo', 'juan', 'juan@pistea.com', 'Usuario desactivado por comportamiento inapropiado', 45, true,  '2025-01-05 00:00:00', 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&q=80', '600111333', false, 3),
  (10, 'sofia_baja', 'sofia', 'sofia@pistea.com', 'Cuenta dada de baja a peticion propia', 31, false, '2025-01-10 00:00:00', 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=400&q=80', '600222444', false, 3);

INSERT INTO "user_group" ("user_oid", "group_oid") VALUES
  (1, 1),
  (2, 2),
  (3, 2),
  (4, 3),
  (5, 3),
  (6, 3),
  (7, 3),
  (8, 3),
  (9, 3),
  (10, 3);

INSERT INTO "pista" (
  "oid", "nombre_pista", "deporte_asociado", "hora_apertura", "hora_cierre",
  "capacidad", "es_disponible", "ubicacion", "foto_pista", "user_oid"
) VALUES
  (1, 'Pista Central Padel',  'Padel',  '2026-01-01 08:00:00', '2026-01-01 23:00:00', 4,  true,  'Pabellon Norte', 'https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=800&q=80', 2),
  (2, 'Pista Tenis Rapida',   'Tenis',  '2026-01-01 07:00:00', '2026-01-01 22:00:00', 2,  true,  'Pabellon Sur',   'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?w=800&q=80', 2),
  (3, 'Campo Futbol 7',       'Futbol', '2026-01-01 09:00:00', '2026-01-01 21:00:00', 14, true,  'Zona Exterior',  'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?w=800&q=80', 3),
  (4, 'Pista Padel Exterior', 'Padel',  '2026-01-01 08:00:00', '2026-01-01 20:00:00', 4,  true,  'Zona Exterior',  'https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?w=800&q=80', 3),
  (5, 'Pista Tenis Tierra',   'Tenis',  '2026-01-01 08:00:00', '2026-01-01 21:00:00', 2,  false, 'Pabellon Sur',   'https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?w=800&q=80', 2),
  (6, 'Campo Futbol 11',      'Futbol', '2026-01-01 10:00:00', '2026-01-01 22:00:00', 22, true,  'Zona Exterior',  'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=800&q=80', 3);

INSERT INTO "torneo" (
  "oid", "nombre_torneo", "descripcion_torneo", "fecha_inicio", "fecha_fin",
  "numero_plazas", "premio", "precio_inscripcion", "pista_oid", "user_oid"
) VALUES
  (1, 'Torneo Primavera Padel', 'Torneo amateur por parejas', '2026-04-01 09:00:00', '2026-04-15 20:00:00', 16, 500.00, 10.00, 1, 2),
  (2, 'Open Tenis Individual',  'Torneo individual categoria B', '2026-04-10 09:00:00', '2026-04-20 20:00:00', 8, 300.00, 15.00, 2, 2),
  (3, 'Liga Futbol 7',          'Liga regular temporada 2026', '2026-05-01 10:00:00', '2026-06-30 20:00:00', 56, 1000.00, 20.00, 3, 3);

INSERT INTO "incidencia" (
  "oid", "descripcion", "titulo", "nivel_gravedad", "estado_incidencia", "user_oid_2", "user_oid"
) VALUES
  (1, 'La red de la pista central esta rota por varios puntos', 'Red rota pista central', 2, 1, 4, 2),
  (2, 'Uno de los focos parpadea constantemente', 'Fallo iluminacion', 1, 0, 5, 2),
  (3, 'El suelo esta en mal estado cerca de la linea de servicio', 'Suelo peligroso', 3, 0, 6, 3),
  (4, 'La ducha del vestuario masculino no tiene agua caliente', 'Sin agua caliente vestuario', 1, 2, 7, 3);

INSERT INTO "reserva" (
  "oid", "hora_inicio", "estado_reserva", "precio", "pista_oid", "user_oid", "incidencia_oid"
) VALUES
  (1, '2026-03-15 18:00:00', 1, 12.50, 1, 4, 1),
  (2, '2026-03-16 19:30:00', 1, 10.00, 3, 5, 2),
  (3, '2026-03-20 10:00:00', 2, 0.00,  5, 7, 3),
  (4, '2026-03-22 17:00:00', 1, 12.50, 1, 6, 4),
  (5, '2026-03-23 19:00:00', 1, 10.00, 3, 8, NULL),
  (6, '2026-03-25 11:00:00', 0, 15.00, 6, 4, NULL);

INSERT INTO "valoracion" (
  "oid", "descripcion_valoracion", "puntuacion", "fecha_valoracion", "pista_oid", "user_oid_2"
) VALUES
  (1, 'La pista esta en muy buen estado, el cristal rebota perfecto.', 5, '2026-03-05 20:00:00', 1, 4),
  (2, 'Buenas instalaciones pero vestuarios algo pequenos.', 4, '2026-03-06 18:00:00', 3, 5),
  (3, 'Pista muy bien mantenida, vestuarios limpios.', 4, '2026-03-07 18:00:00', 1, 6),
  (4, 'El campo necesita mantenimiento urgente.', 2, '2026-03-08 10:00:00', 6, 7),
  (5, 'Muy buena pista, la recomiendo.', 5, '2026-03-09 12:00:00', 2, 8);

INSERT INTO "participa" ("user_oid", "torneo_oid") VALUES
  (4, 1),
  (5, 1),
  (6, 1),
  (7, 2),
  (8, 2),
  (4, 3),
  (6, 3);

INSERT INTO "guarda_como_fav" ("pista_oid", "user_oid") VALUES
  (1, 4),
  (3, 4),
  (2, 5),
  (1, 6),
  (3, 7),
  (2, 8);

COMMIT;
