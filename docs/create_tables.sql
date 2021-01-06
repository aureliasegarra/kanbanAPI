/* Première table : List */

-- On démarre une transaction afin de s'assurer de la cohérence gloabale de la BDD
BEGIN;

-- D'abord on supprime les table 'si elle existe"
DROP TABLE IF EXISTS "list", "card", "tag", "card_has_tag";

-- après le DROP, aucune chance que les tables existent

-- Ensuite on la (re)crée

-- SERIAL = int auto-incrémenté
-- PRIMARY KEY implique NOT NULL, pas besoin de l'écrire
CREATE TABLE "list" (
  -- on utilise le nouveau type qui est un standart SQL alors que SERIAL est un pseudo-type de PG
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "position" INTEGER NOT NULL DEFAULT 0,
  -- pour avoir la date et l'heure on utilise le type "timestamp", et pour être le plus précis possible on utilisera plutôt le type "timestampz" qui contient en plus de la date et de l'heure le fuseau horaire défini dans les locales du serveur
  -- pensez à la réunion Meet avec les collègues internationaux
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);


/* 2ème table : Card */

CREATE TABLE "card" (
  "id" SERIAL PRIMARY KEY,
  "content" TEXT NOT NULL DEFAULT '',
  "color" TEXT NOT NULL DEFAULT '#FFF', -- la couleur optionnelle est ici représentée par une valeur par défaut, si je ne donne pas de couleur, le fond sera blanc
  -- si l'on veut pouvoir supprimer une liste qui contient des cartes, on est obligé de rajouter "ON DELETE CASCADE" qui aura pour conséquence de supprimer toutes les cartes qui font référence à la liste
  "list_id" INTEGER NOT NULL REFERENCES list("id") ON DELETE CASCADE,
  "position" INTEGER NOT NULL DEFAULT 0,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

/* 3ème table : Tag */

CREATE TABLE "tag" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL DEFAULT '',
  "color" TEXT NOT NULL DEFAULT '#FFF' ,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  "updated_at" TIMESTAMPTZ
);

/* On oublie pas la table de liaison ! */

-- même pour une table de liaison, utilisez systématiquement un id serial pk
CREATE TABLE "card_has_tag" (
  "id" SERIAL PRIMARY KEY,
  -- si l'on veut pouvoir supprimer une carte ou un tag, on est obligé de rajouter "ON DELETE CASCADE" qui aura pour conséquence de supprimer les associations qui font référence a la carte ou le tag supprimé.
  "card_id" INTEGER NOT NULL REFERENCES card("id") ON DELETE CASCADE,
  "tag_id" INTEGER NOT NULL REFERENCES tag("id") ON DELETE CASCADE,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
  -- ici pas d'updated_at car une relation ne se met pas à jour, soit on l'ajoute soit on la supprime
);

-- pour card_has_tag, on ne fera pas d'UPDATE, que des DELETE pour supprimer une relation card<>tag ou des INSERT pour en ajouter

/* une fois les tables crées, on va les remplir */

-- les tables viennent d'être créées, leur serial commencera donc à 1, aucun doute là-dessus

-- je peux me permettre de supposer que les id commenceront à 1 car :
-- les tables existantes sont droppées avant d'être recréées
-- toutes les instructions dans la même transaction donc tout passe ou rien ne passe

INSERT INTO "list" ("name")
VALUES ('Première liste' );

INSERT INTO "card" ("content", "color", "list_id")
VALUES ('Carte 1', 1), -- id 1
       ('2ème carte', '#c1e7ff', 1); -- id 2

INSERT INTO "tag" ("name", "color")
VALUES ('Urgent', '#F00'); -- id 1

-- et on oublie pas la table de liaison !
INSERT INTO "card_has_tag" ("card_id", "tag_id")
VALUES (1,1); -- Carte 1, Urgent

COMMIT;

/*
Pour créer 2 cartes, une blanche et l'autre rouge

a) laisser la couleur par défaut
INSERT INTO card (color, name) VALUES ('#f00', 'carte rouge');
INSERT INTO card (name) VALUES ('carte blanche');

b) donner toutes les infos
INSERT INTO card (color, name)
VALUES ('#f00', 'carte rouge'),
       ('#fff', 'carte blanche');

c) utiliser le mot-clé DEFAULT
INSERT INTO card (color, name)
VALUES ('#f00', 'carte rouge'),
       (DEFAULT, 'carte blanche');

*/