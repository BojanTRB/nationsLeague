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
	LeagueID INTEGER,
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
	AdditionalAttributes VARCHAR (MAX) NOT NULL,
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

GO
CREATE VIEW GameView AS
SELECT
    g.Id,
    g.HomeTeam,
    g.AwayTeam,
    JSON_VALUE(g.AdditionalAttributes, '$.GameDay') AS GameDay,
    JSON_VALUE(g.AdditionalAttributes, '$.GameDate') AS GameDate
FROM
    Game g;
GO



SELECT *
FROM Game g CROSS APPLY OPENJSON (g.AdditionalAttributes)
WITH (
    GameDay INTEGER '$.GameDay',
    GameDate DATE '$.GameDate'
);
