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
alter table "public"."group"   add constraint fk_group_module foreign key ("module_oid") references "public"."module" ("oid");


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module" (
   "group_oid"  int4 not null,
   "module_oid"  int4 not null,
  primary key ("group_oid", "module_oid")
);
alter table "public"."group_module"   add constraint fk_group_module_group foreign key ("group_oid") references "public"."group" ("oid");
alter table "public"."group_module"   add constraint fk_group_module_module foreign key ("module_oid") references "public"."module" ("oid");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;
alter table "public"."user"   add constraint fk_user_group foreign key ("group_oid") references "public"."group" ("oid");


-- User_Group [User2Group_Group2User]
create table "public"."user_group" (
   "user_oid"  int4 not null,
   "group_oid"  int4 not null,
  primary key ("user_oid", "group_oid")
);
alter table "public"."user_group"   add constraint fk_user_group_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."user_group"   add constraint fk_user_group_group foreign key ("group_oid") references "public"."group" ("oid");


-- se refiere a [rel10]
alter table "public"."reserva"  add column  "pista_oid"  int4;
alter table "public"."reserva"   add constraint fk_reserva_pista foreign key ("pista_oid") references "public"."pista" ("oid");


-- Incidencia_Reserva [rel11]
alter table "public"."reserva"  add column  "incidencia_oid"  int4;
alter table "public"."reserva"   add constraint fk_reserva_incidencia foreign key ("incidencia_oid") references "public"."incidencia" ("oid");


-- Valoracion_Pista [rel12]
alter table "public"."valoracion"  add column  "pista_oid"  int4;
alter table "public"."valoracion"   add constraint fk_valoracion_pista foreign key ("pista_oid") references "public"."pista" ("oid");


-- organiza [rel13]
alter table "public"."torneo"  add column  "user_oid"  int4;
alter table "public"."torneo"   add constraint fk_torneo_user foreign key ("user_oid") references "public"."user" ("oid");


-- gestiona [rel14]
alter table "public"."pista"  add column  "user_oid"  int4;
alter table "public"."pista"   add constraint fk_pista_user foreign key ("user_oid") references "public"."user" ("oid");


-- User_Incidencia [rel17]
alter table "public"."incidencia"  add column  "user_oid"  int4;
alter table "public"."incidencia"   add constraint fk_incidencia_user foreign key ("user_oid") references "public"."user" ("oid");


-- User_User [rel18]
alter table "public"."user"  add column  "user_oid"  int4;
alter table "public"."user"   add constraint fk_user_user foreign key ("user_oid") references "public"."user" ("oid");


-- reporta [rel3]
alter table "public"."incidencia"  add column  "user_oid_2"  int4;
alter table "public"."incidencia"   add constraint fk_incidencia_user_2 foreign key ("user_oid_2") references "public"."user" ("oid");


-- participa [rel4]
create table "public"."participa" (
   "user_oid"  int4 not null,
   "torneo_oid"  int4 not null,
  primary key ("user_oid", "torneo_oid")
);
alter table "public"."participa"   add constraint fk_participa_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."participa"   add constraint fk_participa_torneo foreign key ("torneo_oid") references "public"."torneo" ("oid");


-- guarda como fav [rel6]
create table "public"."guarda_como_fav" (
   "user_oid"  int4 not null,
   "pista_oid"  int4 not null,
  primary key ("user_oid", "pista_oid")
);
alter table "public"."guarda_como_fav"   add constraint fk_guarda_como_fav_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."guarda_como_fav"   add constraint fk_guarda_como_fav_pista foreign key ("pista_oid") references "public"."pista" ("oid");


-- realiza [rel7]
alter table "public"."reserva"  add column  "user_oid"  int4;
alter table "public"."reserva"   add constraint fk_reserva_user foreign key ("user_oid") references "public"."user" ("oid");


-- escribe [rel8]
alter table "public"."valoracion"  add column  "user_oid_2"  int4;
alter table "public"."valoracion"   add constraint fk_valoracion_user foreign key ("user_oid_2") references "public"."user" ("oid");


-- se juega en [rel9]
alter table "public"."torneo"  add column  "pista_oid"  int4;
alter table "public"."torneo"   add constraint fk_torneo_pista foreign key ("pista_oid") references "public"."pista" ("oid");


