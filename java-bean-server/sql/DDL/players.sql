--liquibase formatted sql

--changeset tphipson:create-player-table
CREATE TABLE "players" (
  "player_id" SERIAL NOT NULL PRIMARY KEY,
  "username" varchar NOT NULL,
  "last_game_state" varchar DEFAULT 'start_state',
  "uid" varchar
);
--rollback DROP TABLE players;

--changeset tphipson:alter-player-default-state
ALTER TABLE "players"
ALTER COLUMN "last_game_state" SET DEFAULT 'startState';
--rollback ALTER TABLE "players" ALTER COLUMN "last_game_state" DROP DEFAULT;

--changeset tphipson:alter-player-ui-to-email
ALTER TABLE "players"
RENAME COLUMN "uid" TO email;
--rollback ALTER TABLE "players" RENAME COLUMN "email" TO "uid";