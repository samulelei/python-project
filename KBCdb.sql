CREATE USER 'dbuser01'@'localhost' IDENTIFIED BY 'dbpass';
GRANT SELECT, INSERT, UPDATE, DELETE ON kbc.* TO dbuser01@localhost;

DROP DATABASE IF EXISTS kbc;
CREATE DATABASE kbc;
USE kbc;

DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Object;
DROP TABLE IF EXISTS Passage;
DROP TABLE IF EXISTS Location;

CREATE TABLE Location (
	ID VARCHAR(100),
	Description VARCHAR(255),
	Details VARCHAR(255),
	Bartab INT,
	Throwoutdesc VARCHAR(255),
	PRIMARY KEY (ID)
	);
		
CREATE TABLE Passage (
	ID VARCHAR(100),
	Source VARCHAR(100),
	Destination VARCHAR(100),
	Direction VARCHAR(100),
	Locked INT,
	Locknote VARCHAR(100),
	PRIMARY KEY (ID),
	FOREIGN KEY (Source) REFERENCES Location(ID),
	FOREIGN KEY (Destination) REFERENCES Location(ID)
	);
	
CREATE TABLE Player (
	ID INT(20),
	Drunkometer INT(200),
	Maxdrunkometer INT(200),
	Money VARCHAR(255),
	Moves INT(255),
	Maxmoves INT(255),
	Location VARCHAR(100),
	PRIMARY KEY (ID),
	FOREIGN KEY (Location) REFERENCES Location(ID)
	);
	
CREATE TABLE Object (
	ID INT(20),
	Name VARCHAR(100),
	Description VARCHAR(255),
	Available BOOLEAN,
	Money INT(255),
	PlayerID INT(20),
	Location VARCHAR(100),
	PRIMARY KEY (ID),
	FOREIGN KEY (Location) REFERENCES Location(ID),
	FOREIGN KEY (PlayerID) REFERENCES Player(ID)
	);

INSERT INTO Location VALUES ('vaasanaukio', 'I could crawl north to Vaasankatu or south to Helsinginkatu.', 'at Vaasanaukio.', NULL, NULL);
INSERT INTO Location VALUES ('vaasapenger', 'I could turn south to Perngerpolku from here or continue Vaasankatu to west.', 'in the corner of Vaasankatu and Pengerpolku.', NULL, NULL);
INSERT INTO Location VALUES ('iltakouluout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Restaurant Iltakoulu.', NULL, NULL);
INSERT INTO Location VALUES ('iltakouluin', 'This looks like a great place for drunk studies.', 'inside Restaurant Iltakoulu.', 2, 'Dude.. you just pissed in the sink! You got kicked out!');
INSERT INTO Location VALUES ('hilpeahaukiout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Beer restaurant Hilpeä Hauki.', NULL, NULL);
INSERT INTO Location VALUES ('hilpeahaukiin', 'Something about this place looks a bit fishy.', 'inside Beer restaurant Hilpeä Hauki.', 2, 'You tried to hit on the bouncer\'s girlfriend. He dragged you out and almost kicked your ass!');
INSERT INTO Location VALUES ('kultapalmuout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Kultapalmu.', NULL, NULL);
INSERT INTO Location VALUES ('kultapalmuin', 'This looks like a place for hippies. It smells like burnt leaves in here.', 'inside Kultapalmu.', 2, 'The bouncer noticed, that you tried to drink other\'s leftover drinks so you got kicked out.');
INSERT INTO Location VALUES ('vaasaharju', 'I could continue Vaasankatu to west, east or turn south to Harjukatu.', 'in the Corner of Vaasankatu and Harjukatu.', NULL, NULL);
INSERT INTO Location VALUES ('solmupubout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Solmu Pub.', NULL, NULL);
INSERT INTO Location VALUES ('solmupubin', 'This looks like a place where people come to hang themselves.', 'inside Solmu Pub.', 2, 'You tried to drink straight from the tab.. Get out of here and never come back!.');
INSERT INTO Location VALUES ('kustaavaasaout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Restaurant Kustaa Vaasa.', NULL, NULL);
INSERT INTO Location VALUES ('kustaavaasain', 'Wow a real restaurant! I hope you can get drinks in here.', 'inside Restaurant Kustaa Vaasa.', 2, 'The bouncer noticed, that you tried to drink other\'s leftover drinks so you got kicked out.');
INSERT INTO Location VALUES ('kalliohoviout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Bar Kalliohovi.', NULL, NULL);
INSERT INTO Location VALUES ('kalliohoviin', 'This looks like a nice place.', 'inside Bar Kalliohovi.', 2, 'You got mad at the bartender and started throwing toilet paper at him. You got kicked out.');
INSERT INTO Location VALUES ('kallionb12out', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Kallion B12.', NULL, NULL);
INSERT INTO Location VALUES ('kallionb12in', 'B12? I could use some vitamins.', 'inside Kallion B12.', 2, 'No, no, and no! You can\'t just show off your private parts to the waitress. The bouncer kicked you out!');
INSERT INTO Location VALUES ('vaasakustaa', 'I could continue Vaasankatu to west, east or continue Kustaankatu to north or south.', 'in the corner of Vaasankatu and Kustaankatu.', NULL, NULL);
INSERT INTO Location VALUES ('bartappenout', 'I could continue Kustaankatu to south or go inside the bar.', 'outside of Bar Tappen.', NULL, NULL);
INSERT INTO Location VALUES ('bartappenin', 'This looks like a place where people come to tap out.', 'inside Bar Tappen.', 2, 'You tried to punch some guy, but hit the bartender instead. The bouncer dragged you out.');
INSERT INTO Location VALUES ('heinahattuout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Pub Heinähattu.', NULL, NULL);
INSERT INTO Location VALUES ('heinahattuin', 'This looks like a place for overly concerned grandmas.', 'inside Pub Heinähattu.', 2, 'Dude.. you just pissed in the sink! You got kicked out!');
INSERT INTO Location VALUES ('siimabarout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Siima Bar.', NULL, NULL);
INSERT INTO Location VALUES ('siimabarin', 'This looks like a place for fishermen.', 'inside Siima Bar.', 2, 'Dude.. you just pissed in the sink! You got kicked out!');
INSERT INTO Location VALUES ('vivalavidaout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Viva La Vida.', NULL, NULL);
INSERT INTO Location VALUES ('vivalavidain', 'This place looks fancy.', 'inside Viva La Vida.', 2, 'Did you forget something? Like your pants? You left them in the toilet while you were taking a shit. Bouncer kicked you out for flashing');
INSERT INTO Location VALUES ('barmolotowout', 'I could continue Vaasankatu to west, east or go inside the bar.', 'outside of Bar Molotow.', NULL, NULL);
INSERT INTO Location VALUES ('barmolotowin', 'This looks like a place where a hipster threw up on the walls.', 'inside Bar Molotow.', 2, 'You tried to punch some guy, but hit the bartender instead. The bouncer dragged you out.');
INSERT INTO Location VALUES ('vaasaflemari', 'I could continue Vaasankatu to west, east or turn south to Fleminginkatu.', 'in the corner of Vaasankatu and Fleminginkatu.', NULL, NULL);
INSERT INTO Location VALUES ('ontherocksout', 'I could continue Vaasankatu to east or go inside the bar.', 'outside of On the Rocks Kallio.', NULL, NULL);
INSERT INTO Location VALUES ('ontherocksin', 'Wow there\'s a TV in here! I hope a game is on.', 'inside On the Rocks Kallio.', 2, 'The bouncer noticed, that you tried to drink other\'s leftover drinks so you got kicked out.');
INSERT INTO Location VALUES ('harjubarout', 'I could continue Fleminginkatu to north, south or go inside the bar.', 'outiside of Harju Bar.', NULL, NULL);
INSERT INTO Location VALUES ('harjubarin', 'This looks like a place for lumberjacks.', 'inside Harju Bar.', 2, 'You got mad at the bartender and started throwing toilet paper at him. You got kicked out.');
INSERT INTO Location VALUES ('flemarikuja', 'I could continue Fleminginkatu to north, south or turn east to Helsinginkuja.', 'in the corner of Helsinginkuja and Fleminginkatu.', NULL, NULL);
INSERT INTO Location VALUES ('helsinginkuja4', 'I could continue Helsinginkuja to west or east.', 'at Helsinginkuja 4.', NULL, NULL);
INSERT INTO Location VALUES ('kustaakuja', 'I could continue Kustaankatu to north, south or turn west to Helsinginkuja.', 'in the corner of Helsinginkuja and Kustaankatu.', NULL, NULL);
INSERT INTO Location VALUES ('hesariflemari', 'I could continue Helsinginkatu to west, east or turn north to Fleminginkatu or try crossing over Helsinginkatu to south.', 'in the corner of Helsinginkatu and Fleminginkatu.', NULL, NULL);
INSERT INTO Location VALUES ('bar21out', 'I could continue Helsinginkatu to east or go inside the bar.', 'outside of Bar21.', NULL, NULL);
INSERT INTO Location VALUES ('bar21in', 'I bet there is a lot of card counters in here.', 'inside Bar21.', 2, 'You tried to punch some guy, but hit the bartender instead. The bouncer dragged you out.');
INSERT INTO Location VALUES ('tenkkaout', 'I could continue Helsinginkatu to west, east or go inside the bar.', 'outside of Restaurant Tenkka.', NULL, NULL);
INSERT INTO Location VALUES ('tenkkain', 'This place looks like... wait what was I going to say? I don\'t remember.', 'inside Restaurant Tenkka.', 2, 'You tried to punch some guy, but hit the bartender instead. The bouncer dragged you out.');
INSERT INTO Location VALUES ('tenhoout', 'I could continue Helsinginkatu to west, east or go inside the bar.', 'outside of Tenho Restobar.', NULL, NULL);
INSERT INTO Location VALUES ('tenhoin', 'This place looks shitty.', 'inside Tenho Restobar.', 2, 'The bouncer noticed that you tried to drink other\'s leftover drinks so you got kicked out.');
INSERT INTO Location VALUES ('relaxinout', 'I could continue Helsinginkatu to west, east or go inside the bar.', 'outside of Relaxin.', NULL, NULL);
INSERT INTO Location VALUES ('relaxinin', 'This looks like a great place for relaxin. Ba dum tss.', 'inside Relaxin.', 2, 'No, no, and no! You can\'t just show off your private parts to the waitress. The bouncer kicked you out!');
INSERT INTO Location VALUES ('hesarikustaa', 'I could continue Helsinginkatu to west, east or turn north to Kustaankatu or try crossing Helsinginkatu to south.', 'in the corner of Helsinginkatu and Kustaankatu.', NULL, NULL);
INSERT INTO Location VALUES ('paakonttoriout', 'I could continue Helsinginkatu to west, east or go inside the bar.', 'outside of Pääkonttori.', NULL, NULL);
INSERT INTO Location VALUES ('paakonttoriin', 'This looks like a place for bikers.', 'inside Pääkonttori.', 2, 'You got mad at the bartender and started throwing toilet paper at him. You got kicked out.');
INSERT INTO Location VALUES ('hesari9', 'I could continue Helsinginkatu to west or east.', 'at Helsinginkatu 9.', NULL, NULL);
INSERT INTO Location VALUES ('fairytaleout', 'I could continue Helsinginkatu to west, east or go inside the bar.', 'outside of Fairytale.', NULL, NULL);
INSERT INTO Location VALUES ('fairytalein', 'Is that the Snow White in the corner there or did someone spike my drink?', 'inside Fairytale.', 2, 'You tried to punch some guy, but hit the bartender instead. The bouncer dragged you out.');
INSERT INTO Location VALUES ('hesariharju', 'I could continue Helsinginkatu to west, east or turn north to Harjukatu.', 'in the corner of Helsinginkatu and Harjukatu.', NULL, NULL);
INSERT INTO Location VALUES ('harjukatu3', 'I could continue Harjukatu to north or south.', 'at Harjukatu 3.', NULL, NULL);
INSERT INTO Location VALUES ('hesari5', 'I could continue Helsinginkatu to west or east.', 'at Helsinginkatu 5.', NULL, NULL);
INSERT INTO Location VALUES ('lepakkomiesout', 'I could continue Helsinginkatu to west, east or go inside the bar.', 'outside of Bar Lepakkomies.', NULL, NULL);
INSERT INTO Location VALUES ('lepakkomiesin', 'This looks like place where the Bruce Wayne would drink.', 'inside Bar Lepakkomies.', 2, 'You tried to buy some "service" from the waitress so you got kicked out!');
INSERT INTO Location VALUES ('hesaripenger', 'I could turn north to Perngerpolku from here, continue Helsinginkatu to west or try crossing Helsinginkatu to south.', 'in the corner of Helsinginkatu and Pengerpolku.', NULL, NULL);

INSERT INTO Player VALUES (1, 0, 100, 0, 0, 300,'vaasanaukio');

INSERT INTO Passage VALUES ('vaasanaukion', 'vaasanaukio', 'vaasapenger', 'n', 0, NULL);
INSERT INTO Passage VALUES ('vaasanaukios', 'vaasanaukio', 'hesaripenger', 's', 0, NULL);

INSERT INTO Passage VALUES ('vaasapengerw', 'vaasapenger', 'iltakouluout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('vaasapengers', 'vaasapenger', 'vaasanaukio', 's', 0, NULL);

INSERT INTO Passage VALUES ('iltakouluw', 'iltakouluout', 'hilpeahaukiout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('iltakoulue', 'iltakouluout', 'vaasapenger', 'e', 0, NULL);
INSERT INTO Passage VALUES ('iltakouluenter', 'iltakouluout', 'iltakouluin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('iltakouluexit', 'iltakouluin', 'iltakouluout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('hilpeahaukiw', 'hilpeahaukiout', 'kultapalmuout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hilpeahaukie', 'hilpeahaukiout', 'iltakouluout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('hilpeahaukienter', 'hilpeahaukiout', 'hilpeahaukiin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('hilpeahaukiexit', 'hilpeahaukiin', 'hilpeahaukiout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('kultapalmuw', 'kultapalmuout', 'vaasaharju', 'w', 0, NULL);
INSERT INTO Passage VALUES ('kultapalmue', 'kultapalmuout', 'hilpeahaukiout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('kultapalmuenter', 'kultapalmuout', 'kultapalmuin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('kultapalmuexit', 'kultapalmuin', 'kultapalmuout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('vaasaharjue', 'vaasaharju', 'kultapalmuout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('vaasaharjuw', 'vaasaharju', 'solmupubout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('vaasaharjus', 'vaasaharju', 'harjukatu3', 's', 0, NULL);

INSERT INTO Passage VALUES ('harjukatu3n', 'harjukatu3', 'vaasaharju','n', 0, NULL);
INSERT INTO Passage VALUES ('harjukatu3s', 'harjukatu3', 'hesariharju', 's', 0, NULL);

INSERT INTO Passage VALUES ('solmupubw', 'solmupubout', 'kustaavaasaout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('solmupube', 'solmupubout', 'vaasaharju', 'e', 0, NULL);
INSERT INTO Passage VALUES ('solmupubenter','solmupubout', 'solmupubin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('solmupubexit', 'solmupubin', 'solmupubout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('kustaavaasaw', 'kustaavaasaout', 'kalliohoviout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('kustaavaasae', 'kustaavaasaout', 'solmupubout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('kustaavaasaenter', 'kustaavaasaout', 'kustaavaasain', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('kustaavaasaexit', 'kustaavaasain', 'kustaavaasaout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('kalliohoviw', 'kalliohoviout', 'kallionb12out', 'w', 0, NULL);
INSERT INTO Passage VALUES ('kalliohovie', 'kalliohoviout', 'kustaavaasaout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('kalliohovienter','kalliohoviout', 'kalliohoviin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('kalliohoviexit', 'kalliohoviin', 'kalliohoviout','out', 0, NULL);

INSERT INTO Passage VALUES ('kallionb12w', 'kallionb12out', 'vaasakustaa', 'w', 0, NULL);
INSERT INTO Passage VALUES ('kallionb12e', 'kallionb12out', 'kalliohoviout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('kallionb12enter', 'kallionb12out', 'kallionb12in', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('kallionb12exit', 'kallionb12in', 'kallionb12out', 'out', 0, NULL);

INSERT INTO Passage VALUES ('vaasakustaae', 'vaasakustaa', 'kallionb12out', 'e', 0, NULL);
INSERT INTO Passage VALUES ('vaasakustaan', 'vaasakustaa', 'bartappenout', 'n', 0, NULL);
INSERT INTO Passage VALUES ('vaasakustaaw', 'vaasakustaa', 'heinahattuout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('vaasakustaas', 'vaasakustaa', 'kustaakuja', 's', 0, NULL);

INSERT INTO Passage VALUES ('bartappens', 'bartappenout', 'vaasakustaa', 's', 0, NULL);
INSERT INTO Passage VALUES ('bartappenenter', 'bartappenout', 'bartappenin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('bartappenexit', 'bartappenin', 'bartappenout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('heinahattuw', 'heinahattuout', 'siimabarout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('heinahattue', 'heinahattuout', 'vaasakustaa', 'e', 0, NULL);
INSERT INTO Passage VALUES ('heinahattuenter', 'heinahattuout', 'heinahattuin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('heinahattuexit', 'heinahattuin', 'heinahattuout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('siimabarw', 'siimabarout', 'vivalavidaout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('siimabare', 'siimabarout', 'heinahattuout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('siimabarenter', 'siimabarout', 'siimabarin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('siimabarexit', 'siimabarin', 'siimabarout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('vivalavidaw', 'vivalavidaout', 'barmolotowout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('vivalavidae', 'vivalavidaout', 'siimabarout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('vivalavidaenter', 'vivalavidaout', 'vivalavidain', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('vivalavidaexit', 'vivalavidain', 'vivalavidaout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('barmolotoww', 'barmolotowout', 'vaasaflemari', 'w', 0, NULL);
INSERT INTO Passage VALUES ('barmolotowe', 'barmolotowout', 'vivalavidaout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('barmolotowenter', 'barmolotowout', 'barmolotowin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('barmolotowexit', 'barmolotowin', 'barmolotowout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('vaasaflemariw', 'vaasaflemari', 'ontherocksout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('vaasaflemarie', 'vaasaflemari', 'barmolotowout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('vaasaflemaris', 'vaasaflemari', 'harjubarout', 's', 0, NULL);

INSERT INTO Passage VALUES ('ontherockse', 'ontherocksout', 'vaasaflemari', 'e', 0, NULL);
INSERT INTO Passage VALUES ('ontherocksenter', 'ontherocksout', 'ontherocksin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('ontherocksexit', 'ontherocksin', 'ontherocksout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('harjubarn', 'harjubarout', 'vaasaflemari', 'n', 0, NULL);
INSERT INTO Passage VALUES ('harjubars', 'harjubarout', 'flemarikuja', 's', 0, NULL);
INSERT INTO Passage VALUES ('harjubarenter', 'harjubarout', 'harjubarin', 'in', 0, 'You tried to get in, but the bouncer stopped you..');
INSERT INTO Passage VALUES ('harjubarexit', 'harjubarin', 'harjubarout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('flemarikujan', 'flemarikuja', 'harjubarout', 'n', 0, NULL);
INSERT INTO Passage VALUES ('flemarikujae', 'flemarikuja', 'helsinginkuja4', 'e', 0, NULL);
INSERT INTO Passage VALUES ('flemarikujas', 'flemarikuja', 'hesariflemari', 's', 0, NULL);

INSERT INTO Passage VALUES ('helsinginkuja4w', 'helsinginkuja4', 'flemarikuja', 'w', 0, NULL);
INSERT INTO Passage VALUES ('helsinginkuja4e', 'helsinginkuja4', 'kustaakuja', 'e', 0, NULL);

INSERT INTO Passage VALUES ('hesariflemariw', 'hesariflemari', 'bar21out', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hesariflemarin', 'hesariflemari', 'flemarikuja', 'n', 0, NULL);
INSERT INTO Passage VALUES ('hesariflemarie', 'hesariflemari', 'tenkkaout', 'e', 0, NULL);

INSERT INTO Passage VALUES ('bar21e', 'bar21out', 'hesariflemari', 'e', 0, NULL);
INSERT INTO Passage VALUES ('bar21enter', 'bar21out', 'bar21in', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('bar21exit', 'bar21in', 'bar21out', 'out', 0, NULL);

INSERT INTO Passage VALUES ('tenkkaw', 'tenkkaout', 'hesariflemari','w', 0, NULL);
INSERT INTO Passage VALUES ('tenkkae', 'tenkkaout', 'tenhoout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('tenkkaenter', 'tenkkaout', 'tenkkain', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('tenkkaexit', 'tenkkain', 'tenkkaout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('tenhow', 'tenhoout', 'tenkkaout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('tenhoe', 'tenhoout', 'relaxinout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('tenhoenter', 'tenhoout', 'tenhoin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('tenhoexit', 'tenhoin', 'tenhoout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('relaxinw', 'relaxinout', 'tenhoout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('relaxine', 'relaxinout', 'hesarikustaa', 'e', 0, NULL);
INSERT INTO Passage VALUES ('relaxinenter', 'relaxinout', 'relaxinin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('relaxinexit', 'relaxinin', 'relaxinout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('hesarikustaaw', 'hesarikustaa', 'relaxinout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hesarikustaae', 'hesarikustaa', 'paakonttoriout', 'e', 0, NULL);
INSERT INTO Passage VALUES ('hesarikustaan', 'hesarikustaa', 'kustaakuja', 'n', 0, NULL);

INSERT INTO Passage VALUES ('kustaakujan', 'kustaakuja', 'vaasakustaa', 'n', 0, NULL);
INSERT INTO Passage VALUES ('kustaakujas', 'kustaakuja', 'hesarikustaa', 's', 0, NULL);
INSERT INTO Passage VALUES ('kustaakujaw', 'kustaakuja', 'helsinginkuja4', 'w', 0, NULL);

INSERT INTO Passage VALUES ('paakonttoriw', 'paakonttoriout', 'hesarikustaa', 'w', 0, NULL);
INSERT INTO Passage VALUES ('paakonttorie', 'paakonttoriout', 'hesari9', 'e', 0, NULL);
INSERT INTO Passage VALUES ('paakonttorienter', 'paakonttoriout', 'paakonttoriin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('paakonttoriexit', 'paakonttoriin', 'paakonttoriout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('hesari9w', 'hesari9', 'paakonttoriout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hesari9e', 'hesari9', 'fairytaleout', 'e', 0, NULL);

INSERT INTO Passage VALUES ('fairytalew', 'fairytaleout', 'hesari9', 'w', 0, NULL);
INSERT INTO Passage VALUES ('fairytalee', 'fairytaleout', 'hesariharju', 'e', 0, NULL);
INSERT INTO Passage VALUES ('fairytaleenter', 'fairytaleout', 'fairytalein', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('fairytaleexit', 'fairytalein', 'fairytaleout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('hesariharjuw', 'hesariharju', 'fairytaleout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hesariharjun', 'hesariharju', 'harjukatu3', 'n', 0, NULL);
INSERT INTO Passage VALUES ('hesariharjue', 'hesariharju', 'hesari5', 'e', 0, NULL);

INSERT INTO Passage VALUES ('hesari5w', 'hesari5', 'hesariharju', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hesari5e', 'hesari5', 'lepakkomiesout', 'e', 0, NULL);

INSERT INTO Passage VALUES ('lepakkomiesw', 'lepakkomiesout', 'hesari5', 'w', 0, NULL);
INSERT INTO Passage VALUES ('lepakkomiese', 'lepakkomiesout', 'hesaripenger', 'e', 0, NULL);
INSERT INTO Passage VALUES ('lepakkomiesenter', 'lepakkomiesout', 'lepakkomiesin', 'in', 0, 'You tried to get in, but the bouncer stopped you.');
INSERT INTO Passage VALUES ('lepakkomiesexit', 'lepakkomiesin', 'lepakkomiesout', 'out', 0, NULL);

INSERT INTO Passage VALUES ('hesaripengerw', 'hesaripenger', 'lepakkomiesout', 'w', 0, NULL);
INSERT INTO Passage VALUES ('hesaripengern', 'hesaripenger', 'vaasanaukio', 'n', 0, NULL);

INSERT INTO Object VALUES (0, 'funnel', 'The longer the hose, the greater the dose. What can I combine this with?', TRUE, NULL, NULL, 'hesariflemari');
INSERT INTO Object VALUES (1, 'sponge', 'This should come in handy. Better hold on to it.', TRUE, NULL, NULL, 'kustaakuja');
INSERT INTO Object VALUES (2, 'lasol', 'A bottle of windscreen washer fluid. My liver could use some cleaning, but I need something else to go with it.', TRUE, NULL, NULL, 'iltakouluout');
INSERT INTO Object VALUES (3, 'knife', 'This should give me an edge.', TRUE, NULL, NULL, NULL);
INSERT INTO Object VALUES (4, 'grandma', 'I am going to hell anyways, might as well rob that grandma.', TRUE, NULL, NULL, 'siimabarout');
INSERT INTO Object VALUES (5, 'grandma', 'That granny looks like she could have a few coins to spare. Maybe I could rob her.', TRUE, NULL, NULL, 'bartappenout');
INSERT INTO Object VALUES (6, 'grandma', 'A sweet old grandma holding on to her purse. Maybe I could rob her.', TRUE, NULL, NULL, 'kultapalmuout');
INSERT INTO Object VALUES (7, 'grandma', 'A sweet old grandma holding on to her purse. Maybe I could rob her.', TRUE, NULL, NULL, 'vaasanaukio');
INSERT INTO Object VALUES (8, 'grandma', 'A sweet old grandma holding on to her purse. Maybe I could rob her.', TRUE, NULL, NULL, 'hesari5');
INSERT INTO Object VALUES (9, 'grandma', 'Look at that sweet old grandma. Maybe I could rob her.', TRUE, NULL, NULL, 'harjukatu3');
INSERT INTO Object VALUES (10, 'grandma', 'A sweet old grandma holding on to her purse. Maybe I could rob her.', TRUE, NULL, NULL, 'hesari9');
INSERT INTO Object VALUES (11, 'grandma', 'To rob, or not to rob. That is the question.', TRUE, NULL, NULL, 'tenkkaout');
INSERT INTO Object VALUES (12, 'grandma', 'A sweet old grandma holding on to her purse. Maybe I could rob her.', TRUE, NULL, NULL, 'helsinginkuja4');
INSERT INTO Object VALUES (13, 'grandma', 'Well, well. I bet that nice old grandma has some coins for me. Maybe I could rob her.', TRUE, NULL, NULL, 'flemarikuja');
INSERT INTO Object VALUES (14, 'bodybuilder', 'A sweaty looking bodybuilder. I can see his wallet, but I couldn\'t beat him in a fair fight.', TRUE, NULL, NULL, 'barmolotowout');
INSERT INTO Object VALUES (15, 'bodybuilder', 'A sweaty looking bodybuilder. I can see his wallet, but I couldn\'t beat him in a fair fight.', TRUE, NULL, NULL, 'kustaavaasaout');
INSERT INTO Object VALUES (16, 'bodybuilder', 'A sweaty looking bodybuilder. I can see his wallet, but I couldn\'t beat him in a fair fight.', TRUE, NULL, NULL, 'lepakkomiesout');
INSERT INTO Object VALUES (17, 'bodybuilder', 'A sweaty looking bodybuilder. I can see his wallet, but I couldn\'t beat him in a fair fight.', TRUE, NULL, NULL, 'paakonttoriout');
INSERT INTO Object VALUES (18, 'bodybuilder', 'A sweaty looking bodybuilder. I can see his wallet, but I couldn\'t beat him in a fair fight.', TRUE, NULL, NULL, 'bar21out');
INSERT INTO Object VALUES (19, 'slot machine', 'It\'s a slot machine. I could play it and win or lose all of my money.', TRUE, NULL, NULL, 'ontherocksin');
INSERT INTO Object VALUES (20, 'slot machine', 'It\'s a slot machine. I could play it and win or lose all of my money.', TRUE, NULL, NULL, 'kalliohoviin');
INSERT INTO Object VALUES (21, 'slot machine', 'It\'s a slot machine. I could play it and win or lose all of my money.', TRUE, NULL, NULL, 'lepakkomiesin');
INSERT INTO Object VALUES (22, 'slot machine', 'It\'s a slot machine. I could play it and win or lose all of my money.', TRUE, NULL, NULL, 'tenhoin');
INSERT INTO Object VALUES (23, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'vivalavidaout');
INSERT INTO Object VALUES (24, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'bartappenout');
INSERT INTO Object VALUES (25, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'kallionb12out');
INSERT INTO Object VALUES (26, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'solmupubout');
INSERT INTO Object VALUES (27, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'hilpeahaukiout');
INSERT INTO Object VALUES (28, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'vaasapenger');
INSERT INTO Object VALUES (29, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'vaasanaukio');
INSERT INTO Object VALUES (30, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'fairytaleout');
INSERT INTO Object VALUES (31, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'relaxinout');
INSERT INTO Object VALUES (32, 'trash bin', 'Maybe I could search it and find something inside.', TRUE, NULL, NULL, 'harjubarout');
INSERT INTO Object VALUES (33, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'iltakouluin');
INSERT INTO Object VALUES (34, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'hilpeahaukiin');
INSERT INTO Object VALUES (35, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'kultapalmuin');
INSERT INTO Object VALUES (36, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'solmupubin');
INSERT INTO Object VALUES (37, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'kustaavaasain');
INSERT INTO Object VALUES (38, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'kalliohoviin');
INSERT INTO Object VALUES (39, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'kallionb12in');
INSERT INTO Object VALUES (40, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'bartappenin');
INSERT INTO Object VALUES (41, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'heinahattuin');
INSERT INTO Object VALUES (42, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'siimabarin');
INSERT INTO Object VALUES (43, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'vivalavidain');
INSERT INTO Object VALUES (44, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'barmolotowin');
INSERT INTO Object VALUES (45, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'ontherocksin');
INSERT INTO Object VALUES (46, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'harjubarin');
INSERT INTO Object VALUES (47, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'bar21in');
INSERT INTO Object VALUES (48, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'tenkkain');
INSERT INTO Object VALUES (49, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'tenhoin');
INSERT INTO Object VALUES (50, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'relaxinin');
INSERT INTO Object VALUES (51, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'paakonttoriin');
INSERT INTO Object VALUES (52, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'fairytalein');
INSERT INTO Object VALUES (53, 'bar counter', 'It\'s a bar counter. I need something to drink now!', TRUE, NULL, NULL, 'lepakkomiesin');