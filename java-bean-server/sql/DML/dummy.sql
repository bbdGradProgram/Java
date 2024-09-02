--liquibase formatted sql

--changeset tphipson:insert-dummy-player
INSERT INTO players (username) VALUES ('dummy-test-user');
--rollback DELETE FROM players WHERE "username" = 'dummy-test-user';

--changeset tphipson:insert-dummy-player2
INSERT INTO players (username) VALUES ('dummy-test-user2');
--rollback DELETE FROM players WHERE "username" = 'dummy-test-user2';

--changeset tphipson:insert-dummy-state
INSERT INTO states (state_id, context) VALUES ('dummyState', 'This is a dummy state context for testing.');
--rollback DELETE FROM states WHERE "state_id" = 'dummyState';

--changeset tphipson:insert-dummy-state2
INSERT INTO states (state_id, context) VALUES ('dummyState2', 'This is the second dummy state context for testing.');
--rollback DELETE FROM states WHERE "state_id" = 'dummyState2';

--changeset tphipson:insert-dummy-state3
INSERT INTO states (state_id, context) VALUES ('dummyState3', 'This is the third dummy state context for testing.');
--rollback DELETE FROM states WHERE "state_id" = 'dummyState3';

--changeset tphipson:insert-dummy-state4
INSERT INTO states (state_id, context) VALUES ('dummyState4', 'This is the fourth dummy state context for testing.');
--rollback DELETE FROM states WHERE "state_id" = 'dummyState4';

--changeset tphipson:insert-dummy-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('dummyState', 'Go to dummyState2.', 'dummyState2');
--rollback DELETE FROM state_options WHERE "state_id" = 'dummyState';

--changeset tphipson:insert-dummy-state2-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('dummyState2', 'Go to dummyState.', 'dummyState');
--rollback DELETE FROM state_options WHERE "state_id" = 'dummyState2';

--changeset tphipson:insert-dummy-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('dummyState', 'Go to dummyState3.', 'dummyState3');
--rollback DELETE FROM state_options WHERE "state_id" = 'dummyState';

--changeset tphipson:insert-dummy-state2-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('dummyState2', 'Go to dummyState4.', 'dummyState4');
--rollback DELETE FROM state_options WHERE "state_id" = 'dummyState2';

--changeset tphipson:insert-dummy-state3-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('dummyState3', 'Go to dummyState.', 'dummyState');
--rollback DELETE FROM state_options WHERE "state_id" = 'dummyState3';

--changeset tphipson:insert-dummy-state4-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('dummyState4', 'Go to dummyState.', 'dummyState');
--rollback DELETE FROM state_options WHERE "state_id" = 'dummyState4';