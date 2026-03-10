-- Group [Group]
create table "public"."group_2" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module_2" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- User [User]
create table "public"."user_2" (
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
create table "public"."reserva_2" (
   "oid"  int4  not null,
   "hora_inicio"  timestamp,
   "estado_reserva"  int4,
   "precio"  float8,
  primary key ("oid")
);


-- Torneo [ent3]
create table "public"."torneo_2" (
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
create table "public"."pista_2" (
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
create table "public"."incidencia_2" (
   "oid"  int4  not null,
   "descripcion"  varchar(255),
   "titulo"  varchar(255),
   "nivel_gravedad"  int4,
   "estado_incidencia"  int4,
  primary key ("oid")
);


-- Valoracion [ent6]
create table "public"."valoracion_2" (
   "oid"  int4  not null,
   "descripcion_valoracion"  varchar(255),
   "puntuacion"  int4,
   "fecha_valoracion"  timestamp,
  primary key ("oid")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group_2"  add column  "module_2_oid"  int4;
alter table "public"."group_2"   add constraint fk_group_2_module_2 foreign key ("module_2_oid") references "public"."module_2" ("oid");


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module_2" (
   "group_2_oid"  int4 not null,
   "module_2_oid"  int4 not null,
  primary key ("group_2_oid", "module_2_oid")
);
alter table "public"."group_module_2"   add constraint fk_group_module_2_group_2 foreign key ("group_2_oid") references "public"."group_2" ("oid");
alter table "public"."group_module_2"   add constraint fk_group_module_2_module_2 foreign key ("module_2_oid") references "public"."module_2" ("oid");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user_2"  add column  "group_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_group_2 foreign key ("group_2_oid") references "public"."group_2" ("oid");


-- User_Group [User2Group_Group2User]
create table "public"."user_group_2" (
   "user_2_oid"  int4 not null,
   "group_2_oid"  int4 not null,
  primary key ("user_2_oid", "group_2_oid")
);
alter table "public"."user_group_2"   add constraint fk_user_group_2_user_2 foreign key ("user_2_oid") references "public"."user_2" ("oid");
alter table "public"."user_group_2"   add constraint fk_user_group_2_group_2 foreign key ("group_2_oid") references "public"."group_2" ("oid");


-- se refiere a [rel10]
alter table "public"."pista_2"  add column  "reserva_2_oid"  int4;
alter table "public"."pista_2"   add constraint fk_pista_2_reserva_2 foreign key ("reserva_2_oid") references "public"."reserva_2" ("oid");


-- Incidencia_Reserva [rel11]
alter table "public"."reserva_2"  add column  "incidencia_2_oid"  int4;
alter table "public"."reserva_2"   add constraint fk_reserva_2_incidencia_2 foreign key ("incidencia_2_oid") references "public"."incidencia_2" ("oid");


-- Valoracion_Pista [rel12]
alter table "public"."pista_2"  add column  "valoracion_2_oid"  int4;
alter table "public"."pista_2"   add constraint fk_pista_2_valoracion_2 foreign key ("valoracion_2_oid") references "public"."valoracion_2" ("oid");


-- organiza [rel13]
alter table "public"."user_2"  add column  "torneo_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_torneo_2 foreign key ("torneo_2_oid") references "public"."torneo_2" ("oid");


-- gestiona [rel14]
alter table "public"."user_2"  add column  "pista_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_pista_2 foreign key ("pista_2_oid") references "public"."pista_2" ("oid");


-- User_Valoracion [rel16]
alter table "public"."user_2"  add column  "valoracion_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_valoracion_2 foreign key ("valoracion_2_oid") references "public"."valoracion_2" ("oid");


-- User_Incidencia [rel17]
alter table "public"."user_2"  add column  "incidencia_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_incidencia_2_2 foreign key ("incidencia_2_oid") references "public"."incidencia_2" ("oid");


-- User_User [rel18]
alter table "public"."user_2"  add column  "user_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_user_2 foreign key ("user_2_oid") references "public"."user_2" ("oid");


-- reporta [rel3]
alter table "public"."user_2"  add column  "incidencia_2_oid_2"  int4;
alter table "public"."user_2"   add constraint fk_user_2_incidencia_2 foreign key ("incidencia_2_oid_2") references "public"."incidencia_2" ("oid");


-- participa [rel4]
create table "public"."participa" (
   "user_2_oid"  int4 not null,
   "torneo_2_oid"  int4 not null,
  primary key ("user_2_oid", "torneo_2_oid")
);
alter table "public"."participa"   add constraint fk_participa_user_2 foreign key ("user_2_oid") references "public"."user_2" ("oid");
alter table "public"."participa"   add constraint fk_participa_torneo_2 foreign key ("torneo_2_oid") references "public"."torneo_2" ("oid");


-- guarda como fav [rel6]
create table "public"."guarda_como_fav" (
   "user_2_oid"  int4 not null,
   "pista_2_oid"  int4 not null,
  primary key ("user_2_oid", "pista_2_oid")
);
alter table "public"."guarda_como_fav"   add constraint fk_guarda_como_fav_user_2 foreign key ("user_2_oid") references "public"."user_2" ("oid");
alter table "public"."guarda_como_fav"   add constraint fk_guarda_como_fav_pista_2 foreign key ("pista_2_oid") references "public"."pista_2" ("oid");


-- realiza [rel7]
alter table "public"."user_2"  add column  "reserva_2_oid"  int4;
alter table "public"."user_2"   add constraint fk_user_2_reserva_2 foreign key ("reserva_2_oid") references "public"."reserva_2" ("oid");


-- escribe [rel8]
alter table "public"."user_2"  add column  "valoracion_2_oid_2"  int4;
alter table "public"."user_2"   add constraint fk_user_2_valoracion_2_2 foreign key ("valoracion_2_oid_2") references "public"."valoracion_2" ("oid");


-- se juega en [rel9]
alter table "public"."pista_2"  add column  "torneo_2_oid"  int4;
alter table "public"."pista_2"   add constraint fk_pista_2_torneo_2 foreign key ("torneo_2_oid") references "public"."torneo_2" ("oid");


