--liquibase formatted sql

--changeset tphipson:create-states-table
CREATE TABLE states (
  state_id varchar NOT NULL PRIMARY KEY,
  context text NOT NULL
);
--rollback DROP TABLE states;

--changeset tphipson:create-state-options-table
CREATE TABLE state_options (
  option_id SERIAL NOT NULL PRIMARY KEY,
  state_id varchar NOT NULL,
  option_text text NOT NULL,
  next_state_id varchar NOT NULL
);
--rollback DROP TABLE state_options;

--changeset tphipson:add-foreign-key-constraints
ALTER TABLE state_options ADD CONSTRAINT fk_state_options_state_id FOREIGN KEY (state_id) REFERENCES states (state_id);
--rollback ALTER TABLE state_options DROP CONSTRAINT fk_state_options_state_id;