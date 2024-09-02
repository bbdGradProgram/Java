--liquibase formatted sql

-- here you can add the states and state options, this file is included in the changelog.yaml
-- the starting state must be named 'startState'

--changeset aokruger:insert-start-state
INSERT INTO states (state_id, context) VALUES ('startState', 'You are … a bean. You are in the kitchen, where the BBD Chef accidentally dropped you, preventing you from being someone’s lunch. It is up to you to escape. Where would you like to go?');
--rollback DELETE FROM states WHERE "state_id" = 'startState';

--changeset aokruger:insert-lucky-state
INSERT INTO states (state_id, context) VALUES ('lucky', 'You walk into the room and see a handsome man named Lucky busy working on a very strange thing called Javascript (it does not look fun). There is a door on the right and a door on the left. Lucky does not see you yet, but he is looking tired so you might want to move quickly before he gets up to go fetch coffee…');
--rollback DELETE FROM states WHERE "state_id" = 'lucky';

--changeset aokruger:insert-lucky-death-state
INSERT INTO states (state_id, context) VALUES ('luckyDeath', 'Oh no. As you snuck into this room, you accidently stepped on a banana. That banana sent signals to Lucky’s missile-firing drone which fired missiles at you, killing you instantly.');
--rollback DELETE FROM states WHERE "state_id" = 'luckyDeath';

--changeset aokruger:insert-lucky-escape-state
INSERT INTO states (state_id, context) VALUES ('luckyEscape', 'Looks like you just walked out of the front door of the BBD offices. Your bean wife and 2 month old bean baby greet you with open arms. You walk away hand in hand and live happily ever after. Congratulations, you escaped!');
--rollback DELETE FROM states WHERE "state_id" = 'luckyEscape';

--changeset aokruger:insert-tony-state
INSERT INTO states (state_id, context) VALUES ('tony', 'In this room you find Tony the CIO. He is in a very important meeting regarding BBD’s informations. You better move fast before he finishes with the meeting and sees you!');
--rollback DELETE FROM states WHERE "state_id" = 'tony';

--changeset aokruger:insert-tony-dead-end-state
INSERT INTO states (state_id, context) VALUES ('tonyDeadEnd', 'Looks like you walked into a storage room. All you see is lots of alcohol and coffee beans. You better turn back and look for the exit.');
--rollback DELETE FROM states WHERE "state_id" = 'tonyDeadEnd';

--changeset aokruger:insert-rudolph-state
INSERT INTO states (state_id, context) VALUES ('rudolph', 'Uh oh. Rudolph is guarding this room and he noticed you immediately with his sharp eyes. He looks hungry. There is a car behind him which you can use to escape, but you will have to fight Rudolph to the death in order to get past him.');
--rollback DELETE FROM states WHERE "state_id" = 'rudolph';

--changeset aokruger:insert-rudolph-death-state
INSERT INTO states (state_id, context) VALUES ('rudolphDeath', 'You charge Rudolph. He calmly pulls out his laptop and looks at your online Git repository. He proceeds to judge your code and humiliate you. You die from shame before you even made it halfway to him.');
--rollback DELETE FROM states WHERE "state_id" = 'rudolphDeath';

--changeset aokruger:insert-grads-state
INSERT INTO states (state_id, context) VALUES ('grads', 'Here you find the entire grad group from 2024, They are busy with the Java LevelUp. All of them are crying and don’t have the will to get up and eat you, so there is no immediate danger.');
--rollback DELETE FROM states WHERE "state_id" = 'grads';

--changeset aokruger:insert-grads-dead-end-state
INSERT INTO states (state_id, context) VALUES ('gradsDeadEnd', 'Looks like you walked into a storage room. All you see is lots of alcohol and coffee beans. You better turn back and look for the exit.');
--rollback DELETE FROM states WHERE "state_id" = 'gradsDeadEnd';

--changeset aokruger:insert-thabang-state
INSERT INTO states (state_id, context) VALUES ('thabang', 'In here you see Thabang by himself, busy with his 5th beer of the morning. He looks friendly, but the alcohol might make him want to snack on a juicy bean like yourself.');
--rollback DELETE FROM states WHERE "state_id" = 'thabang';

--changeset aokruger:insert-thabang-escape-state
INSERT INTO states (state_id, context) VALUES ('thabangEscape', 'Thabang takes you to the roof where a helicopter awaits you with the rest of the bean refugees Thabang rescued. The helicopter will take you to the promised bean land, which contains all the loose, well-drained soil with some organic matter and a soil pH of 6.5 that beans love. Congratulations you’ve bean saved!');
--rollback DELETE FROM states WHERE "state_id" = 'thabangEscape';

--changeset aokruger:insert-start-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('startState', 'Go to Tony''s room.', 'tony');
--rollback DELETE FROM state_options WHERE "state_id" = 'startState';

--changeset aokruger:insert-start-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('startState', 'Go to Lucky''s room.', 'lucky');
--rollback DELETE FROM state_options WHERE "state_id" = 'startState';

--changeset aokruger:insert-start-state-option3
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('startState', 'Go to the grads'' room.', 'grads');
--rollback DELETE FROM state_options WHERE "state_id" = 'startState';

--changeset aokruger:insert-lucky-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('lucky', 'Go back to the kitchen.', 'startState');
--rollback DELETE FROM state_options WHERE "state_id" = 'lucky';

--changeset aokruger:insert-lucky-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('lucky', 'Go through the door on the right.', 'luckyDeath');
--rollback DELETE FROM state_options WHERE "state_id" = 'lucky';

--changeset aokruger:insert-lucky-state-option3
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('lucky', 'Go through the door on the left.', 'luckyEscape');
--rollback DELETE FROM state_options WHERE "state_id" = 'lucky';

--changeset aokruger:insert-tony-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('tony', 'Go back to the kitchen.', 'startState');
--rollback DELETE FROM state_options WHERE "state_id" = 'tony';

--changeset aokruger:insert-tony-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('tony', 'Go to Rudolph''s room.', 'rudolph');
--rollback DELETE FROM state_options WHERE "state_id" = 'tony';

--changeset aokruger:insert-tony-state-option3
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('tony', 'Go to the room next to Rudolph''s.', 'tonyDeadEnd');
--rollback DELETE FROM state_options WHERE "state_id" = 'tony';

--changeset aokruger:insert-tony-dead-end-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('tonyDeadEnd', 'Go back to Tony.', 'tony');
--rollback DELETE FROM state_options WHERE "state_id" = 'tonyDeadEnd';

--changeset aokruger:insert-rudolph-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('rudolph', 'Run back to Tony''s room.', 'tony');
--rollback DELETE FROM state_options WHERE "state_id" = 'rudolph';

--changeset aokruger:insert-rudolph-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('rudolph', 'Attempt to overpower Rudolph and steal his car.', 'rudolphDeath');
--rollback DELETE FROM state_options WHERE "state_id" = 'rudolph';

--changeset aokruger:insert-grads-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('grads', 'Go back to the kitchen.', 'startState');
--rollback DELETE FROM state_options WHERE "state_id" = 'grads';

--changeset aokruger:insert-grads-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('grads', 'Go to the nameless room', 'gradsDeadEnd');
--rollback DELETE FROM state_options WHERE "state_id" = 'grads';

--changeset aokruger:insert-grads-state-option3
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('grads', 'Go to Thabang''s room.', 'thabang');
--rollback DELETE FROM state_options WHERE "state_id" = 'grads';

--changeset aokruger:insert-grads-dead-end-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('gradsDeadEnd', 'Go back to the grads.', 'grads');
--rollback DELETE FROM state_options WHERE "state_id" = 'gradsDeadEnd';

--changeset aokruger:insert-thabang-state-option1
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('thabang', 'Go back to the grads.', 'grads');
--rollback DELETE FROM state_options WHERE "state_id" = 'thabang';

--changeset aokruger:insert-thabang-state-option2
INSERT INTO state_options (state_id, option_text, next_state_id) VALUES ('thabang', 'Gently approach Thabang.', 'thabangEscape');
--rollback DELETE FROM state_options WHERE "state_id" = 'thabang';

--changeset tphipson:update-start-state-punc
UPDATE states
SET context = 'You are... a bean. You are in the kitchen, where the BBD Chef accidentally dropped you, preventing you from being someone''s lunch. It is up to you to escape. Where would you like to go?'
WHERE state_id = 'startState';
--rollback empty

--changeset tphipson:update-lucky-state-punc
UPDATE states
SET context = 'You walk into the room and see a handsome man named Lucky busy working on a very strange thing called Javascript (it does not look fun). There is a door on the right and a door on the left. Lucky does not see you yet, but he is looking tired so you might want to move quickly before he gets up to go fetch coffee...'
WHERE state_id = 'lucky';
--rollback empty

--changeset tphipson:update-lucky-death-state-punc
UPDATE states
SET context = 'Oh no. As you snuck into this room, you accidently stepped on a banana. That banana sent signals to Lucky''s missile-firing drone which fired missiles at you, killing you instantly.'
WHERE state_id = 'luckyDeath';
--rollback empty

--changeset tphipson:update-tony-state-punc
UPDATE states
SET context = 'In this room you find Tony the CIO. He is in a very important meeting regarding BBD''s informations. You better move fast before he finishes with the meeting and sees you!'
WHERE state_id = 'tony';
--rollback empty

--changeset tphipson:update-grad-state-punc
UPDATE states
SET context = 'Here you find the entire grad group from 2024, They are busy with the Java LevelUp. All of them are crying and don''t have the will to get up and eat you, so there is no immediate danger.'
WHERE state_id = 'grads';
--rollback empty

--changeset tphipson:update-thabang-state-punc
UPDATE states
SET context = 'Thabang takes you to the roof where a helicopter awaits you with the rest of the bean refugees Thabang rescued. The helicopter will take you to the promised bean land, which contains all the loose, well-drained soil with some organic matter and a soil pH of 6.5 that beans love. Congratulations you''ve bean saved!'
WHERE state_id = 'thabangEscape';
--rollback empty
