-- Group [Group]
create table "public"."group" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- User [User]
create table "public"."user" (
   "oid"  int4  not null,
   "username"  varchar(255),
   "password"  varchar(255),
   "email"  varchar(255),
   "descripcion_usuario"  varchar(255),
   "edad"  int4,
   "es_hombre"  bool,
   "fecha_alta"  timestamp,
   "foto_perfil"  varchar(255),
   "telefono"  varchar(255),
   "es_activo"  bool,
  primary key ("oid")
);


-- Reserva [ent2]
create table "public"."reserva" (
   "oid"  int4  not null,
   "hora_inicio"  timestamp,
   "estado_reserva"  int4,
   "precio"  float8,
  primary key ("oid")
);


-- Torneo [ent3]
create table "public"."torneo" (
   "oid"  int4  not null,
   "numero_plazas"  int4,
   "fecha_inicio"  timestamp,
   "nombre_torneo"  varchar(255),
   "descripcion_torneo"  varchar(255),
   "fecha_fin"  timestamp,
   "premio"  float8,
   "precio_inscripcion"  float8,
  primary key ("oid")
);


-- Pista [ent4]
create table "public"."pista" (
   "oid"  int4  not null,
   "nombre_pista"  varchar(255),
   "deporte_asociado"  varchar(255),
   "hora_apertura"  timestamp,
   "hora_cierre"  timestamp,
   "capacidad"  int4,
   "es_disponible"  bool,
   "ubicacion"  varchar(255),
   "foto_pista"  varchar(255),
  primary key ("oid")
);


-- Incidencia [ent5]
create table "public"."incidencia" (
   "oid"  int4  not null,
   "descripcion"  varchar(255),
   "titulo"  varchar(255),
   "nivel_gravedad"  int4,
   "estado_incidencia"  int4,
  primary key ("oid")
);


-- Valoracion [ent6]
create table "public"."valoracion" (
   "oid"  int4  not null,
   "descripcion_valoracion"  varchar(255),
   "puntuacion"  int4,
   "fecha_valoracion"  timestamp,
  primary key ("oid")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  add column  "module_oid"  int4;


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module" (
   "group_oid"  int4 not null,
   "module_oid"  int4 not null,
  primary key ("group_oid", "module_oid")
);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;


-- User_Group [User2Group_Group2User]
create table "public"."user_group" (
   "user_oid"  int4 not null,
   "group_oid"  int4 not null,
  primary key ("user_oid", "group_oid")
);


-- se refiere a [rel10]
alter table "public"."reserva"  add column  "pista_oid"  int4;


-- Incidencia_Reserva [rel11]
alter table "public"."reserva"  add column  "incidencia_oid"  int4;


-- Valoracion_Pista [rel12]
alter table "public"."valoracion"  add column  "pista_oid"  int4;


-- organiza [rel13]
alter table "public"."torneo"  add column  "user_oid"  int4;


-- gestiona [rel14]
alter table "public"."pista"  add column  "user_oid"  int4;


-- User_Incidencia [rel17]
alter table "public"."incidencia"  add column  "user_oid"  int4;


-- User_User [rel18]
alter table "public"."user"  add column  "user_oid"  int4;


-- guarda_como_fav [rel2]
create table "public"."guarda_como_fav" (
   "pista_oid"  int4 not null,
   "user_oid"  int4 not null,
  primary key ("pista_oid", "user_oid")
);


-- reporta [rel3]
alter table "public"."incidencia"  add column  "user_oid_2"  int4;


-- participa [rel4]
create table "public"."participa" (
   "user_oid"  int4 not null,
   "torneo_oid"  int4 not null,
  primary key ("user_oid", "torneo_oid")
);


-- realiza [rel7]
alter table "public"."reserva"  add column  "user_oid"  int4;


-- escribe [rel8]
alter table "public"."valoracion"  add column  "user_oid_2"  int4;


-- se juega en [rel9]
alter table "public"."torneo"  add column  "pista_oid"  int4;


-- ==========================================
-- LIMPIAR DATOS
-- ==========================================
TRUNCATE TABLE "participa" CASCADE;
TRUNCATE TABLE "guarda_como_fav" CASCADE;
TRUNCATE TABLE "valoracion" CASCADE;
TRUNCATE TABLE "reserva" CASCADE;
TRUNCATE TABLE "incidencia" CASCADE;
TRUNCATE TABLE "torneo" CASCADE;
TRUNCATE TABLE "pista" CASCADE;
TRUNCATE TABLE "user" CASCADE;
TRUNCATE TABLE "group" CASCADE;
TRUNCATE TABLE "module" CASCADE;

-- ==========================================
-- DATOS BASE
-- ==========================================

INSERT INTO "module" (oid, moduleid, modulename) VALUES
(1, 'sv4', 'ZonaAdmin'),
(2, 'sv3', 'ZonaGerente'),
(3, 'sv2', 'ZonaCliente');

INSERT INTO "group" (oid, groupname, module_oid) VALUES
(1, 'admin', 1),
(2, 'gerente', 2),
(3, 'cliente', 3);

-- ==========================================
-- USUARIOS
-- ==========================================

INSERT INTO "user" (oid, username, password, email, descripcion_usuario, edad, es_hombre, fecha_alta, telefono, es_activo, group_oid) VALUES
(1, 'admin', 'admin', 'admin@pistea.com', 'Administrador del sistema', 35, true, '2025-01-01 00:00:00', '600000000', true, 1),
(2, 'gerente1', 'gerente1', 'gerente1@pistea.com', 'Gerente principal', 40, true, '2025-01-15 00:00:00', '600000001', true, 2),
(3, 'gerente2', 'gerente2', 'gerente2@pistea.com', 'Gerente secundario', 38, false, '2025-01-20 00:00:00', '600000002', true, 2),
(4, 'carlos_tenis', 'carlos', 'carlos@pistea.com', 'Apasionado del tenis, nivel intermedio', 28, true, '2025-02-01 00:00:00', '600333444', true, 3),
(5, 'laura99', 'laura', 'laura@pistea.com', 'Jugadora amateur de pádel, busco pareja para torneos', 25, false, '2025-02-10 00:00:00', '600111222', true, 3),
(6, 'pedro_futbol', 'pedro', 'pedro@pistea.com', 'Futbolero de toda la vida', 32, true, '2025-02-15 00:00:00', '600777888', true, 3),
(7, 'ana_sport', 'ana', 'ana@pistea.com', 'Me gustan todos los deportes', 22, false, '2025-03-01 00:00:00', '600999000', true, 3),
(8, 'maria_padel', 'maria', 'maria@pistea.com', 'Jugadora de pádel nivel avanzado', 29, false, '2025-03-05 00:00:00', '600555666', true, 3),
(9, 'juan_inactivo', 'juan', 'juan@pistea.com', 'Usuario desactivado por comportamiento inapropiado', 45, true, '2025-01-05 00:00:00', '600111333', false, 3),
(10, 'sofia_baja', 'sofia', 'sofia@pistea.com', 'Cuenta dada de baja a petición propia', 31, false, '2025-01-10 00:00:00', '600222444', false, 3);

-- ==========================================
-- PISTAS
-- ==========================================

INSERT INTO "pista" (oid, nombre_pista, deporte_asociado, hora_apertura, hora_cierre, capacidad, es_disponible, ubicacion, user_oid) VALUES
(1, 'Pista Central Pádel', 'Pádel', '2026-01-01 08:00:00', '2026-01-01 23:00:00', 4, true, 'Pabellón Norte', 2),
(2, 'Pista Tenis Rápida', 'Tenis', '2026-01-01 07:00:00', '2026-01-01 22:00:00', 2, true, 'Pabellón Sur', 2),
(3, 'Campo Fútbol 7', 'Fútbol', '2026-01-01 09:00:00', '2026-01-01 21:00:00', 14, true, 'Zona Exterior', 3),
(4, 'Pista Pádel Exterior', 'Pádel', '2026-01-01 08:00:00', '2026-01-01 20:00:00', 4, true, 'Zona Exterior', 3),
(5, 'Pista Tenis Tierra', 'Tenis', '2026-01-01 08:00:00', '2026-01-01 21:00:00', 2, false, 'Pabellón Sur', 2),
(6, 'Campo Fútbol 11', 'Fútbol', '2026-01-01 10:00:00', '2026-01-01 22:00:00', 22, true, 'Zona Exterior', 3);

-- ==========================================
-- TORNEOS
-- ==========================================

INSERT INTO "torneo" (oid, nombre_torneo, descripcion_torneo, fecha_inicio, fecha_fin, numero_plazas, premio, precio_inscripcion, pista_oid, user_oid) VALUES
(1, 'Torneo Primavera Pádel', 'Torneo amateur por parejas', '2026-04-01 09:00:00', '2026-04-15 20:00:00', 16, 500.00, 10.00, 1, 2),
(2, 'Open Tenis Individual', 'Torneo individual categoría B', '2026-04-10 09:00:00', '2026-04-20 20:00:00', 8, 300.00, 15.00, 2, 2),
(3, 'Liga Fútbol 7', 'Liga regular temporada 2026', '2026-05-01 10:00:00', '2026-06-30 20:00:00', 56, 1000.00, 20.00, 3, 3);

-- ==========================================
-- INCIDENCIAS
-- ==========================================

INSERT INTO "incidencia" (oid, descripcion, titulo, nivel_gravedad, estado_incidencia, user_oid_2, user_oid) VALUES
(1, 'La red de la pista central está rota por varios puntos', 'Red rota pista central', 2, 1, 4, 2),
(2, 'Uno de los focos parpadea constantemente', 'Fallo iluminación', 1, 0, 5, 2),
(3, 'El suelo está en mal estado cerca de la línea de servicio', 'Suelo peligroso', 3, 0, 6, 3),
(4, 'La ducha del vestuario masculino no tiene agua caliente', 'Sin agua caliente vestuario', 1, 2, 7, 3);

-- ==========================================
-- RESERVAS (con incidencias asociadas)
-- ==========================================

INSERT INTO "reserva" (oid, hora_inicio, estado_reserva, precio, pista_oid, user_oid, incidencia_oid) VALUES
(1, '2026-03-15 18:00:00', 1, 12.50, 1, 4, 1),
(2, '2026-03-16 19:30:00', 1, 10.00, 3, 5, 2),
(3, '2026-03-20 10:00:00', 2, 0.00, 5, 7, 3),
(4, '2026-03-22 17:00:00', 1, 12.50, 1, 6, 4),
(5, '2026-03-23 19:00:00', 1, 10.00, 3, 8, NULL),
(6, '2026-03-25 11:00:00', 0, 15.00, 6, 4, NULL);

-- ==========================================
-- VALORACIONES
-- ==========================================

INSERT INTO "valoracion" (oid, descripcion_valoracion, puntuacion, fecha_valoracion, pista_oid, user_oid_2) VALUES
(1, 'La pista está en muy buen estado, el cristal rebota perfecto.', 5, '2026-03-05 20:00:00', 1, 4),
(2, 'Buenas instalaciones pero vestuarios algo pequeños.', 4, '2026-03-06 18:00:00', 3, 5),
(3, 'Pista muy bien mantenida, vestuarios limpios.', 4, '2026-03-07 18:00:00', 1, 6),
(4, 'El campo necesita mantenimiento urgente.', 2, '2026-03-08 10:00:00', 6, 7),
(5, 'Muy buena pista, la recomiendo.', 5, '2026-03-09 12:00:00', 2, 8);

-- ==========================================
-- PARTICIPACIONES
-- ==========================================

INSERT INTO "participa" (user_oid, torneo_oid) VALUES
(4, 1),
(5, 1),
(6, 1),
(7, 2),
(8, 2),
(4, 3),
(6, 3);

-- ==========================================
-- FAVORITOS
-- ==========================================

INSERT INTO "guarda_como_fav" (user_oid, pista_oid) VALUES
(4, 1),
(4, 3),
(5, 2),
(6, 1),
(7, 3),
(8, 2);

-- ==========================================
-- FOREIGN KEYS
-- ==========================================

-- Borrar pista → borra torneos, reservas, valoraciones, favoritos
ALTER TABLE "torneo" ADD CONSTRAINT fk_torneo_pista 
FOREIGN KEY (pista_oid) REFERENCES "pista"(oid) ON DELETE CASCADE;

ALTER TABLE "reserva" ADD CONSTRAINT fk_reserva_pista 
FOREIGN KEY (pista_oid) REFERENCES "pista"(oid) ON DELETE CASCADE;

ALTER TABLE "valoracion" ADD CONSTRAINT fk_valoracion_pista 
FOREIGN KEY (pista_oid) REFERENCES "pista"(oid) ON DELETE CASCADE;

ALTER TABLE "guarda_como_fav" ADD CONSTRAINT fk_fav_pista 
FOREIGN KEY (pista_oid) REFERENCES "pista"(oid) ON DELETE CASCADE;

-- Borrar torneo → borra participaciones
ALTER TABLE "participa" ADD CONSTRAINT fk_participa_torneo 
FOREIGN KEY (torneo_oid) REFERENCES "torneo"(oid) ON DELETE CASCADE;

-- Borrar usuario → borra reservas, valoraciones, favoritos, participaciones
ALTER TABLE "reserva" ADD CONSTRAINT fk_reserva_user 
FOREIGN KEY (user_oid) REFERENCES "user"(oid) ON DELETE CASCADE;

ALTER TABLE "valoracion" ADD CONSTRAINT fk_valoracion_user 
FOREIGN KEY (user_oid_2) REFERENCES "user"(oid) ON DELETE CASCADE;

ALTER TABLE "guarda_como_fav" ADD CONSTRAINT fk_fav_user 
FOREIGN KEY (user_oid) REFERENCES "user"(oid) ON DELETE CASCADE;

ALTER TABLE "participa" ADD CONSTRAINT fk_participa_user 
FOREIGN KEY (user_oid) REFERENCES "user"(oid) ON DELETE CASCADE;

-- Borrar incidencia → reserva se mantiene con incidencia_oid = null
ALTER TABLE "reserva" ADD CONSTRAINT fk_reserva_incidencia 
FOREIGN KEY (incidencia_oid) REFERENCES "incidencia"(oid) ON DELETE SET NULL;

-- Borrar usuario que reportó → incidencia se borra
-- Borrar usuario que gestiona → incidencia se mantiene con user_oid = null
ALTER TABLE "incidencia" ADD CONSTRAINT fk_incidencia_reporta 
FOREIGN KEY (user_oid_2) REFERENCES "user"(oid) ON DELETE CASCADE;

ALTER TABLE "incidencia" ADD CONSTRAINT fk_incidencia_gestiona 
FOREIGN KEY (user_oid) REFERENCES "user"(oid) ON DELETE SET NULL;
