USE tempdb;
GO    
BEGIN
    DECLARE @DBNAME AS VARCHAR(MAX) = 'SoccerLeague'
    IF EXISTS(SELECT * FROM sys.databases WHERE Name = @DBNAME)
    BEGIN
        -- Disconnect all users and recreate database.
        EXEC('ALTER DATABASE ' + @DBNAME + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE');
        EXEC('DROP DATABASE ' + @DBNAME);
    END;
        EXEC('CREATE DATABASE ' + @DBNAME);    
END;
USE SoccerLeague;   -- Change to your database name (USE does not allow variables)
GO


CREATE TABLE Nationality (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	UNIQUE([Name])
)

CREATE TABLE Nationsleague (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	CreatedOn DATE NOT NULL,
	NationalityId INTEGER NOT NULL,
	LeagueID INTEGER NOT NULL,
	FOREIGN KEY (NationalityId) REFERENCES Nationality(Id),
	FOREIGN KEY (LeagueID) REFERENCES Nationsleague(Id),
	UNIQUE (Name),
	CHECK (YEAR(CreatedOn) > 1700)

);

CREATE TABLE Team (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL UNIQUE,
	NationsleagueID INTEGER,
	UNIQUE (Name),
	FOREIGN KEY (NationsleagueID) REFERENCES Nationsleague(Id)
);


CREATE TABLE Trainer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	Firstname VARCHAR(50) NOT NULL,
	Lastname VARCHAR(50) NOT NULL,
	BirthDate DATE NOT NULL,
	NationalityId INTEGER,
	FOREIGN KEY (NationalityId) REFERENCES Nationality(Id),
	CHECK (Year(BirthDate) > 1950)
);

CREATE TABLE Player (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	Firstname VARCHAR(50) NOT NULL,
	Lastname VARCHAR(50) NOT NULL,
	BirthDate DATE NOT NULL,
	NationalityId INTEGER,
	FOREIGN KEY (NationalityId) REFERENCES Nationality(Id),
	CHECK (Year(BirthDate) > 1950)
);

CREATE TABLE TeamTrainer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	TrainerFrom DATE NOT NULL,
	TrainerTo DATE,
	TrainerId INTEGER NOT NULL,
	TeamId INTEGER NOT NULL,
	FOREIGN KEY (TrainerId) REFERENCES Trainer(Id),
	FOREIGN KEY (TeamId) REFERENCES Team(Id)
);

CREATE TABLE Game (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	HomeTeam INTEGER NOT NULL,
	AwayTeam INTEGER NOT NULL,
	Value VARCHAR (MAX) NOT NULL,
	FOREIGN KEY (HomeTeam) REFERENCES Team(Id),
	FOREIGN KEY (AwayTeam) REFERENCES Team(Id)
);

CREATE TABLE TeamPlayer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	PlayerFrom DATE NOT NULL,
	PlayerTo DATE,
	PlayerId INTEGER,
	TeamId INTEGER,
	FOREIGN KEY (PlayerId) REFERENCES Player(Id),
	FOREIGN KEY (TeamId) REFERENCES Team(Id)
);

CREATE TABLE Goals (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Minute] INTEGER NOT NULL,
	GameId INTEGER NOT NULL,
	TeamPlayerId INTEGER NOT NULL,
	FOREIGN KEY (GameId) REFERENCES Game(Id),
	FOREIGN KEY (TeamPlayerId) REFERENCES TeamPlayer(Id),
	CONSTRAINT GoalInGame CHECK ([Minute] > 0 and [Minute] < 120)
);

INSERT INTO Nationality ([Name]) VALUES ('Germany');
INSERT INTO Nationality ([Name]) VALUES ('France');
INSERT INTO Nationality ([Name]) VALUES ('Spain');
INSERT INTO Nationality ([Name]) VALUES ('Brazil');
INSERT INTO Nationality ([Name]) VALUES ('Argentina');
INSERT INTO Nationality ([Name]) VALUES ('Italy');
INSERT INTO Nationality ([Name]) VALUES ('England');
INSERT INTO Nationality ([Name]) VALUES ('Portugal');
INSERT INTO Nationality ([Name]) VALUES ('Netherlands');
INSERT INTO Nationality ([Name]) VALUES ('Belgium');
INSERT INTO Nationality ([Name]) VALUES ('Japan');
INSERT INTO Nationality ([Name]) VALUES ('China');
INSERT INTO Nationality ([Name]) VALUES ('Switzerland');
INSERT INTO Nationality ([Name]) VALUES ('Sweden');
INSERT INTO Nationality ([Name]) VALUES ('USA');
INSERT INTO Nationality ([Name]) VALUES ('Mexico');
INSERT INTO Nationality ([Name]) VALUES ('Russia');
INSERT INTO Nationality ([Name]) VALUES ('Korea');
INSERT INTO Nationality ([Name]) VALUES ('Scottland');

INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Premier League', '1992-05-27', 7, 1);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('La Liga', '1929-01-01', 3, 2);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Bundesliga', '1962-07-28', 1, 3);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Serie A', '1898-01-01', 6, 4);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Ligue 1', '1932-01-01', 2, 5);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Eredivisie', '1956-01-01', 9, 6);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Primeira Liga', '1934-01-01', 8, 7);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Superliga', '1897-01-08', 13, 8);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Scottish Premiership', '2013-08-02', 19, 9);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('J1 League', '1992-01-01', 11, 10);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Major League Soccer', '1993-12-17', 15, 11);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Brasileirão Série A', '1959-08-23', 4, 12);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Russian Premier League', '2001-08-27', 17, 13);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Superliga Argentina', '1891-01-01', 5, 14);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Liga MX', '1943-10-17', 16, 15);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Chinese Super League', '2004-01-01', 12, 16);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('K League 1', '1983-01-01', 18, 17);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Allsvenskan', '1924-01-13', 14, 18);
INSERT INTO Nationsleague ([Name], CreatedOn, NationalityId, LeagueID) VALUES ('Belgian First Division A', '1895-01-01', 10, 19);

INSERT INTO Team ([Name], NationsleagueID) VALUES ('Real Madrid', 2);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('FC Barcelona', 2);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Manchester United', 1);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Liverpool FC', 1);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Bayern Munich', 3);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Paris Saint-Germain', 5);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Juventus', 4);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('AC Milan', 4);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Manchester City', 1);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Chelsea FC', 1);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Arsenal FC', 1);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Tottenham Hotspur', 1);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Real Betis', 2);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Sevilla FC', 2);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Atletico Madrid', 2);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Valencia CF', 2);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Ajax Amsterdam', 6);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Feyenoord', 6);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('PSV Eindhoven', 6);
INSERT INTO Team ([Name], NationsleagueID) VALUES ('Benfica', 7);


INSERT INTO Game VALUES (3, 2, '{"gameday": 1, "gamedate": "2023-05-11"}');
INSERT INTO Game VALUES (1, 4, '{"gameday": 2, "gamedate": "2023-05-12"}');
INSERT INTO Game VALUES (6, 5, '{"gameday": 3, "gamedate": "2023-05-13"}');
INSERT INTO Game VALUES (7, 9, '{"gameday": 4, "gamedate": "2023-05-14"}');
INSERT INTO Game VALUES (10, 8, '{"gameday": 5, "gamedate": "2023-05-15"}');
INSERT INTO Game VALUES (11, 12, '{"gameday": 6, "gamedate": "2023-05-16"}');


SELECT
    g.Id, g.HomeTeam, g.AwayTeam,
    JSON_VALUE(g.Value, '$.gameday') AS GameDay,
    JSON_VALUE(g.Value, '$.gamedate') AS GameDate
FROM Game g;

SELECT *
FROM Game g CROSS APPLY OPENJSON (g.Value)
WITH (
    GameDay INTEGER '$.gameday',
    GameDate DATE '$.gamedate'
);

